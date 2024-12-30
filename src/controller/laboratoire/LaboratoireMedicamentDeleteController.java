package controller.laboratoire;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import connection.Connexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Laboratoire;
import model.Medicament;
import model.MedicamentLaboratoire;
import model.Unite;
import repository.MedicamentLaboratoireRepository;

@WebServlet("/laboratoire-medicament/delete")
public class LaboratoireMedicamentDeleteController extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String id_laboratoire = (String) request.getParameter("id_laboratoire");
            String id_medicament = (String) request.getParameter("id_medicament");
            String id_unite = (String) request.getParameter("id_unite");
            Medicament medicament = new Medicament(id_medicament);
            Laboratoire laboratoire = new Laboratoire(id_laboratoire);
            Unite unite = new Unite(id_unite);

            MedicamentLaboratoire medicamentLaboratoire = new MedicamentLaboratoire(medicament, laboratoire, unite, 0,
                    0);
            MedicamentLaboratoireRepository.delete(connection, medicamentLaboratoire);
            connection.commit();
            response.sendRedirect(
                    request.getContextPath() + "/laboratoire-medicament/list?id_laboratoire=" + id_laboratoire);
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
