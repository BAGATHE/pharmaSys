package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Medicament;
import model.PrixMedicament;
import model.Unite;

public class PrixMedicamentRepository {

    public static Medicament[] getAllMedicaments(Connection conn) throws SQLException {
        List<Medicament> medicaments = new ArrayList<>();
        String query = "SELECT * FROM medicaments";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                medicaments.add(new Medicament(rs.getString("id_medicament"), rs.getString("nom"),
                        rs.getString("description")));
            }
        }
        return medicaments.toArray(new Medicament[0]);
    }

    public static int checkUniteMedicament(Connection conn, PrixMedicament prixMedicament) throws SQLException {
        String query = "SELECT * FROM prix_medicaments WHERE id_medicament = ? AND id_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, prixMedicament.getMedicament().getIdMedicament());
            stmt.setString(2, prixMedicament.getUnite().getIdUnite());

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? 1 : 0;
            }
        }
    }

    public static int save(Connection conn, PrixMedicament prixMedicament) throws SQLException {
        String query = "INSERT INTO prix_medicaments (id_medicament,id_unite,prix_vente_unitaire) VALUES (?,?,?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, prixMedicament.getMedicament().getIdMedicament());
            stmt.setString(2, prixMedicament.getUnite().getIdUnite());
            stmt.setDouble(3, prixMedicament.getPrixVenteUnitaire());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    public static PrixMedicament[] getAll(Connection conn) throws SQLException {
        List<PrixMedicament> prixMedicaments = new ArrayList<>();
        String query = "SELECT * FROM v_prix_medicaments";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Medicament medicament = new Medicament(
                        rs.getString("id_medicament"),
                        rs.getString("nom_medicament"),
                        rs.getString("description_medicament"));

                Unite unite = new Unite(
                        rs.getString("id_unite"),
                        rs.getString("nom_unite"),
                        rs.getString("id_unite_mere"));

                PrixMedicament prixMedicament = new PrixMedicament(
                        rs.getString("id_prix_medicament"),
                        medicament,
                        rs.getDouble("prix_vente_unitaire"),
                        unite);

                prixMedicaments.add(prixMedicament);
            }
        }
        return prixMedicaments.toArray(new PrixMedicament[0]);
    }

    public static PrixMedicament[] getPrixByIdMedicament(Connection conn, String id) throws SQLException {
        List<PrixMedicament> prixMedicaments = new ArrayList<>();

        String query = "SELECT * FROM v_prix_medicaments WHERE id_medicament = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Medicament medicament = new Medicament(
                            rs.getString("id_medicament"),
                            rs.getString("nom_medicament"),
                            rs.getString("description_medicament"));

                    Unite unite = new Unite(
                            rs.getString("id_unite"),
                            rs.getString("nom_unite"),
                            rs.getString("id_unite_mere"));
                    PrixMedicament prixMedicament = new PrixMedicament(
                            rs.getString("id_prix_medicament"),
                            medicament,
                            rs.getDouble("prix_vente_unitaire"),
                            unite);
                    prixMedicaments.add(prixMedicament);
                }
            }
        }
        return prixMedicaments.toArray(new PrixMedicament[0]);
    }

    public static PrixMedicament getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM v_prix_medicaments WHERE id_prix_medicament = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Medicament medicament = new Medicament(
                            rs.getString("id_medicament"),
                            rs.getString("nom_medicament"),
                            rs.getString("description_medicament"));

                    Unite unite = new Unite(
                            rs.getString("id_unite"),
                            rs.getString("nom_unite"),
                            rs.getString("id_unite_mere"));

                    return new PrixMedicament(
                            rs.getString("id_prix_medicament"),
                            medicament,
                            rs.getDouble("prix_vente_unitaire"),
                            unite);
                }
            }
        }
        return null;
    }

    public static int update(Connection conn, PrixMedicament prixMedicament) throws SQLException {
        String query = "UPDATE prix_medicaments SET prix_vente_unitaire = ? WHERE id_prix_medicament = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDouble(1, prixMedicament.getPrixVenteUnitaire());
            stmt.setString(2, prixMedicament.getIdPrixMedicament());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    public static int delete(Connection conn, String idPrixMedicament) throws SQLException {
        String query = "DELETE FROM prix_medicaments WHERE id_prix_medicament = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, idPrixMedicament);
            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0 ? 1 : 0;
        }
    }
}
