package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.status.MedicamentStatusStock;

public class MedicamentStatusStockRepository {

    public static int save(Connection conn, MedicamentStatusStock stock) throws SQLException {
        String query = "INSERT INTO medicament_status_stock (id_medicament, id_status, minimum, maximum) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, stock.getIdMedicament());
            stmt.setString(2, stock.getIdStatus());
            stmt.setInt(3, stock.getMinimum());
            stmt.setInt(4, stock.getMaximum());
            return stmt.executeUpdate();
        }
    }

    public static int delete(Connection conn, String idMedicament, String idStatus) throws SQLException {
        String query = "DELETE FROM medicament_status_stock WHERE id_medicament = ? AND id_status = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, idMedicament);
            stmt.setString(2, idStatus);
            return stmt.executeUpdate();
        }
    }

    public static MedicamentStatusStock[] getByIdMedicament(Connection conn, String idMedicament) throws SQLException {
        String query = "SELECT * FROM medicament_status_stock WHERE id_medicament = ?";
        List<MedicamentStatusStock> stocks = new ArrayList<>();

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, idMedicament);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    MedicamentStatusStock medicament_status = new MedicamentStatusStock(
                            rs.getString("id_medicament"),
                            rs.getString("id_status"),
                            rs.getInt("minimum"),
                            rs.getInt("maximum"));
                    medicament_status.setStatus(StatusRepository.getById(conn, rs.getString("id_status")));
                    stocks.add(medicament_status);
                }
            }
        }

        return stocks.toArray(new MedicamentStatusStock[0]);
    }

    public static int checkMedicamentStatusStock(Connection conn, MedicamentStatusStock medicamentStatusStock)
            throws SQLException {
        String query = "SELECT * FROM medicament_status_stock WHERE id_medicament = ? AND id_status = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, medicamentStatusStock.getIdMedicament());
            stmt.setString(2, medicamentStatusStock.getIdStatus());

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? 1 : 0; // Retourne 1 si trouvé, sinon 0
            }
        }
    }
}
