package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.stock.MouvementStock;
import model.stock.MouvementStockDetail;

public class MouvementStockRepository {
    public static void save(Connection con, MouvementStock mouvementStock) throws Exception {
        String sql = "INSERT INTO mouvement_stock (date_mouvement) VALUES (?)";

        try (PreparedStatement prst = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            prst.setDate(1, mouvementStock.getDateMouvementStock());
            prst.executeUpdate();

            try (ResultSet generatedKeys = prst.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    String generatedId = generatedKeys.getString(1);
                    mouvementStock.setIdMouvementStock(generatedId);
                } else {
                    throw new Exception("Echec de l'obtention de l'ID genere pour le mouvement de stock.");
                }
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de l'insertion du mouvement de stock : " + e.getMessage());
        }
    }

    public static void saveDetail(Connection con, MouvementStock mouvementStock) throws Exception {
        try {
            for (MouvementStockDetail mvs : mouvementStock.getMouvementStockDetails()) {
                MouvementStockDetailRepository.save(con, mvs);
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de l'insertion des details du mouvement " + e.getMessage());
        }
    }
}
