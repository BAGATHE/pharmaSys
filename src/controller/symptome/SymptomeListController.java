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
import model.Symptome;
import repository.SymptomeRepository;

@WebServlet("/symptomes/liste")
public class SymptomeListController extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            // Récupérer les paramètres de pagination
            int page = 1;
            int pageSize = 10;

            String pageParam = request.getParameter("page");
            String pageSizeParam = request.getParameter("pageSize");

            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
            if (pageSizeParam != null) {
                pageSize = Integer.parseInt(pageSizeParam);
            }

            // Calcul des indices pour la pagination
            int startIndex = (page - 1) * pageSize;

            // Obtenir les symptômes paginés et le total d'éléments
            Symptome[] symptomes = SymptomeRepository.getAllPaginated(connection, startIndex, pageSize);
            int totalItems = SymptomeRepository.getTotalCount(connection);
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);

            // Ajouter les données dans la requête
            request.setAttribute("symptomes", symptomes);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            // Transférer à la JSP
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

    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            // Récupérer les paramètres de pagination
            int page = 1;
            int pageSize = 10;

            String pageParam = request.getParameter("page");
            String pageSizeParam = request.getParameter("pageSize");
            String nom = request.getParameter("filtrerNom");

            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
            if (pageSizeParam != null || pageSizeParam.equals("")) {
                pageSize = Integer.parseInt(pageSizeParam);
            }

            // Calcul des indices pour la pagination
            int startIndex = (page - 1) * pageSize;

            // Obtenir les symptômes paginés et le total d'éléments
            Symptome[] symptomes = SymptomeRepository.getByNom(connection, nom, startIndex, pageSize);
            int totalItems = SymptomeRepository.getTotalCount(connection);
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);

            // Ajouter les données dans la requête
            request.setAttribute("symptomes", symptomes);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            // Transférer à la JSP
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
