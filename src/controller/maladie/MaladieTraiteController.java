package controller.maladie;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import connection.Connexion;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Medicament;
import model.Traitement;
import model.maladie.Maladie;
import repository.MaladieRepository;
import repository.MedicamentRepository;
import repository.TraitementRepository;

@WebServlet("/maladies/maladieTraitement")
public class MaladieTraiteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;

        try {
            connection = Connexion.connect();
            String idMaladie = request.getParameter("idMaladie");
            String message = request.getParameter("message");
            if (message != null) {
                request.setAttribute("message", message);
            }

            Maladie maladie = MaladieRepository.getById(connection, idMaladie);
            Medicament[] medicaments = MedicamentRepository.getAll(connection);

            request.setAttribute("maladie", maladie);
            request.setAttribute("medicaments", medicaments);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/maladies/ajout_traitement.jsp");
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = null;
        try {
            connection = Connexion.connect();
            String idMaladie = request.getParameter("idMaladie");
            String[] medicamentsIds = request.getParameterValues("medicaments[]");
            String[] efficacites = request.getParameterValues("efficacite[]");
            String message = null;

            if (medicamentsIds != null && efficacites != null) {
                for (int i = 0; i < medicamentsIds.length; i++) {
                    Maladie m = MaladieRepository.getById(connection, idMaladie);
                    Medicament medoc = MedicamentRepository.getById(connection, medicamentsIds[i]);
                    Traitement t = new Traitement(m, medoc, Integer.parseInt(efficacites[i]));
                    TraitementRepository.save(connection, t);
                }
                message = "Ajouter avec succes.";
            } else {
                message = "Aucun Medicament sélectionné.";
            }

            connection.commit();
            String redirectUrl = request.getContextPath() + "/maladies/maladieSymptome?idMaladie=" + idMaladie
                    + "&&message=" + message;
            response.sendRedirect(redirectUrl);
        } catch (Exception e) {
            out.print(e.getMessage());
            e.printStackTrace();
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException rollbackEx) {
                Logger.getLogger(SymptomeTraiteListController.class.getName()).log(Level.SEVERE,
                        "Erreur lors du rollback", rollbackEx);
            }
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    Logger.getLogger(SymptomeTraiteListController.class.getName()).log(Level.SEVERE,
                            "Erreur lors de la fermeture de la connexion", e);
                }
            }
        }
    }
}
