package controller.maladie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import connection.Connexion;
import repository.MaladieRepository;
import model.maladie.MaladieFilter;
import model.maladie.Maladie;

@WebServlet("/maladies/liste")
public class MaladieListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;

        try {
            connection = Connexion.connect();

            String nomMaladie = (request.getParameter("maladie") != null
                    && !request.getParameter("maladie").isEmpty()
                    && !"null".equalsIgnoreCase(request.getParameter("maladie")))
                            ? request.getParameter("maladie")
                            : null;

            String nomSymptome = (request.getParameter("symptome") != null
                    && !request.getParameter("symptome").isEmpty()
                    && !"null".equalsIgnoreCase(request.getParameter("symptome")))
                            ? request.getParameter("symptome")
                            : null;

            String medicament = (request.getParameter("medicament") != null
                    && !request.getParameter("medicament").isEmpty()
                    && !"null".equalsIgnoreCase(request.getParameter("medicament")))
                            ? request.getParameter("medicament")
                            : null;

            String pageParam = request.getParameter("page");
            int pageSize = 3; // Nombre d'éléments par page
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

            MaladieFilter filter = new MaladieFilter(nomMaladie, nomSymptome, medicament, page, pageSize);

            int totalRecords = MaladieRepository.countMaladie(connection, filter);

            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            Maladie[] maladiesArray = MaladieRepository.getAllMaladies(connection, filter);

            request.setAttribute("maladies", maladiesArray);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);

            jakarta.servlet.RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/maladies/liste.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            out.print(e.getMessage());
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    Logger.getLogger(MaladieListController.class.getName()).log(Level.SEVERE,
                            "Erreur lors de la fermeture de la connexion", e);
                }
            }
        }

    }
}
