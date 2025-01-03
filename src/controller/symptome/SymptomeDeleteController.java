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

@WebServlet("/symptomes/delete")
public class SymptomeDeleteController extends HttpServlet {
    /*** DELETE ***/
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
            String id_Symptome = request.getParameter("id_symptomes");
            String message = null;

            try {
                 int result = SymptomeRepository.delete(connection, id_Symptome);

                if (result > 0) {
                    connection.commit();
                    message = "Symptome supprimé avec succès.";
                } else {
                    connection.rollback();
                    message = "Aucune Symptome trouvé avec l'ID spécifié.";
                }
            } catch (Exception e) {
                connection.rollback();
                message = "Erreur lors de la suppression : Violation des Relations ";
            }

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

            request.setAttribute("message", message);
            request.setAttribute("symptomes", symptomes);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

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
