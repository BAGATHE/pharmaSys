package controller.unite;

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
import repository.UniteRepository;

@WebServlet("/unite/insert")
public class UniteInsertController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String nom = (String) request.getParameter("nom");
            String id_unite_mere = (String) request.getParameter("unite_mere");
            if (id_unite_mere == null || id_unite_mere.trim().isEmpty()) {
                id_unite_mere = null;
            }

            Unite unite = new Unite(nom, id_unite_mere);
            int result = UniteRepository.save(connection, unite);
            connection.commit();
            String message = (result == 1) ? "insertion reussi" : "insertion invalide";
            request.setAttribute("message", message);
            request.setAttribute("unites", UniteRepository.getAllUniteMere(connection));

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/unite/insertion.jsp");
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
            request.setAttribute("unites", UniteRepository.getAllUniteMere(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/unite/insertion.jsp");
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
