package controller.vente;

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
import jakarta.servlet.http.HttpSession;
import model.Utilisateur;
import model.client.Client;
import model.medicament.PrixMedicament;
import model.stock.MouvementStock;
import model.vente.Vente;
import model.vente.VenteDetail;
import repository.ClientRepository;
import repository.CommissionRepository;
import repository.MedicamentRepository;
import repository.MouvementStockRepository;
import repository.PrixMedicamentRepository;
import repository.VenteDetailRepository;
import repository.VenteRepository;
import util.Utilitaire;

@WebServlet("/vente/medicament")
public class ListMedicamentController extends HttpServlet {
    /*** GET ***/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try (Connection connection = Connexion.connect()) {
            request.setAttribute("medicaments", MedicamentRepository.getAll(connection));
            request.setAttribute("clients", ClientRepository.getAll(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/ventes/insertion.jsp");
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

    /*** POST ***/
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String message = "";
        String error = "";
        HttpSession session = request.getSession(false);
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        try (Connection connection = Connexion.connect()) {
            Date date_commande = Date.valueOf((String) request.getParameter("date_commande"));
            String id_client = (String) request.getParameter("client");
            int[] quantite_medicaments = this.getquantiteByMedicament(request);
           
            PrixMedicament[] medicaments = this.getCommandeClient(request, connection);
            Vente vente = new Vente("", date_commande, null);
            VenteDetail[] venteDetails = new VenteDetail[medicaments.length];
            int j = 0;

            for (int i = 0; i < medicaments.length; i++) {
                PrixMedicament medicament = medicaments[i];
                double quantite = quantite_medicaments[i];
                VenteDetail venteDetail = new VenteDetail("", "", quantite,
                        medicament.getPrixVenteUnitaire(),
                        medicament.getMedicament(), medicament.getUnite());
                venteDetails[j] = venteDetail;
                j++;

            }

            vente.setVenteDetails(venteDetails);
            vente.setClient(new Client(id_client, "","","",null));
            vente.setIdUserConnected(user.getIdUtilisateur());
            double seuil = Utilitaire.getConfigurationValue("seuil");
            if(vente.getTotal()>seuil){
                vente.setCommissionVendeur(vente.getComissionVendeur(CommissionRepository.getCurrentCommission(connection).getPourcentage()));
            }else{
                vente.setCommissionVendeur(0);
            }
            
            vente.setIdVente(VenteRepository.save(connection, vente));
            for (VenteDetail vd : vente.getVenteDetails()) {
                vd.setIdVente(vente.getIdVente());
                VenteDetailRepository.save(connection, vd);
            }
            vente.fifo(connection);

            MouvementStock mvs = MouvementStock.genererMouvementStock(vente);
            MouvementStockRepository.save(connection, mvs);
            mvs.genererMouvementStockDetails(vente);
            MouvementStockRepository.saveDetail(connection, mvs);
            connection.commit();
            message = "Vente effectue";

            request.setAttribute("medicaments", MedicamentRepository.getAll(connection));
            request.setAttribute("message", message);
            request.setAttribute("clients", ClientRepository.getAll(connection));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/ventes/insertion.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            error = "Erreur SQL : " + e.getMessage();
            try {
                handleError(request, response, error);
            } catch (Exception e1) {
                e1.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
            error = "Erreur générale : " + e.getMessage();
            try {
                handleError(request, response, error);
            } catch (Exception e1) {
                e1.printStackTrace();
            }
        }
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

    private PrixMedicament[] getCommandeClient(HttpServletRequest request, Connection connection)
            throws SQLException {
        List<PrixMedicament> mls = new ArrayList<>();
        try {
            int nombre_lignes = Integer.parseInt(request.getParameter("nombreLignes"));

            for (int i = 0; i < nombre_lignes; i++) {
                String idMedicament = request.getParameter("idMedicament_" + i);
                String idUnite = request.getParameter("unite_" + i);
                String quantiteString = request.getParameter("quantite_" + i);

                if (quantiteString != null && idMedicament != null && idUnite != null) {
                    try {
                        int quantite = Integer.parseInt(quantiteString);
                        if (quantite > 0) {
                            PrixMedicament prixMedicament = PrixMedicamentRepository.getPrixById(connection,
                                    idMedicament, idUnite);
                            if (prixMedicament != null) {
                                mls.add(prixMedicament);
                            } else {
                                System.err.println("Aucun PrixMedicament trouvé pour idMedicament=" + idMedicament
                                        + ", idUnite=" + idUnite);
                            }
                        }
                    } catch (NumberFormatException e) {
                        System.err.println("Quantité invalide pour la ligne " + i + ": " + quantiteString);
                    }
                } else {
                    System.err.println("Paramètres manquants pour la ligne " + i);
                }
            }
        } catch (NumberFormatException e) {
            System.err.println("Nombre de lignes invalide : " + request.getParameter("nombreLignes"));
        }
        return mls.toArray(new PrixMedicament[0]);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String error)
            throws Exception {
        try (Connection connection = Connexion.connect()) {
            request.setAttribute("medicaments", MedicamentRepository.getAll(connection));
        } catch (SQLException e) {
            e.printStackTrace();
            error += " (Échec de la récupération des médicaments : " + e.getMessage() + ")";
        }
        request.setAttribute("error", error);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/ventes/insertion.jsp");
        dispatcher.forward(request, response);
    }
}
