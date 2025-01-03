package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Symptome;

public class SymptomeRepository {

    public static Symptome[] getSymptomeByIdMaladie(Connection conn, String id) throws SQLException {
        String query = "SELECT " +
                       "ms.id_symptomes AS id_symptome, " +
                       "s.nom AS nom_symptom " +
                       "FROM maladies_symptomes ms " +
                       "INNER JOIN symptomes s " +
                       "ON ms.id_symptomes = s.id_symptomes " +
                       "WHERE ms.id_maladie = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Symptome> symptomes = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, id);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Symptome temp = new Symptome(
                        rs.getString("id_symptome"),
                        rs.getString("nom_symptom"));
                symptomes.add(temp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return symptomes.toArray(new Symptome[0]);
    }
    

    public static Symptome[] getByNom(Connection conn, String nom, int startIndex, int pageSize) throws SQLException {
        List<Symptome> symptomes = new ArrayList<>();
        String query = "SELECT * FROM symptomes WHERE nom LIKE ? LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + nom + "%"); // Rechercher par nom (partie du nom avec wildcards)
            stmt.setInt(2, pageSize); // Limiter le nombre de résultats par page
            stmt.setInt(3, startIndex); // Décalage pour la pagination

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    symptomes.add(new Symptome(rs.getString("id_symptomes"), rs.getString("nom")));
                }
            }
        }
        return symptomes.toArray(new Symptome[0]);
    }

    public static Symptome[] getAllPaginated(Connection conn, int startIndex, int pageSize) throws SQLException {
        List<Symptome> symptomes = new ArrayList<>();
        String query = "SELECT * FROM symptomes LIMIT ? OFFSET ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, pageSize);
            stmt.setInt(2, startIndex);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    symptomes.add(new Symptome(rs.getString("id_symptomes"), rs.getString("nom")));
                }
            }
        }
        return symptomes.toArray(new Symptome[0]);
    }

    public static int getTotalCount(Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM symptomes";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public static Symptome getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM symptomes WHERE id_symptomes = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Symptome(rs.getString("id_symptomes"), rs.getString("nom"));
            }
        }
        return null;
    }

    public static Symptome[] getAll(Connection conn) throws SQLException {
        List<Symptome> symptomes = new ArrayList<>();
        String query = "SELECT * FROM symptomes";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                symptomes.add(new Symptome(rs.getString("id_symptomes"), rs.getString("nom")));
            }
        }
        return symptomes.toArray(new Symptome[0]);
    }

    public static int save(Connection conn, Symptome symptome) throws SQLException {
        String query = "INSERT INTO symptomes (nom) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, symptome.getNom());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static int update(Connection conn, Symptome symptome) throws SQLException {
        String query = "UPDATE symptomes SET nom = ? WHERE id_symptomes = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, symptome.getNom());
            stmt.setString(2, symptome.getIdSymptome());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static int delete(Connection conn, String id) throws SQLException {
        String query = "DELETE FROM symptomes WHERE id_symptomes = ?";
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