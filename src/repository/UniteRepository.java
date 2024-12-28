package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.TypeUnite;
import model.Unite;

public class UniteRepository {
    public static Unite getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM unites u Join type_unite t on u.id_type_unite = t.id_type_unite WHERE id_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Unite(
                        rs.getString("id_unite"),
                        rs.getString("nom"),
                        new TypeUnite(rs.getString("id_type_unite"), rs.getString("type")));
            }
        }
        return null;
    }

    public static Unite[] getAll(Connection conn) throws SQLException {
        List<Unite> unites = new ArrayList<>();
        String query = "SELECT * FROM unites u Join type_unite t on u.id_type_unite = t.id_type_unite";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                unites.add(
                        new Unite(
                                rs.getString("id_unite"),
                                rs.getString("nom"),
                                new TypeUnite(rs.getString("id_type_unite"), rs.getString("type"))));
            }
        }
        return unites.toArray(new Unite[0]);
    }

    public static int save(Connection conn, Unite unite) throws SQLException {
        String query = "INSERT INTO unites (nom,id_type_unite) VALUES (?,?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, unite.getNom());
            stmt.setString(2, unite.getTypeUnite().getIdTypeUnite());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    public static int update(Connection conn, Unite unite) throws SQLException {
        String query = "UPDATE unites SET nom = ?,id_type_unite=? WHERE id_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, unite.getNom());
            stmt.setString(2, unite.getTypeUnite().getIdTypeUnite());
            stmt.setString(3, unite.getIdUnite());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    public static int delete(Connection conn, String id) throws SQLException {
        String query = "DELETE FROM unites WHERE id_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }
}