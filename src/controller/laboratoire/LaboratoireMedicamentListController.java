package controller.laboratoire;

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

@WebServlet("/laboratoire-medicament/list")
public class LaboratoireMedicamentListController extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            String id_laboratoire = (String) request.getParameter("id_laboratoire");
            request.setAttribute("id_laboratoire", id_laboratoire);
            request.setAttribute("medicament_laboratoires",
                    MedicamentLaboratoireRepository.getMedicamentByIdLaboratoire(connection, id_laboratoire));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/laboratoires/detail_laboratoire.jsp");
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
