package controller.maladie;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import connection.Connexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.MaladieRepository;

@WebServlet("/maladies/maladieSymptomeDelete")
public class MaladieSymptomeDeleteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;

        try {
            connection = Connexion.connect();
            String idMaladie = request.getParameter("idMaladie");
            String idSymptome = request.getParameter("idSymptome");

            MaladieRepository.deleteMaladieSymptome(connection, idMaladie, idSymptome);
            connection.commit();
            String redirectUrl = request.getContextPath() + "/maladies/symptome_traitement_liste?idMaladie=" + idMaladie;
            response.sendRedirect(redirectUrl);

        
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
}
