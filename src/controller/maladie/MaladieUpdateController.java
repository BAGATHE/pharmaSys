package controller.maladie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import connection.Connexion;
import repository.MaladieRepository;
import model.maladie.Maladie;
import model.maladie.MaladieFilter;

@WebServlet("/maladies/update")
public class MaladieUpdateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = Connexion.connect();

            String maladieIdParam = request.getParameter("idMaladie");
            if (maladieIdParam == null || maladieIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de la maladie manquant.");
                return;
            }

            Maladie maladie = MaladieRepository.getById(connection, maladieIdParam);
            if (maladie == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Maladie non trouvée.");
                return;
            }

            request.setAttribute("maladie", maladie);
            request.getRequestDispatcher("/pages/maladies/update.jsp").forward(request, response);

        } catch (Exception e) {
            Logger.getLogger(MaladieUpdateController.class.getName()).log(Level.SEVERE, null, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur du serveur.");
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    Logger.getLogger(MaladieUpdateController.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = Connexion.connect();

            // Récupérer les paramètres du formulaire
            String idMaladie = request.getParameter("idMaladie");
            String nomMaladie = request.getParameter("nom");
            String descriptionMaladie = request.getParameter("description");

            if (idMaladie ==null || nomMaladie == null || descriptionMaladie == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Données manquantes.");
                return;
            }

            // Mettre à jour la maladie dans la base de données
            Maladie updatedMaladie = new Maladie(idMaladie,nomMaladie, descriptionMaladie);
            int result = MaladieRepository.update(connection, updatedMaladie);

            String message = (result == 1) ? "Maladie mise a jour avec succès" : "Maladie non mise a jour";
            request.setAttribute("message", message);
            connection.commit();

            String pageParam = request.getParameter("page");
            int pageSize = 3; // Nombre d'éléments par page
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

            String nomMaladieFilter = null;
            String nomSymptome = null;
            String medicament = null;

            // Création du filtre pour la recherche
            MaladieFilter filter = new MaladieFilter(nomMaladieFilter, nomSymptome, medicament, page, pageSize);

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
            Logger.getLogger(MaladieUpdateController.class.getName()).log(Level.SEVERE, null, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur du serveur.");
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    Logger.getLogger(MaladieUpdateController.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }
}
