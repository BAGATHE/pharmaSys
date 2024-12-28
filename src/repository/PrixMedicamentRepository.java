package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Medicament;

public class PrixMedicamentRepository {
    public static Medicament[] getAll(Connection conn) throws SQLException {
        List<Medicament> medicaments = new ArrayList<>();
        String query = "SELECT * FROM symptomes";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                medicaments.add(new Medicament(rs.getString("id_medicament"), rs.getString("nom"),
                        rs.getString("description")));
            }
        }
        return medicaments.toArray(new Medicament[0]);
    }

}
