package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.achat.AchatDetail;
import model.configuration.Unite;
import model.medicament.Medicament;

public class AchatDetailRepository {

    public static AchatDetail[] getByIdAchat(Connection con, String idAchat) throws Exception {
        List<AchatDetail> achatDetails = new ArrayList<>();
        String sql = "SELECT ad.id_achat_details, ad.id_achat, ad.id_medicament, ad.quantite, ad.prix_unitaire, ad.id_unite "
                +
                "FROM achat_details ad " +
                "WHERE ad.id_achat = ?";

        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, idAchat);
            try (ResultSet rs = prst.executeQuery()) {
                while (rs.next()) {
                    String idAchatDetail = rs.getString("id_achat_details");
                    String idMedicament = rs.getString("id_medicament");
                    int quantite = rs.getInt("quantite");
                    double prixAchat = rs.getDouble("prix_unitaire");
                    String idUnite = rs.getString("id_unite");

                    Medicament medicament = MedicamentRepository.getById(con, idMedicament);
                    Unite unite = UniteRepository.getById(con, idUnite);

                    AchatDetail achatDetail = new AchatDetail(idAchatDetail, idAchat, medicament, quantite, prixAchat,
                            unite);
                    achatDetails.add(achatDetail);
                }
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la recuperation des achats details " + e.getMessage());
        }
        return achatDetails.toArray(new AchatDetail[0]);
    }

    public static void save(Connection con, AchatDetail achatDetail) throws Exception {
        String sql = "INSERT INTO achat_details (id_achat, id_medicament, quantite, prix_unitaire, id_unite) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, achatDetail.getIdAchat());
            prst.setString(2, achatDetail.getMedicament().getIdMedicament());
            prst.setInt(3, achatDetail.getQuantite());
            prst.setDouble(4, achatDetail.getPrixAchat());
            prst.setString(5, achatDetail.getUnite().getIdUnite());
            prst.executeUpdate();
        } catch (Exception e) {
            throw new Exception("Erreur lors de l'insertion de l'achat detail : " + e.getMessage());
        }
    }
}
