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
import model.status.MedicamentStatusStock;
import repository.MedicamentRepository;
import repository.MedicamentStatusStockRepository;
import repository.StatusRepository;

@WebServlet("/medicament/confstock")
public class MedicamentConfStock extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        try (Connection connection = Connexion.connect()) {
            String idMedicament = request.getParameter("id_medicament");
            request.setAttribute("medicament",
                    MedicamentRepository.getById(connection, idMedicament));
            request.setAttribute("status", StatusRepository.getAll(connection));
            request.setAttribute("medicament_status",
                    MedicamentStatusStockRepository.getByIdMedicament(connection, idMedicament));
            RequestDispatcher dispatcher = request
                    .getRequestDispatcher("/pages/medicaments/conf_stock.jsp");
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
            String idMedicament = request.getParameter("id_medicament");
            String idStatus = request.getParameter("status");
            String minStr = request.getParameter("min");
            String maxStr = request.getParameter("max");

            int min = (minStr != null && !minStr.isEmpty()) ? Integer.parseInt(minStr) : 0;
            int max = (maxStr != null && !maxStr.isEmpty()) ? Integer.parseInt(maxStr) : 0;

            MedicamentStatusStock medicamentStatusStock = new MedicamentStatusStock(idMedicament, idStatus, min, max);

            int exists = MedicamentStatusStockRepository.checkMedicamentStatusStock(connection, medicamentStatusStock);

            if (exists == 0) {
                MedicamentStatusStockRepository.save(connection, medicamentStatusStock);
                out.print("Enregistrement ajouté avec succès");
                request.setAttribute("message", "Enregistrement ajouté avec succès.");
            } else {
                out.print("Cet enregistrement existe déjà.");
                request.setAttribute("message", "Cet enregistrement existe déjà.");
            }
            connection.commit();
            response.sendRedirect(request.getContextPath() + "/medicament/confstock?id_medicament=" + idMedicament);

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
