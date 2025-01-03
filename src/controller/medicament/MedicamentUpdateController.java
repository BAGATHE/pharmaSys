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
import repository.MedicamentRepository;

@WebServlet("/medicament/update")
public class MedicamentUpdateController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String nom = (String) request.getParameter("nom");
            String id_medicament = (String) request.getParameter("id_medicament");
            String description = (String) request.getParameter("description");
            Medicament medicament = new Medicament(id_medicament, nom, description);
            int result = MedicamentRepository.update(connection, medicament);

            String message = (result == 1) ? "Medicament mise a jour avec succès" : "Medicament non mise a jour";
            request.setAttribute("message", message);
            request.setAttribute("medicaments", MedicamentRepository.getAll(connection));
            connection.commit();

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/medicaments/liste.jsp");
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
            String id_medicament = request.getParameter("id_medicament");
            request.setAttribute("medicament", MedicamentRepository.getById(connection, id_medicament));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/medicaments/update.jsp");
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
