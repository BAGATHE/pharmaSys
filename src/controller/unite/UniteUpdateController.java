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
import model.Unite;
import repository.UniteRepository;

@WebServlet("/unite/update")
public class UniteUpdateController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String nom = request.getParameter("nom");
            String id_unite = request.getParameter("id_unite");
            Unite unite = new Unite(id_unite, nom);
            int result = UniteRepository.update(connection, unite);

            String message = (result == 1) ? "Unité mise a jour avec succès" : "Unité non mise a jour";
            request.setAttribute("message", message);
            request.setAttribute("unites", UniteRepository.getAll(connection));
            connection.commit();

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/unite/liste.jsp");
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
            String id_unite = request.getParameter("id_unite");
            request.setAttribute("unite", UniteRepository.getById(connection, id_unite));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/unite/update.jsp");
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
