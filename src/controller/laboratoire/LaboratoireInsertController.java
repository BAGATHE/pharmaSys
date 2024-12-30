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
import repository.LaboratoireRepository;

@WebServlet("/laboratoire/insert")
public class LaboratoireInsertController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String nom = (String) request.getParameter("nom");
            String contact = (String) request.getParameter("contact");
            String adresse = (String) request.getParameter("adresse");
            Laboratoire laboratoire = new Laboratoire(nom, contact, adresse);

            int result = LaboratoireRepository.save(connection, laboratoire);
            connection.commit();
            String message = (result == 1) ? "Insertion réussie" : "Insertion invalide";

            request.setAttribute("message", message);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/laboratoires/insertion.jsp");
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/laboratoires/insertion.jsp");
        dispatcher.forward(request, response);
    }
}
