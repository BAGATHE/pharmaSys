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
import repository.MedicamentRepository;
import repository.MedicamentStatusStockRepository;
import repository.StatusRepository;

@WebServlet("/medicament/confstock/delete")
public class MedicamentDeleteStatus extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        try (Connection connection = Connexion.connect()) {
            String idMedicament = request.getParameter("id_medicament");

            String idStatus = request.getParameter("id_status");
            MedicamentStatusStockRepository.delete(connection, idMedicament, idStatus);
            connection.commit();
            request.setAttribute("medicament",
                    MedicamentRepository.getById(connection, idMedicament));
            request.setAttribute("status", StatusRepository.getAll(connection));
            request.setAttribute("medicament_status",
                    MedicamentStatusStockRepository.getByIdMedicament(connection, idMedicament));
            RequestDispatcher dispatcher = request
                    .getRequestDispatcher("/medicament/confstock?id_medicament=" + idMedicament);
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
