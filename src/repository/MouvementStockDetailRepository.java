package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;

import model.stock.MouvementStockDetail;

public class MouvementStockDetailRepository {
    public static void save(Connection con, MouvementStockDetail detail) throws Exception {
        String sql = "INSERT INTO mouvement_stock_details (id_mvt, id_medicament, entree, sortie, id_unite, prix_unitaire) "
                +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, detail.getIdMouvementStock());
            prst.setString(2, detail.getMedicament().getIdMedicament());
            prst.setInt(3, (int) detail.getEntree());
            prst.setInt(4, (int) detail.getSortie());
            prst.setString(5, detail.getUnite().getIdUnite());
            prst.setDouble(6, detail.getPrixUnitaire());
            prst.executeUpdate();
        } catch (Exception e) {
            throw new Exception("Erreur lors de l'insertion du detail du mouvement de stock : " + e.getMessage());
        }
    }
}
