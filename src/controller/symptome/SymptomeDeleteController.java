package controller.symptome;

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
import repository.SymptomeRepository;

@WebServlet("/symptomes/delete")
public class SymptomeDeleteController extends HttpServlet {
    /*** DELETE ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {

            String id_Symptome = request.getParameter("id_symptomes");
            SymptomeRepository.delete(connection, id_Symptome);
            request.setAttribute("symptomes", SymptomeRepository.getAll(connection));
            connection.commit();
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/symptomes/liste.jsp");
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
