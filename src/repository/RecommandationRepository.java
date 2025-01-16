package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.medicament.Medicament;
import model.recommandation.Recommandation;
import model.recommandation.RecommandationFilter;

public class RecommandationRepository {

    public static int save(Connection conn, Recommandation recommandation) throws SQLException {
        String query = "INSERT INTO recommandation (date_debut, date_fin, id_medicament) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDate(1, new java.sql.Date(recommandation.getDateDebut().getTime()));
            stmt.setDate(2, new java.sql.Date(recommandation.getDateFin().getTime()));
            stmt.setString(3, recommandation.getMedicament().getIdMedicament());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    public static Recommandation[] getAllWithFiltre(Connection conn, RecommandationFilter filter) throws SQLException {
        List<Recommandation> recommandations = new ArrayList<>();
        List<Object> parameters = new ArrayList<>();

        StringBuilder query = new StringBuilder("SELECT * FROM recommandation WHERE 1=1");

        if (filter.getDate() != null && !filter.getDate().isEmpty()) {
            String dateString = filter.getDate();
            query.append(" AND date_debut <= ? AND date_fin >= ?");
            parameters.add(java.sql.Date.valueOf(dateString));
            parameters.add(java.sql.Date.valueOf(dateString));
        }

        if (filter.getIdMedicament() != null && !filter.getIdMedicament().isEmpty()) {
            query.append(" AND id_medicament = ?");
            parameters.add(filter.getIdMedicament());
        }
        if (filter.getYear() > 0) {
            query.append(" AND EXTRACT(YEAR from date_debut) = ? OR EXTRACT(YEAR from date_fin) = ?");
            parameters.add(filter.getYear());
            parameters.add(filter.getYear());
        }

        try (PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Medicament m = MedicamentRepository.getById(conn, rs.getString("id_medicament"));
                    Recommandation recommandation = new Recommandation(
                            rs.getString("id_recommandation"),
                            rs.getDate("date_debut"),
                            rs.getDate("date_fin"),
                            m);
                    recommandations.add(recommandation);
                }
            }
        }

        return recommandations.toArray(new Recommandation[0]);
    }

    public static Recommandation[] getAll(Connection conn) throws SQLException {
        List<Recommandation> recommandations = new ArrayList<>();
        String query = "SELECT * FROM recommandation";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Medicament m = MedicamentRepository.getById(conn, rs.getString("id_medicament"));
                Recommandation recommandation = new Recommandation(
                        rs.getString("id_recommandation"),
                        rs.getDate("date_debut"),
                        rs.getDate("date_fin"),
                        m);
                recommandations.add(recommandation);
            }
        }
        return recommandations.toArray(new Recommandation[0]);
    }

    public static Recommandation getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM recommandation WHERE id_recommandation = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Recommandation(
                            rs.getString("id_recommandation"),
                            rs.getDate("date_debut"),
                            rs.getDate("date_fin"),
                            MedicamentRepository.getById(conn, rs.getString("id_medicament")));
                }
            }
        }
        return null;
    }

    public static int delete(Connection conn, String id) throws SQLException {
        String query = "DELETE FROM recommandation WHERE id_recommandation = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }
}
