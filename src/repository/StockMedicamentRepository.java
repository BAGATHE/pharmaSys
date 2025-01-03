package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.stock.StockMedicament;

public class StockMedicamentRepository {
    public static void save(Connection con, StockMedicament stockMedicament) throws Exception {
        String sql = "INSERT INTO stock_medicaments (date_peremption, quantite_boite, id_unite, id_laboratoire, id_medicament) "
                +
                "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setDate(1, stockMedicament.getDatePeremption());
            prst.setDouble(2, stockMedicament.getQuantiteBoite());
            prst.setString(3, stockMedicament.getUnite().getIdUnite());
            prst.setString(4, stockMedicament.getLaboratoire().getIdLaboratoire());
            prst.setString(5, stockMedicament.getMedicament().getIdMedicament());
            prst.executeUpdate();
        } catch (Exception e) {
            throw new Exception("Erreur lors de l'insertion du stock de medicament : " + e.getMessage());
        }
    }

    public static StockMedicament[] getAllNonPerimesASC(Connection con) throws Exception {
        List<StockMedicament> stockList = new ArrayList<>();
        String sql = "SELECT * FROM stock_medicaments WHERE date_peremption > CURRENT_DATE ORDER BY date_peremption ASC";

        try (PreparedStatement prst = con.prepareStatement(sql);
                ResultSet rs = prst.executeQuery()) {
            while (rs.next()) {
                StockMedicament stock = new StockMedicament();
                stock.setIdStockMedicament(rs.getString("id_stock_medicament"));
                stock.setDatePeremption(rs.getDate("date_peremption"));
                stock.setQuantiteBoite(rs.getDouble("quantite_boite"));
                stock.setUnite(UniteRepository.getById(con, rs.getString("id_unite")));
                stock.setLaboratoire(LaboratoireRepository.getById(con, rs.getString("id_laboratoire")));
                stock.setMedicament(MedicamentRepository.getById(con, rs.getString("id_medicament")));
                stockList.add(stock);
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la recuperation du stock de medicament non perime : " + e.getMessage());
        }

        return stockList.toArray(new StockMedicament[0]);
    }

    public static void updateStock(Connection con, StockMedicament stockMedicament) throws Exception {
        String sql = "UPDATE stock_medicaments SET quantite_boite = ? WHERE id_stock_medicament=?";

        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setDouble(1, stockMedicament.getQuantiteBoite());
            prst.setString(2, stockMedicament.getIdStockMedicament());
            prst.executeUpdate();
        } catch (Exception e) {
            throw new Exception("Erreur lors de la mise a jour du stock de medicament : " + e.getMessage());
        }
    }
}
