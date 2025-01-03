package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Conversion;
import model.Medicament;
import model.Unite;

public class ConversionRepository {
    public static Conversion[] getConversionsByMedicamentId(Connection conn, String idMedicament) throws SQLException {
        List<Conversion> conversions = new ArrayList<>();

        String query = "SELECT " +
                "id_medicament, medicament_nom,medicament_description, " +
                "id_unite_mere, unite_mere_nom, " +
                "id_unite_enfant, unite_enfant_nom, quantite " +
                "FROM v_medicament_conversion " +
                "WHERE id_medicament = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, idMedicament);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String medicamentId = rs.getString("id_medicament");
                    String medicamentNom = rs.getString("medicament_nom");
                    String description = rs.getString("medicament_description");
                    Medicament medicament = new Medicament(medicamentId, medicamentNom, description);

                    Unite uniteMere = new Unite(
                            rs.getString("id_unite_mere"),
                            rs.getString("unite_mere_nom"),
                            null);
                    String idUniteEnfant = rs.getString("id_unite_enfant");
                    Unite uniteFille = null;
                    if (idUniteEnfant != null) {
                        uniteFille = new Unite(
                                idUniteEnfant,
                                rs.getString("unite_enfant_nom"),
                                rs.getString("id_unite_mere"));
                    }

                    double quantite = rs.getDouble("quantite");
                    Conversion conversion = new Conversion(medicament, uniteMere, uniteFille, quantite);
                    conversions.add(conversion);
                }
            }
        }
        return conversions.toArray(new Conversion[0]);
    }

    public static int checkUniteMedicament(Connection conn, Conversion conversion) throws SQLException {
        String query = "SELECT * FROM conversion WHERE id_medicament = ? AND id_unite_mere = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, conversion.getMedicament().getIdMedicament());
            stmt.setString(2, conversion.getUniteMere().getIdUnite());

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? 1 : 0;
            }
        }
    }

    public static int save(Connection conn, Conversion conversion) throws SQLException {
        String query = "INSERT INTO conversion (id_medicament,id_unite_mere,quantite) VALUES (?,?,?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, conversion.getMedicament().getIdMedicament());
            stmt.setString(2, conversion.getUniteMere().getIdUnite());
            stmt.setDouble(3, conversion.getQuantite());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    public static int delete(Connection conn, Conversion conversion) throws SQLException {
        String query = "DELETE FROM conversion WHERE id_medicament=? and id_unite_mere = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, conversion.getMedicament().getIdMedicament());
            stmt.setString(2, conversion.getUniteMere().getIdUnite());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        }
    }

    public static Conversion getById(Connection con, String idUniteMere, String idMedicament) throws Exception {
        Conversion conversion = null;
        String sql = "SELECT c.id_medicament, c.id_unite_mere, c.quantite, " +
                "u1.id_unite AS id_unite_depart, u1.nom AS nom_unite_depart, " +
                "u2.id_unite AS id_unite_arrivee, u2.nom AS nom_unite_arrivee " +
                "FROM conversion c " +
                "LEFT JOIN unites u1 ON c.id_unite_mere = u1.id_unite " +
                "LEFT JOIN unites u2 ON u2.id_unite_mere = u1.id_unite " +
                "WHERE c.id_unite_mere = ? AND c.id_medicament = ?";
        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, idUniteMere);
            prst.setString(2, idMedicament);
            ResultSet res = prst.executeQuery();
            if (res.next()) {
                Unite uniteDepart = new Unite(res.getString("id_unite_depart"), res.getString("nom_unite_depart"));
                Unite uniteArrivee = res.getString("id_unite_arrivee") != null
                        ? new Unite(res.getString("id_unite_arrivee"), res.getString("nom_unite_arrivee"))
                        : null;
                double quantite = res.getDouble("quantite");
                Medicament medicament = new Medicament(idMedicament);
                conversion = new Conversion(medicament, uniteDepart, uniteArrivee, quantite);
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la recuperation de la conversion : " + e.getMessage());
        }
        return conversion;
    }

}
