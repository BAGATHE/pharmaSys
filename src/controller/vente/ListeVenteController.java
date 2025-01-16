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
import model.maladie.MedicamentFilter;
import model.vente.Vente;
import model.vente.VenteFilter;
import repository.CategorieRepository;
import repository.MaladieRepository;
import repository.MedicamentRepository;
import repository.TraitementRepository;
import repository.TypeMedicamentRepository;
import repository.VenteRepository;

@WebServlet("/vente/list")
public class ListeVenteController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String categorieId = (String) request.getParameter("categorie");
            String typeId = (String) request.getParameter("type");
            String date_debut = (String) request.getParameter("date_debut");
            String date_fin = (String) request.getParameter("date_fin");
            if (categorieId == null && categorieId.isEmpty()) {
                categorieId = "";
            }
            if (typeId == null && typeId.isEmpty()) {
                typeId = "";
            }
            if (date_debut == null && date_debut.isEmpty()) {
                date_debut = "";
            }
            if (date_fin == null && date_fin.isEmpty()) {
                date_fin = "";
            }
            System.out.println(date_debut + " " + date_fin);
            VenteFilter venteFilter = new VenteFilter(typeId, categorieId, date_debut, date_fin);

            if (categorieId.isEmpty() && typeId.isEmpty() && date_debut.isEmpty() && date_fin.isEmpty()) {
                Vente[] ventes = VenteRepository.getAll(connection);
                request.setAttribute("ventes", ventes);
            } else {
                request.setAttribute("ventes", VenteRepository.getAllwithFiltre(connection, venteFilter));
            }

            request.setAttribute("categorie", CategorieRepository.getAll(connection));
            request.setAttribute("types", TypeMedicamentRepository.getAll(connection));

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/ventes/liste.jsp");
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
            Vente[] ventes = VenteRepository.getAll(connection);
            request.setAttribute("ventes", ventes);
            request.setAttribute("categorie", CategorieRepository.getAll(connection));
            request.setAttribute("types", TypeMedicamentRepository.getAll(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/ventes/liste.jsp");
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
