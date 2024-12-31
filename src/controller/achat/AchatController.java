package controller.achat;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.Connexion;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Achat;
import model.AchatDetail;
import model.Laboratoire;
import model.Medicament;
import model.MedicamentLaboratoire;
import model.MouvementStock;
import model.StockMedicament;
import model.Unite;
import repository.AchatDetailRepository;
import repository.AchatRepository;
import repository.MedicamentLaboratoireRepository;
import repository.MouvementStockRepository;
import repository.StockMedicamentRepository;

@WebServlet("/achat/laboratoire/insert")
public class AchatController extends HttpServlet {
    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        List<AchatDetail> achatDetailsList = new ArrayList<>();
        String message = "";
        String error = "";
        try (Connection connection = Connexion.connect()) {
            String id_laboratoire = (String) request.getParameter("id_laboratoire");
            Date date_commande = Date.valueOf((String) request.getParameter("date_commande"));
            Laboratoire laboratoire = new Laboratoire(id_laboratoire);
            MedicamentLaboratoire[] medicamentLaboratoires = this.getCommandeLaboratoire(request, laboratoire);
            StockMedicament[] stockMedicaments = new StockMedicament[medicamentLaboratoires.length];
            int[] quantite_medicaments = this.getquantiteByMedicament(request);
            Date[] peremption_dates = this.getDatePeremptionByMedicament(request);
            for (int i = 0; i < medicamentLaboratoires.length; i++) {
                MedicamentLaboratoire medLabor = medicamentLaboratoires[i];
                if (quantite_medicaments[i] > medLabor.getMinimumAchat() && quantite_medicaments[i] > 0) {
                    Medicament medicament = medLabor.getMedicament();
                    Unite unite = medLabor.getUnite();
                    double prix_achat = medLabor.getPrixAchat();
                    AchatDetail achatDetail = new AchatDetail("", null, medicament, quantite_medicaments[i], prix_achat,
                            unite);
                    achatDetailsList.add(achatDetail);

                    StockMedicament stm = new StockMedicament("", peremption_dates[i], quantite_medicaments[i],
                            medicament, laboratoire, unite);
                    stockMedicaments[i] = stm;
                } else {
                    error = "Quantite insuffisante pour " + medLabor.getMedicament().getIdMedicament();
                    request.setAttribute("id_laboratoire", id_laboratoire);
                    request.setAttribute("medicament_laboratoires",
                            MedicamentLaboratoireRepository.getMedicamentByIdLaboratoire(connection, id_laboratoire));
                    request.setAttribute("error", error);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/achats/insertion.jsp");
                    dispatcher.forward(request, response);
                }
            }
            if (!achatDetailsList.isEmpty()) {
                Achat achat = new Achat(
                        null,
                        laboratoire,
                        date_commande,
                        achatDetailsList.toArray(new AchatDetail[0]));
                String id_achat = AchatRepository.save(connection, achat);
                achat.setIdAchat(id_achat);

                for (int i = 0; i < achatDetailsList.size(); i++) {
                    AchatDetail achatDetail = achatDetailsList.get(i);
                    StockMedicament stm = stockMedicaments[i];
                    achatDetail.setIdAchat(id_achat);
                    AchatDetailRepository.save(connection, achatDetail);
                    StockMedicamentRepository.save(connection, stm);
                }
                MouvementStock mvs = MouvementStock.genererMouvementStock(achat);
                MouvementStockRepository.save(connection, mvs);
                mvs.genererMouvementStockDetails(achat);
                MouvementStockRepository.saveDetail(connection, mvs);

                connection.commit();
                message = "Achat effectue";
                request.setAttribute("id_laboratoire", id_laboratoire);
                request.setAttribute("medicament_laboratoires",
                        MedicamentLaboratoireRepository.getMedicamentByIdLaboratoire(connection, id_laboratoire));
                request.setAttribute("message", message);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/achats/insertion.jsp");
                dispatcher.forward(request, response);
            } else {
                error = "aucun achat valide a traiter";
                request.setAttribute("id_laboratoire", id_laboratoire);
                request.setAttribute("medicament_laboratoires",
                        MedicamentLaboratoireRepository.getMedicamentByIdLaboratoire(connection, id_laboratoire));
                request.setAttribute("error", error);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/achats/insertion.jsp");
                dispatcher.forward(request, response);
            }
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
            String id_laboratoire = (String) request.getParameter("id_laboratoire");
            request.setAttribute("id_laboratoire", id_laboratoire);
            request.setAttribute("medicament_laboratoires",
                    MedicamentLaboratoireRepository.getMedicamentByIdLaboratoire(connection, id_laboratoire));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/achats/insertion.jsp");
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

    private MedicamentLaboratoire[] getCommandeLaboratoire(HttpServletRequest request, Laboratoire laboratoire) {
        List<MedicamentLaboratoire> mls = new ArrayList<>();
        int nombre_lignes = Integer.parseInt((String) request.getParameter("nombreLignes"));
        for (int i = 0; i < nombre_lignes; i++) {
            String idMedicament = request.getParameter("idMedicament_" + i);
            String idUnite = request.getParameter("idUnite_" + i);
            double prixAchat = Double.parseDouble(request.getParameter("prixAchat_" + i));
            int minimumAchat = Integer.parseInt(request.getParameter("minimumAchat_" + i));
            int quantite = Integer.parseInt(request.getParameter("quantite_" + i));
            if (quantite > 0) {
                Medicament med = new Medicament(idMedicament);
                Unite unite = new Unite(idUnite);
                MedicamentLaboratoire medicament_lab = new MedicamentLaboratoire(med, laboratoire, unite, prixAchat,
                        minimumAchat);
                mls.add(medicament_lab);
            }
        }
        return mls.toArray(new MedicamentLaboratoire[0]);
    }

    private int[] getquantiteByMedicament(HttpServletRequest request) {
        List<Integer> quantites = new ArrayList<>();
        int nombre_lignes = Integer.parseInt(request.getParameter("nombreLignes"));

        for (int i = 0; i < nombre_lignes; i++) {
            try {
                int quantite = Integer.parseInt(request.getParameter("quantite_" + i));
                if (quantite > 0) {
                    quantites.add(quantite);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        return quantites.stream().mapToInt(Integer::intValue).toArray();
    }

    private Date[] getDatePeremptionByMedicament(HttpServletRequest request) {
        List<Date> dates = new ArrayList<>();
        int nombre_lignes = Integer.parseInt(request.getParameter("nombreLignes"));
        for (int i = 0; i < nombre_lignes; i++) {
            String dateString = request.getParameter("date_peremption_" + i);
            if (dateString != null && !dateString.isEmpty()) {
                try {
                    Date date = Date.valueOf(dateString);
                    if (date != null) {
                        dates.add(date);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        return dates.toArray(new Date[0]);
    }

}
