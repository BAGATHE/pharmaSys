package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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

    public static MouvementStock[] getAll(Connection con) throws Exception {
        List<MouvementStock> mouvementStocks = new ArrayList<>();
        String sql = "SELECT * FROM mouvement_stock";
        try (Statement st = con.createStatement()) {
            ResultSet res = st.executeQuery(sql);
            while (res.next()) {
                mouvementStocks.add(new MouvementStock(res.getString("id_mvt"), res.getDate("date_mouvement"), null));
            }
            res.close();
        } catch (Exception e) {
            throw new Exception("Erreur lors de la recuperation des mouvements de stock " + e.getMessage());
        }
        return mouvementStocks.toArray(new MouvementStock[0]);
    }

    public static MouvementStockDetail[] getDetailByIdMouvementStock(Connection con, String idMouvementStock)
            throws Exception {
        List<MouvementStockDetail> mouvementStockDetails = new ArrayList<>();
        String sql = "SELECT * FROM mouvement_stock_details WHERE id_mvt=?";
        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, idMouvementStock);
            ResultSet res = prst.executeQuery();
            while (res.next()) {
                MouvementStockDetail mvts = new MouvementStockDetail();
                mvts.setIdMouvementStock(idMouvementStock);
                mvts.setEntree(res.getDouble("entree"));
                mvts.setSortie(res.getDouble("sortie"));
                mvts.setPrixUnitaire(res.getDouble("prix_unitaire"));
                mvts.setUnite(UniteRepository.getById(con, res.getString("id_unite")));
                mvts.setMedicament(MedicamentRepository.getById(con, res.getString("id_medicament")));
                mvts.setIdMouvementStockDetail(res.getString("id_mvt_stock_detail"));
                mouvementStockDetails.add(mvts);
            }
            res.close();
        }
        return mouvementStockDetails.toArray(new MouvementStockDetail[0]);
    }
}
