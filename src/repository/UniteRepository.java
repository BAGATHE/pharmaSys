package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Unite;

public class UniteRepository {
    public static Unite getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM unites WHERE id_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Unite(rs.getString("id_unite"), rs.getString("nom"));
            }
        }
        return null;
    }

    public static Unite[] getAll(Connection conn) throws SQLException {
        List<Unite> unites = new ArrayList<>();
        String query = "SELECT * FROM unites";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                unites.add(new Unite(rs.getString("id_unite"), rs.getString("nom")));
            }
        }
        return unites.toArray(new Unite[0]);
    }

    public static int save(Connection conn, Unite unite) throws SQLException {
        String query = "INSERT INTO unites (nom) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, unite.getNom());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static int update(Connection conn, Unite unite) throws SQLException {
        String query = "UPDATE unites SET nom = ? WHERE id_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, unite.getNom());
            stmt.setString(2, unite.getIdUnite());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static int delete(Connection conn, String id) throws SQLException {
        String query = "DELETE FROM unites WHERE id_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }
}