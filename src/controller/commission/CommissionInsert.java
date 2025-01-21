package controller.recommandation;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import connection.Connexion;
import controller.maladie.MaladieListController;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.commission.Commission;
import repository.CommissionRepository;

@WebServlet("/commission/insert")
public class CommissionInsert extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            int pourcentage = Integer.parseInt( request.getParameter("pourcentage") );
            Date date_debut = Date.valueOf((String) request.getParameter("date_debut"));
            Date date_fin = Date.valueOf((String) request.getParameter("date_fin"));

            Commission commission = new Commission(pourcentage, date_debut, date_fin);

            int result = CommissionRepository.save(connection, commission);
            connection.commit();
            String message = (result == 1) ? "Insertion réussie" : "Insertion invalide";
            request.setAttribute("message", message);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/commission/insertion.jsp");
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;

        try {
            connection = Connexion.connect();
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/commission/insertion.jsp");
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
