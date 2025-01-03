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
import repository.SymptomeRepository;
import repository.TraitementRepository;
import model.maladie.Maladie;
import model.maladie.Symptome;
import model.maladie.Traitement;

@WebServlet("/maladies/symptome_traitement_liste")
public class SymptomeTraiteListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;

        try {
            connection = Connexion.connect();
            lister(request, response, connection);
            // if (action.equals("symptome")) {
            // String idMaladie = request.getParameter("idMaladie");

            // Maladie maladie = MaladieRepository.getById(connection, idMaladie);
            // Symptome[] symptomes = SymptomeRepository.getAll(connection);

            // request.setAttribute("maladie", maladie);
            // request.setAttribute("symptomes", symptomes);
            // RequestDispatcher dispatcher =
            // request.getRequestDispatcher("/pages/maladies/ajout_symptome.jsp");
            // dispatcher.forward(request, response);
            // }
            // if (action.equals("traitement")) {
            // String idMaladie = request.getParameter("idMaladie");

            // Maladie maladie = MaladieRepository.getById(connection, idMaladie);
            // request.setAttribute("maladie", maladie);
            // RequestDispatcher dispatcher =
            // request.getRequestDispatcher("/pages/maladies/ajout_traitement.jsp");
            // dispatcher.forward(request, response);
            // }
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

    public void lister(HttpServletRequest request, HttpServletResponse response, Connection connection)
            throws ServletException, IOException {
        String id = (String) request.getAttribute("idMaladie");
        String id2 = request.getParameter("idMaladie");

        String idMaladie = id != null ? id : id2;
        try {
            Symptome[] symptomeArray = SymptomeRepository.getSymptomeByIdMaladie(connection, idMaladie);
            Traitement[] traitementsArray = TraitementRepository.getByMaladieId(connection, idMaladie);
            Maladie maladie = MaladieRepository.getById(connection, idMaladie);

            request.setAttribute("symptomes", symptomeArray);
            request.setAttribute("traitements", traitementsArray);
            request.setAttribute("maladie", maladie);

            jakarta.servlet.RequestDispatcher dispatcher = request
                    .getRequestDispatcher("/pages/maladies/symptome_traitement_liste.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Erreur lors de l'affichage des détails", e);
        }
    }
}
