package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.UniteDTO;
import model.Unite;

public class UniteRepository {
    public static Unite getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM unites  WHERE id_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Unite(
                        rs.getString("id_unite"),
                        rs.getString("nom"),
                        rs.getString("id_unite_mere"));
            }
        }
        return null;
    }

    public static Unite[] getAll(Connection conn) throws SQLException {
        List<Unite> unites = new ArrayList<>();
        String query = "SELECT * FROM unites ";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                unites.add(
                        new Unite(
                                rs.getString("id_unite"),
                                rs.getString("nom"),
                                rs.getString("id_unite_mere")));
            }
        }
        return unites.toArray(new Unite[0]);
    }

    public static int save(Connection conn, Unite unite) throws SQLException {
        String query = "INSERT INTO unites (nom,id_unite_mere) VALUES (?,?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, unite.getNom());
            stmt.setString(2, unite.getIdUniteMere());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    public static int update(Connection conn, Unite unite) throws SQLException {
        String query = "UPDATE unites SET nom = ?,id_unite_mere=? WHERE id_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, unite.getNom());
            stmt.setString(2, unite.getIdUniteMere());
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

    public static Unite[] getAllUniteMere(Connection conn) throws SQLException {
        List<Unite> unites = new ArrayList<>();
        String query = "SELECT * FROM unites WHERE id_unite_mere IS NULL";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                unites.add(new Unite(
                        rs.getString("id_unite"),
                        rs.getString("nom"),
                        rs.getString("id_unite_mere")));
            }
        }
        return unites.toArray(new Unite[0]);
    }

    public static UniteDTO[] getAllWithParents(Connection conn) throws SQLException {
        List<UniteDTO> uniteDTOList = new ArrayList<>();
        String query = "SELECT * FROM unites_avec_parents";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Unite uniteEnfant = new Unite(
                        rs.getString("id_unite"),
                        rs.getString("nom_unite"),
                        rs.getString("id_unite_mere"));
                Unite uniteParent = null;
                if (rs.getString("id_unite_mere") != null) {
                    uniteParent = new Unite(
                            rs.getString("id_unite_mere"),
                            rs.getString("nom_unite_mere"),
                            null);
                }
                uniteDTOList.add(new UniteDTO(uniteParent, uniteEnfant));
            }
        }
        return uniteDTOList.toArray(new UniteDTO[0]);
    }

    public static Unite[] getUnitesByMedicament(Connection conn, String idMedicament) throws SQLException {
        List<Unite> unites = new ArrayList<>();
        String query = """
                    WITH RECURSIVE unites_liees AS (
                        SELECT u.id_unite, u.nom, u.id_unite_mere, c.quantite, 1 as niveau
                        FROM conversion c
                        JOIN unites u ON c.id_unite_mere = u.id_unite
                        WHERE c.id_medicament = ?

                        UNION ALL

                        SELECT u.id_unite, u.nom, u.id_unite_mere, ul.quantite, ul.niveau + 1
                        FROM unites u
                        JOIN unites_liees ul ON u.id_unite_mere = ul.id_unite
                    )
                    SELECT DISTINCT * FROM unites_liees
                    ORDER BY niveau, nom
                """;

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, idMedicament);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Unite unite = new Unite(
                            rs.getString("id_unite"),
                            rs.getString("nom"),
                            rs.getString("id_unite_mere"));
                    unites.add(unite);
                }
            }
        }
        return unites.toArray(new Unite[0]);
    }
}