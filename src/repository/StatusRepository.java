package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.status.Status;

public class StatusRepository {
    public static Status getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM status WHERE id_status = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Status(
                        rs.getString("id_status"),
                        rs.getString("nom"));
            }
        }
        return null;
    }

    public static Status[] getAll(Connection conn) throws SQLException {
        List<Status> statuses = new ArrayList<>();
        String query = "SELECT * FROM status";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                statuses.add(new Status(
                        rs.getString("id_status"),
                        rs.getString("nom")));
            }
        }
        return statuses.toArray(new Status[0]);
    }

    public static int save(Connection conn, Status status) throws SQLException {
        String query = "INSERT INTO status (nom) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status.getNom());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    public static int update(Connection conn, Status status) throws SQLException {
        String query = "UPDATE status SET nom = ? WHERE id_status = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status.getNom());
            stmt.setString(2, status.getIdStatus());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    public static int delete(Connection conn, String id) throws SQLException {
        String query = "DELETE FROM status WHERE id_status = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }
}
