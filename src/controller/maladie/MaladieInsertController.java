package controller.maladie;

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
import model.maladie.Maladie;
import repository.MaladieRepository;

@WebServlet("/maladies/insert")
public class MaladieInsertController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            // Récupération des paramètres de la requête
            String nom = request.getParameter("nom");
            String description = request.getParameter("description");
            
            // Création d'un objet Maladie
            Maladie maladie = new Maladie(nom, description);

            // Insertion de la maladie dans la base de données
            int result = MaladieRepository.save(connection, maladie);

            // Message de retour selon le résultat de l'insertion
            String message = (result == 1) ? "Insertion réussie" : "Insertion invalide";

            // Passer le message à la vue JSP
            request.setAttribute("message", message);

            // Validation de la transaction
            connection.commit();

            // Redirection vers la page JSP pour afficher le résultat
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/maladies/insertion.jsp");
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
        // Redirection vers la page JSP pour l'insertion
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/maladies/insertion.jsp");
        dispatcher.forward(request, response);
    }
}
