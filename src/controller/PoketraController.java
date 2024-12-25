package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.sql.Connection;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import connection.Connexion;
import repository.PoketraRepository;
import model.poketra.PoketraFilter;
import model.poketra.Poketra;

@WebServlet("/poketra")
public class PoketraController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;

        try {
            connection = Connexion.connect();
            // recuperation input de recherche
            String nom_poketra = (request.getParameter("nom_poketra") != null
                    && !request.getParameter("nom_poketra").isEmpty()
                    && !"null".equalsIgnoreCase(request.getParameter("nom_poketra")))
                            ? request.getParameter("nom_poketra")
                            : null;

            String id_type_poketra = (request.getParameter("type_poketra") != null
                    && !request.getParameter("type_poketra").isEmpty()
                    && !"null".equalsIgnoreCase(request.getParameter("type_poketra")))
                            ? request.getParameter("type_poketra")
                            : null;

            String id_look_poketra = (request.getParameter("look_poketra") != null
                    && !request.getParameter("look_poketra").isEmpty()
                    && !"null".equalsIgnoreCase(request.getParameter("look_poketra")))
                            ? request.getParameter("look_poketra")
                            : null;

            // Récupération des paramètres de pagination
            String pageParam = request.getParameter("page");
            int pageSize = 3; // Nombre d'éléments par page
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

            PoketraFilter filtrePoketra = new PoketraFilter(nom_poketra, id_type_poketra, id_look_poketra, page,
                    pageSize);

            // Nombre total d'enregistrements pour les critères de recherche donnés
            int totalRecords = PoketraRepository.countPoketra(connection, filtrePoketra);

            // Calcul du nombre total de pages
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            Poketra[] poketraArray = PoketraRepository.getAllPoketra(connection, filtrePoketra);

            request.setAttribute("poketras", poketraArray);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);
            jakarta.servlet.RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/poketra.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            out.print(e.getMessage());
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    Logger.getLogger(PoketraController.class.getName()).log(Level.SEVERE,
                            "Erreur lors de la fermeture de la connexion", e);
                }
            }
        }

    }
}
