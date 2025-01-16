package controller.recommandation;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
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
import model.recommandation.Recommandation;
import repository.MedicamentRepository;
import repository.RecommandationRepository;

@WebServlet("/recommandation/insert")
public class RecommandationInsert extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String medicaString = (String) request.getParameter("medicament");
            Date date_debut = Date.valueOf((String) request.getParameter("date_debut"));
            Date date_fin = Date.valueOf((String) request.getParameter("date_fin"));

            Medicament medicament = new Medicament(medicaString);
            Recommandation recommandation = new Recommandation(date_debut, date_fin, medicament);

            int result = RecommandationRepository.save(connection, recommandation);
            connection.commit();
            String message = (result == 1) ? "Insertion réussie" : "Insertion invalide";
            request.setAttribute("message", message);
            Medicament[] medicaments = MedicamentRepository.getAll(connection);
            request.setAttribute("medicaments", medicaments);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/recommandation/insertion.jsp");
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
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/recommandation/insertion.jsp");
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
