package controller.laboratoire;

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
import model.Laboratoire;
import model.Medicament;
import model.MedicamentLaboratoire;
import model.Unite;
import repository.MedicamentLaboratoireRepository;
import repository.PrixMedicamentRepository;
import repository.UniteRepository;

@WebServlet("/laboratoire-medicament/insert")
public class LaboratoireMedicamentInsertController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            Medicament medicament = new Medicament((String) request.getParameter("medicament"));
            Unite unite = new Unite((String) request.getParameter("unite"));
            double prix_achat = Double.parseDouble((String) request.getParameter("prix"));
            int minimum_achat = Integer.parseInt((String) request.getParameter("minimum_achat"));
            String id_laboratoire = (String) request.getParameter("id_laboratoire");
            Laboratoire laboratoire = new Laboratoire(id_laboratoire);
            MedicamentLaboratoire medicamentLaboratoire = new MedicamentLaboratoire(medicament, laboratoire, unite,
                    prix_achat, minimum_achat);
            int verification = MedicamentLaboratoireRepository.checkMedicamentLaboratoire(connection,
                    medicamentLaboratoire);

            String message;
            String error = null;
            if (verification == 0) {
                int result = MedicamentLaboratoireRepository.save(connection, medicamentLaboratoire);
                connection.commit();
                message = (result == 1) ? "Insertion réussie" : "Insertion invalide";
            } else {
                // Si l'enregistrement existe déjà, on initialise une erreur
                error = "Ce médicament figure deja dans la liste.";
                message = null;
            }

            request.setAttribute("id_laboratoire", id_laboratoire);
            request.setAttribute("medicaments", PrixMedicamentRepository.getAllMedicaments(connection));
            request.setAttribute("unites", UniteRepository.getAllUniteMere(connection));
            request.setAttribute("message", message);
            request.setAttribute("error", error);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/laboratoires/ajout_medicament.jsp");
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
            String id_laboratoire = (String) request.getParameter("id_laboratoire");
            request.setAttribute("id_laboratoire", id_laboratoire);
            request.setAttribute("medicaments", PrixMedicamentRepository.getAllMedicaments(connection));
            request.setAttribute("unites", UniteRepository.getAllUniteMere(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/laboratoires/ajout_medicament.jsp");
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
