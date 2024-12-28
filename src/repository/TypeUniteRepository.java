package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.TypeUnite;

public class TypeUniteRepository {

    // Méthode pour récupérer un TypeUnite par ID
    public static TypeUnite getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM type_unite WHERE id_type_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new TypeUnite(
                        rs.getString("id_type_unite"),
                        rs.getString("type"));
            }
        }
        return null;
    }

    // Méthode pour récupérer tous les TypeUnite
    public static TypeUnite[] getAll(Connection conn) throws SQLException {
        List<TypeUnite> typeUnites = new ArrayList<>();
        String query = "SELECT * FROM type_unite";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                typeUnites.add(
                        new TypeUnite(
                                rs.getString("id_type_unite"),
                                rs.getString("type")));
            }
        }
        return typeUnites.toArray(new TypeUnite[0]);
    }

    // Méthode pour sauvegarder un nouveau TypeUnite
    public static int save(Connection conn, TypeUnite typeUnite) throws SQLException {
        String query = "INSERT INTO type_unite (id_type_unite, type) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, typeUnite.getIdTypeUnite());
            stmt.setString(2, typeUnite.getType());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    // Méthode pour mettre à jour un TypeUnite
    public static int update(Connection conn, TypeUnite typeUnite) throws SQLException {
        String query = "UPDATE type_unite SET type = ? WHERE id_type_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, typeUnite.getType());
            stmt.setString(2, typeUnite.getIdTypeUnite());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    // Méthode pour supprimer un TypeUnite
    public static int delete(Connection conn, String id) throws SQLException {
        String query = "DELETE FROM type_unite WHERE id_type_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }
}
