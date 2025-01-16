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
import model.vente.VenteDetail;
import repository.VenteDetailRepository;

@WebServlet("/client/vente/detail")
public class ClientVenteDetailController extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String id_vente = (String) request.getParameter("id_vente");
            VenteDetail[] vente_details = VenteDetailRepository.getByIdVente(connection, id_vente);
            request.setAttribute("vente_details", vente_details);
            request.setAttribute("id_client", (String) request.getParameter("id_client"));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/clients/venteDetailClient.jsp");
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
