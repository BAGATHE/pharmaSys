package controller.recommandation;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import connection.Connexion;
import controller.maladie.MaladieListController;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.medicament.Medicament;
import model.recommandation.RecommandationFilter;
import repository.MedicamentRepository;
import repository.RecommandationRepository;

@WebServlet("/recommandation/list")
public class RecommandationList extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            // Récupération et validation des paramètres "mois" et "anner"
            String dateString = request.getParameter("date");
            String idMedicament = request.getParameter("medicament");
            RecommandationFilter filter = new RecommandationFilter(dateString, idMedicament);
            request.setAttribute("recommandations", RecommandationRepository.getAllWithFiltre(connection, filter));
            Medicament[] medicaments = MedicamentRepository.getAll(connection);
            request.setAttribute("medicaments", medicaments);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/recommandation/liste.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            out.print(e.getMessage());
            e.printStackTrace();
            throw new ServletException("Erreur SQL lors du traitement de la requête", e);
        } catch (Exception e) {
            out.print(e.getMessage());
            e.printStackTrace();
            throw new ServletException("Erreur générale lors du traitement de la requête", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;

        try {
            connection = Connexion.connect();
            Medicament[] medicaments = MedicamentRepository.getAll(connection);
            request.setAttribute("medicaments", medicaments);
            request.setAttribute("recommandations", RecommandationRepository.getAll(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/recommandation/liste.jsp");
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
}
