package controller.maladie;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import connection.Connexion;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Symptome;
import model.maladie.Maladie;
import repository.MaladieRepository;
import repository.SymptomeRepository;

@WebServlet("/maladies/maladieSymptome")
public class MaladieSymptomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;

        try {
            connection = Connexion.connect();
            String idMaladie = request.getParameter("idMaladie");
            String message = request.getParameter("message");
            if (message != null) {
                request.setAttribute("message", message);
            }

            Maladie maladie = MaladieRepository.getById(connection, idMaladie);
            Symptome[] symptomes = SymptomeRepository.getAll(connection);

            request.setAttribute("maladie", maladie);
            request.setAttribute("symptomes", symptomes);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/maladies/ajout_symptome.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            out.print(e.getMessage());
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    Logger.getLogger(MaladieListController.class.getName()).log(Level.SEVERE,
                            "Erreur lors de la fermeture de la connexion", e);
                }
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;
        try {
            connection = Connexion.connect();
            String idMaladie = request.getParameter("idMaladie");
            String[] symptomesIds = request.getParameterValues("symptomes[]");
            String message = null;

            if (symptomesIds != null) {
                for (String id : symptomesIds) {
                    MaladieRepository.insertMaladieSymptome(connection, idMaladie, id);
                }
                message = "Insertion reussie.";
            } else {
                message = "Aucun symptôme sélectionné.";
            }

            connection.commit();
            String redirectUrl = request.getContextPath() + "/maladies/maladieSymptome?idMaladie=" + idMaladie
                    + "&&message=" + message;
            response.sendRedirect(redirectUrl);
        } catch (Exception e) {
            out.print(e.getMessage());
            e.printStackTrace();
            try {
                if (connection != null) {
                    connection.rollback(); 
                }
            } catch (SQLException rollbackEx) {
                Logger.getLogger(SymptomeTraiteListController.class.getName()).log(Level.SEVERE,
                        "Erreur lors du rollback", rollbackEx);
            }
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    Logger.getLogger(SymptomeTraiteListController.class.getName()).log(Level.SEVERE,
                            "Erreur lors de la fermeture de la connexion", e);
                }
            }
        }
    }
}
