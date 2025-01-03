package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.medicament.Laboratoire;

public class LaboratoireRepository {
    public static int save(Connection conn, Laboratoire laboratoire) throws SQLException {
        String query = "INSERT INTO laboratoires (nom,contact,adresse) VALUES (?,?,?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, laboratoire.getNom());
            stmt.setString(2, laboratoire.getContact());
            stmt.setString(3, laboratoire.getAdresse());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static Laboratoire[] getAll(Connection conn) throws SQLException {
        List<Laboratoire> laboratoires = new ArrayList<>();
        String query = "SELECT * FROM laboratoires";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Laboratoire laboratoire = new Laboratoire(rs.getString("id_laboratoire"), rs.getString("nom"),
                        rs.getString("contact"), rs.getString("adresse"));

                laboratoires.add(laboratoire);
            }
        }
        return laboratoires.toArray(new Laboratoire[0]);
    }

    // Récupérer un laboratoire par son ID
    public static Laboratoire getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM laboratoires WHERE id_laboratoire = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Laboratoire(
                            rs.getString("id_laboratoire"),
                            rs.getString("nom"),
                            rs.getString("contact"),
                            rs.getString("adresse"));
                }
                return null;
            }
        }
    }

    public static int update(Connection conn, Laboratoire laboratoire) throws SQLException {
        String query = "UPDATE laboratoires SET nom = ?,contact=?,adresse=? WHERE id_laboratoire = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, laboratoire.getNom());
            stmt.setString(2, laboratoire.getContact());
            stmt.setString(3, laboratoire.getAdresse());
            stmt.setString(4, laboratoire.getIdLaboratoire());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }
}
