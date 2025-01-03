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
import model.medicament.Laboratoire;
import repository.LaboratoireRepository;

@WebServlet("/laboratoire/update")
public class LaboratoireUpdateController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String id_laboratoire = (String) request.getParameter("id_laboratoire");
            String nom = (String) request.getParameter("nom");
            String contact = (String) request.getParameter("contact");
            String adresse = (String) request.getParameter("adresse");
            Laboratoire laboratoire = new Laboratoire(id_laboratoire, nom, contact, adresse);
            int result = LaboratoireRepository.update(connection, laboratoire);

            String message = (result == 1) ? "information mise a jour avec succès" : "information non mise a jour";
            request.setAttribute("message", message);
            connection.commit();
            request.setAttribute("laboratoires", LaboratoireRepository.getAll(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/laboratoires/liste.jsp");
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
            String id_laboratoire = request.getParameter("id_laboratoire");
            request.setAttribute("laboratoire", LaboratoireRepository.getById(connection, id_laboratoire));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/laboratoires/update.jsp");
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
