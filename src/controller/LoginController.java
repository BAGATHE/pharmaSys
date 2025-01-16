package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Utilisateur;
import repository.UtilisateurRepository;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import connection.Connexion;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;
        try {
            connection = Connexion.connect();
            String email = (String) request.getParameter("email");
            String password = (String) request.getParameter("password");
            Utilisateur utilisateur = UtilisateurRepository.checkUtilisateur(connection, email, password);
            String path = null;
            if (utilisateur != null) {
                path = "/dashboard";
                HttpSession session = request.getSession();
                session.setAttribute("utilisateur", utilisateur);
                response.sendRedirect(request.getContextPath() + path);
            } else {
                path = "index.jsp";
                request.setAttribute("login_erreur", "verifiez bien vos information de connection");
                RequestDispatcher dispatcher = request.getRequestDispatcher(path);
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            out.print(e.getMessage());
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE,
                            "Erreur lors de la fermeture de la connexion", e);
                }
            }
        }

    }

}
