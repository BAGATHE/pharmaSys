package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.client.Client;

public class ClientRepository {
    // Méthode pour sauvegarder un client
    public static int save(Connection conn, Client client) throws SQLException {
        String query = "INSERT INTO client (nom,type_client) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, client.getNom());
            stmt.setString(2, client.getTypeClient());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    // Méthode pour récupérer tous les clients
    public static Client[] getAll(Connection conn) throws SQLException {
        List<Client> clients = new ArrayList<>();
        String query = "SELECT * FROM client";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Client client = new Client(
                        rs.getString("id_client"),
                        rs.getString("nom"),
                        rs.getString("identifiant"),
                        rs.getString("type_client"),
                        rs.getTimestamp("date_creation"));
                clients.add(client);
            }
        }
        return clients.toArray(new Client[0]);
    }

    // Méthode pour récupérer un client par son ID
    public static Client getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM client WHERE id_client = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Client(
                            rs.getString("id_client"),
                            rs.getString("nom"),
                            rs.getString("identifiant"),
                            rs.getString("type_client"),
                            rs.getTimestamp("date_creation"));
                }
                return null;
            }
        }
    }

    // Méthode pour mettre à jour un client
    public static int update(Connection conn, Client client) throws SQLException {
        String query = "UPDATE client SET nom = ?, identifiant = ?, type_client = ? WHERE id_client = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, client.getNom());
            stmt.setString(2, client.getIdentifiant());
            stmt.setString(3, client.getTypeClient());
            stmt.setString(4, client.getIdClient());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    // Méthode pour supprimer un client par son ID
    public static int delete(Connection conn, String id) throws SQLException {
        String query = "DELETE FROM client WHERE id_client = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }
}
