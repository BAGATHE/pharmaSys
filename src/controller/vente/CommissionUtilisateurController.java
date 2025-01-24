package controller.vente;

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
import model.commission.VendeurCommissionFilter;
import model.vente.Vente;
import model.vente.VenteFilter;
import repository.CategorieRepository;
import repository.CommissionRepository;
import repository.TypeMedicamentRepository;
import repository.UtilisateurRepository;
import repository.VenteRepository;

@WebServlet("/vente/utilisateurs/commission")
public class CommissionUtilisateurController extends  HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String date_debut = (String) request.getParameter("date_debut");
            String date_fin = (String) request.getParameter("date_fin");
            if (date_debut == null && date_debut.isEmpty()) {
                date_debut = "";
            }
            if (date_fin == null && date_fin.isEmpty()) {
                date_fin = "";
            }
            System.out.println(date_debut + " " + date_fin);
            VendeurCommissionFilter vendeurCommissionFilter = new VendeurCommissionFilter(date_debut, date_fin);
            request.setAttribute("vendeurs", UtilisateurRepository.getAllVendeur(connection, vendeurCommissionFilter));
            request.setAttribute("commissions", CommissionRepository.getCommissionbyGenre(connection, vendeurCommissionFilter));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/ventes/vendeurCommission.jsp");
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
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String date_debut = "";
            String date_fin = "";
          
            VendeurCommissionFilter vendeurCommissionFilter = new VendeurCommissionFilter(date_debut, date_fin);
            request.setAttribute("vendeurs", UtilisateurRepository.getAllVendeur(connection, vendeurCommissionFilter));
            request.setAttribute("commissions", CommissionRepository.getCommissionbyGenre(connection, vendeurCommissionFilter));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/ventes/vendeurCommission.jsp");
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
