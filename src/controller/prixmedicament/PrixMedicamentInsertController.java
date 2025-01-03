package controller.prixmedicament;

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
import model.configuration.Unite;
import model.medicament.Medicament;
import model.medicament.PrixMedicament;
import repository.PrixMedicamentRepository;
import repository.UniteRepository;

@WebServlet("/prixmedicament/insert")
public class PrixMedicamentInsertController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            Medicament medicament = new Medicament((String) request.getParameter("id_medicament"));
            Unite unite = new Unite((String) request.getParameter("unite"));
            double prix_vente = Double.parseDouble((String) request.getParameter("prix_vente"));
            PrixMedicament prix_medicament = new PrixMedicament(medicament, prix_vente, unite);
            int verification = PrixMedicamentRepository.checkUniteMedicament(connection, prix_medicament);

            String message;
            String error = null;
            if (verification == 0) {
                int result = PrixMedicamentRepository.save(connection, prix_medicament);
                connection.commit();
                message = (result == 1) ? "Insertion réussie" : "Insertion invalide";
            } else {
                // Si l'enregistrement existe déjà, on initialise une erreur
                error = "Ce médicament figure deja dans la liste.";
                message = null;
            }

            request.setAttribute("medicaments", PrixMedicamentRepository.getAllMedicaments(connection));
            request.setAttribute("unites", UniteRepository.getAll(connection));
            request.setAttribute("message", message);
            request.setAttribute("error", error);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/prix_medicament/insertion.jsp");
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
            request.setAttribute("medicaments", PrixMedicamentRepository.getAllMedicaments(connection));
            request.setAttribute("unites", UniteRepository.getAll(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/prix_medicament/insertion.jsp");
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
