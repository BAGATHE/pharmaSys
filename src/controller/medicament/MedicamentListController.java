package controller.medicament;

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
import repository.CategorieRepository;
import repository.MaladieRepository;
import repository.MedicamentRepository;
import repository.TraitementRepository;

@WebServlet("/medicament/list")
public class MedicamentListController extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            request.setAttribute("medicaments", MedicamentRepository.getAll(connection));
            request.setAttribute("maladies", MaladieRepository.getAll(connection));
            request.setAttribute("categorie", CategorieRepository.getAll(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/medicaments/liste.jsp");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String categorieId = (String) request.getParameter("categorie");
            String maladieId = (String) request.getParameter("maladie");
            if (categorieId == null && categorieId.isEmpty()) {
                categorieId = "";
            }
            if (maladieId == null && maladieId.isEmpty()) {
                maladieId = "";
            }

            MedicamentFilter medicamentFilter = new MedicamentFilter(maladieId, categorieId);

            if (categorieId.isEmpty() && maladieId.isEmpty()) {
                request.setAttribute("medicaments", MedicamentRepository.getAll(connection));
            } else {
                request.setAttribute("medicaments",
                        TraitementRepository.getAllwithFiltre(connection, medicamentFilter));
            }

            request.setAttribute("maladies", MaladieRepository.getAll(connection));
            request.setAttribute("categorie", CategorieRepository.getAll(connection));

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/medicaments/liste.jsp");
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
