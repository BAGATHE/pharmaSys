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

@WebServlet("/maladies/delete")
public class MaladieDeleteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;

        try {
            connection = Connexion.connect();

            // Récupérer l'ID de la maladie à supprimer
            String maladieIdParam = request.getParameter("idMaladie");
            if (maladieIdParam == null || maladieIdParam.isEmpty()) {
                out.print("L'ID de la maladie est requis.");
                return;
            }


            // Supprimer la maladie avec l'ID donné
            MaladieRepository.delete(connection, maladieIdParam);
            connection.commit();

            // Paramètres de pagination pour rediriger vers la liste après suppression
            String pageParam = request.getParameter("page");
            int pageSize = 3; // Nombre d'éléments par page
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

            // Récupération des paramètres de filtre (si présents)
            String nomMaladie = request.getParameter("nom");
            String nomSymptome = request.getParameter("symptome");
            String medicament = request.getParameter("medicament");

            // Création du filtre pour la recherche
            MaladieFilter filter = new MaladieFilter(nomMaladie, nomSymptome, medicament, page, pageSize);

            // Récupérer le nombre total d'enregistrements après suppression
            int totalRecords = MaladieRepository.countMaladie(connection, filter);

            // Calcul du nombre total de pages
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            // Récupération de la liste des maladies après suppression
            Maladie[] maladiesArray = MaladieRepository.getAllMaladies(connection, filter);

            // Passer les données à la vue JSP
            request.setAttribute("maladies", maladiesArray);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);

            // Rediriger vers la page JSP d'affichage de la liste mise à jour
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
