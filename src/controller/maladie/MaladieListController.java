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

            // Récupération des paramètres de recherche
            String nomMaladie = (request.getParameter("nom") != null
                    && !request.getParameter("nom").isEmpty()
                    && !"null".equalsIgnoreCase(request.getParameter("nom")))
                            ? request.getParameter("nom")
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

            // Paramètres de pagination
            String pageParam = request.getParameter("page");
            int pageSize = 3; // Nombre d'éléments par page
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

            // Création du filtre pour la recherche
            MaladieFilter filter = new MaladieFilter(nomMaladie, nomSymptome, medicament, page, pageSize);

            // Récupérer le nombre total d'enregistrements
            int totalRecords = MaladieRepository.countMaladie(connection, filter);

            // Calcul du nombre total de pages
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            // Récupération de la liste des maladies
            Maladie[] maladiesArray = MaladieRepository.getAllMaladies(connection, filter);

            // Passer les données à la vue JSP
            request.setAttribute("maladies", maladiesArray);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);

            // Rediriger vers la page JSP d'affichage
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
