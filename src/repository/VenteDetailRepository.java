package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.configuration.Unite;
import model.medicament.Medicament;
import model.vente.VenteDetail;

public class VenteDetailRepository {

    public static VenteDetail[] getByIdVente(Connection con, String idVente) throws Exception {
        List<VenteDetail> venteDetails = new ArrayList<>();
        String sql = "SELECT vd.id_vente_detail, vd.id_vente, vd.id_medicament, vd.quantite, vd.prix_unitaire, vd.reduction, vd.id_unite FROM vente_details vd WHERE vd.id_vente = ?";

        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, idVente);
            try (ResultSet rs = prst.executeQuery()) {
                while (rs.next()) {
                    String idVenteDetail = rs.getString("id_vente_detail");
                    String idMedicament = rs.getString("id_medicament");
                    double quantite = rs.getDouble("quantite");
                    double prixUnitaire = rs.getDouble("prix_unitaire");
                    // double reduction = rs.getDouble("reduction");
                    String idUnite = rs.getString("id_unite");

                    Medicament medicament = MedicamentRepository.getById(con, idMedicament);
                    Unite unite = UniteRepository.getById(con, idUnite);

                    VenteDetail venteDetail = new VenteDetail(idVenteDetail, idVente, quantite, prixUnitaire,
                            medicament, unite);
                    venteDetails.add(venteDetail);
                }
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la récupération des détails de la vente : " + e.getMessage());
        }
        return venteDetails.toArray(new VenteDetail[0]);
    }

    public static void save(Connection con, VenteDetail venteDetail) throws Exception {
        String sql = "INSERT INTO vente_details (id_vente, id_medicament, quantite, prix_unitaire, reduction, id_unite) "
                +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, venteDetail.getIdVente());
            prst.setString(2, venteDetail.getMedicament().getIdMedicament());
            prst.setDouble(3, venteDetail.getQuantite());
            prst.setDouble(4, venteDetail.getPrixVente());
            prst.setDouble(5, venteDetail.getReduction());
            prst.setString(6, venteDetail.getUnite().getIdUnite());

            prst.executeUpdate();
        } catch (Exception e) {
            throw new Exception("Erreur lors de l'insertion du détail de la vente : " + e.getMessage());
        }
    }
}
