package controller.achat;

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
import model.achat.AchatDetail;
import repository.AchatDetailRepository;

@WebServlet("/achat/laboratoire/detail")
public class AchatDetailController extends HttpServlet {

    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String id_achat = (String) request.getParameter("id_achat");
            AchatDetail[] achat_details = AchatDetailRepository.getByIdAchat(connection, id_achat);
            request.setAttribute("achat_details", achat_details);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/achats/detail_achat.jsp");
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
