package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.commission.Commission;

public class CommissionRepository {

    // Récupérer une commission par ID
    public static Commission getById(Connection conn, String idCommission) throws SQLException {
        String query = "SELECT * FROM commission WHERE id_commission = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, idCommission);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return new Commission(
                        rs.getString("id_commission"),
                        rs.getInt("pourcentage"),
                        rs.getDate("date_debut"),
                        rs.getDate("date_fin")
                );
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }

        return null; // Si aucune commission trouvée
    }

    // Récupérer toutes les commissions
    public static Commission[] getAll(Connection conn) throws SQLException {
        String query = "SELECT * FROM commission";
        List<Commission> commissions = new ArrayList<>();
        Statement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while (rs.next()) {
                commissions.add(new Commission(
                        rs.getString("id_commission"),
                        rs.getInt("pourcentage"),
                        rs.getDate("date_debut"),
                        rs.getDate("date_fin")
                ));
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }

        return commissions.toArray(new Commission[0]);

    }

    // Ajouter une nouvelle commission
    public static int save(Connection conn, Commission commission) throws SQLException {
        String query = "INSERT INTO commission (pourcentage, date_debut, date_fin) VALUES (?, ?, ?)";
        PreparedStatement stmt = null;

        try {
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, commission.getPourcentage());
            stmt.setDate(2, new java.sql.Date(commission.getDateDebut().getTime()));
            stmt.setDate(3, new java.sql.Date(commission.getDateFin().getTime()));

            return stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
        }
    }

    // Mettre à jour une commission
    public static int update(Connection conn, Commission commission) throws SQLException {
        String query = "UPDATE commission SET pourcentage = ?, date_debut = ?, date_fin = ? WHERE id_commission = ?";
        PreparedStatement stmt = null;

        try {
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, commission.getPourcentage());
            stmt.setDate(2, new java.sql.Date(commission.getDateDebut().getTime()));
            stmt.setDate(3, new java.sql.Date(commission.getDateFin().getTime()));
            stmt.setString(4, commission.getIdCommission());

            return stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
        }
    }

    // Supprimer une commission par ID
    public static int deleteById(Connection conn, String idCommission) throws SQLException {
        String query = "DELETE FROM commission WHERE id_commission = ?";
        PreparedStatement stmt = null;

        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, idCommission);

            return stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
        }
    }

    // Récupérer la commission actuelle
    public static Commission getCurrentCommission(Connection conn) throws SQLException {
        String query = "SELECT * FROM commission WHERE date_debut <= CURRENT_DATE AND date_fin >= CURRENT_DATE";

        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return new Commission(
                        rs.getString("id_commission"),
                        rs.getInt("pourcentage"),
                        rs.getDate("date_debut"),
                        rs.getDate("date_fin")
                );
            }
        }

        return null;
    }
}
