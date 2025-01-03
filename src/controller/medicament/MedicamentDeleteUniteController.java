package controller.medicament;

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
import model.configuration.Conversion;
import model.configuration.Unite;
import model.medicament.Medicament;
import repository.ConversionRepository;

@WebServlet("/medicament/unite/delete")
public class MedicamentDeleteUniteController extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String id_unite = request.getParameter("id_unite");
            String id_medicament = (String) request.getParameter("id_medicament");
            Medicament medicament = new Medicament(id_medicament);
            Unite unite = new Unite(id_unite);
            Conversion conversion = new Conversion(medicament, unite, 0);
            ConversionRepository.delete(connection, conversion);
            connection.commit();
            response.sendRedirect(request.getContextPath() + "/medicament/unite?id_medicament=" + id_medicament);
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
