package controller.medicament;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import connection.Connexion;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Medicament;
import model.PrixMedicament;
import model.Unite;
import repository.PrixMedicamentRepository;

@WebServlet("/medicament/prix/update")
public class MedicamentUpdatePrixController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            Unite unite = new Unite((String) request.getParameter("id_unite"));
            String id_prix_medicament = (String) request.getParameter("id_prix_medicament");
            String id_medicament = (String) request.getParameter("id_medicament");
            Medicament medicament = new Medicament(id_medicament);
            double prix_vente = Double.parseDouble((String) request.getParameter("prix_vente"));

            PrixMedicament prix_medicament = new PrixMedicament(id_prix_medicament, medicament, prix_vente, unite);
            int result = PrixMedicamentRepository.update(connection, prix_medicament);

            String message = (result == 1) ? "Prix Medicament mise a jour avec succès"
                    : "Prix Medicament non mise a jour";
            request.setAttribute("message", message);
            request.setAttribute("prix_medicament", PrixMedicamentRepository.getById(connection, id_prix_medicament));
            connection.commit();

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/medicaments/update_prix.jsp");
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

    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String id_prix_medicament = request.getParameter("id_prix_medicament");
            request.setAttribute("prix_medicament", PrixMedicamentRepository.getById(connection, id_prix_medicament));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/medicaments/update_prix.jsp");
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
}
