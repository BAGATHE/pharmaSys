package controller.client;

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
import model.vente.Vente;
import model.vente.VenteFilter;
import repository.CategorieRepository;
import repository.TypeMedicamentRepository;
import repository.VenteRepository;

@WebServlet("/client/vente/list")
public class ClientListVenteController extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String id_client = (String) request.getParameter("id_client");
            request.setAttribute("vente_clients", VenteRepository.getVenteByIdClient(connection, id_client));
            request.setAttribute("id_client", id_client);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/clients/listevente.jsp");
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
            String date_debut = (String) request.getParameter("date_debut");
            String date_fin = (String) request.getParameter("date_fin");
            String id_client = (String) request.getParameter("id_client");

            if (date_debut == null && date_debut.isEmpty()) {
                date_debut = "";
            }
            if (date_fin == null && date_fin.isEmpty()) {
                date_fin = "";
            }
            if (id_client == null && id_client.isEmpty()) {
                id_client = "";
            }
            VenteFilter venteFilter = new VenteFilter("", "", date_debut, date_fin);
            venteFilter.setId_client(id_client);

            if (date_debut.isEmpty() && date_fin.isEmpty()) {
                request.setAttribute("vente_clients", VenteRepository.getVenteByIdClient(connection, id_client));
            } else {
                request.setAttribute("vente_clients", VenteRepository.getAllwithFiltre(connection, venteFilter));
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/clients/listevente.jsp");
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
