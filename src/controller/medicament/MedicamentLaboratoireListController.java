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
import repository.MedicamentLaboratoireRepository;

@WebServlet("/medicament-laboratoire/list")
public class MedicamentLaboratoireListController extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String id_medicament = (String) request.getParameter("id_medicament");
            request.setAttribute("id_laboratoire", id_medicament);
            request.setAttribute("medicament_laboratoires",
                    MedicamentLaboratoireRepository.getMedicamentByIdMedicament(connection, id_medicament));
            RequestDispatcher dispatcher = request
                    .getRequestDispatcher("/pages/medicaments/liste_fournisseur_medicament.jsp");
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
