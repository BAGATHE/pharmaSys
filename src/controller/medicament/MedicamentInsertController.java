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
import model.medicament.Medicament;
import model.medicament.TypeMedicament;
import repository.MedicamentRepository;
import repository.TypeMedicamentRepository;

@WebServlet("/medicament/insert")
public class MedicamentInsertController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String nom = (String) request.getParameter("nom");
            String description = (String) request.getParameter("description");
            String type = (String) request.getParameter("type");
            Medicament medicament = new Medicament(nom, description, new TypeMedicament(type));

            int result = MedicamentRepository.save(connection, medicament);
            connection.commit();
            String message = (result == 1) ? "Insertion réussie" : "Insertion invalide";

            request.setAttribute("message", message);
            request.setAttribute("types", TypeMedicamentRepository.getAll(connection));

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/medicaments/insertion.jsp");
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
            request.setAttribute("types", TypeMedicamentRepository.getAll(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/medicaments/insertion.jsp");
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
