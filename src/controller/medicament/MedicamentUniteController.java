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
import model.Conversion;
import model.Medicament;
import model.Unite;
import repository.ConversionRepository;
import repository.UniteRepository;

@WebServlet("/medicament/unite")
public class MedicamentUniteController extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String id_medicament = (String) request.getParameter("id_medicament");
        try (Connection connection = Connexion.connect()) {
            Conversion[] medicament_unites = ConversionRepository.getConversionsByMedicamentId(connection,
                    id_medicament);
            request.setAttribute("medicament_unites", medicament_unites);
            request.setAttribute("unites", UniteRepository.getAll(connection));
            request.setAttribute("id_medicament", id_medicament);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/medicaments/unite_medicament.jsp");
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

    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String id_medicament = (String) request.getParameter("id_medicament");
        try (Connection connection = Connexion.connect()) {
            Medicament medicament = new Medicament((String) request.getParameter("id_medicament"));
            Unite unite = new Unite((String) request.getParameter("unite_mere"));
            double quantite = Integer.parseInt((String) request.getParameter("quantite"));
            Conversion conversion = new Conversion(medicament, unite, quantite);
            int verification = ConversionRepository.checkUniteMedicament(connection, conversion);

            String message;
            String error = null;
            if (verification == 0) {
                int result = ConversionRepository.save(connection, conversion);
                connection.commit();
                message = (result == 1) ? "Insertion réussie" : "Insertion invalide";
            } else {
                // Si l'enregistrement existe déjà, on initialise une erreur
                error = "Cette unite figure deja dans la liste.";
                message = null;
            }

            request.setAttribute("message", message);
            request.setAttribute("error", error);
            Conversion[] medicament_unites = ConversionRepository.getConversionsByMedicamentId(connection,
                    id_medicament);
            request.setAttribute("medicament_unites", medicament_unites);
            request.setAttribute("unites", UniteRepository.getAll(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/medicaments/unite_medicament.jsp");
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
