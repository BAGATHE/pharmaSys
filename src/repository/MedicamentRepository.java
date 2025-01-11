package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.medicament.Medicament;

public class MedicamentRepository {

    public static int save(Connection conn, Medicament medicament) throws SQLException {
        String query = "INSERT INTO medicaments (nom,description,id_type) VALUES (?,?,?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, medicament.getNom());
            stmt.setString(2, medicament.getDescription());
            stmt.setString(3, medicament.getTypeMedicament().getIdType());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static Medicament[] getAll(Connection conn) throws SQLException {
        List<Medicament> medicaments = new ArrayList<>();
        String query = "SELECT * FROM medicaments";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Medicament medicament = new Medicament(rs.getString("id_medicament"), rs.getString("nom"),
                        rs.getString("description"));

                medicament.setPrixMedicament(
                        PrixMedicamentRepository.getPrixByIdMedicament(conn, medicament.getIdMedicament()));

                medicament.setTypeMedicament(TypeMedicamentRepository.getById(conn, rs.getString("id_type")));
                medicaments.add(medicament);
            }
        }
        return medicaments.toArray(new Medicament[0]);
    }

    public static Medicament getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM medicaments WHERE id_medicament = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Medicament medicament = new Medicament(rs.getString("id_medicament"), rs.getString("nom"),
                        rs.getString("description"));
                medicament.setTypeMedicament(
                        TypeMedicamentRepository.getById(conn, rs.getString("id_type")));
                return medicament;
            }
        }
        return null;
    }

    public static int update(Connection conn, Medicament medicament) throws SQLException {
        String query = "UPDATE medicaments SET nom = ?,description= ? WHERE id_medicament = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, medicament.getNom());
            stmt.setString(2, medicament.getDescription());
            stmt.setString(3, medicament.getIdMedicament());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

}
