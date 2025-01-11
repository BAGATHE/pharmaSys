package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.configuration.Unite;
import model.medicament.Laboratoire;
import model.medicament.Medicament;
import model.medicament.MedicamentLaboratoire;

public class MedicamentLaboratoireRepository {
    public static MedicamentLaboratoire[] getMedicamentByIdLaboratoire(Connection conn, String idLaboratoire)
            throws SQLException {
        List<MedicamentLaboratoire> medicament_laboratoires = new ArrayList<>();

        String query = "SELECT " +
                "id_medicament, nom_medicament,description_medicament, " +
                "id_laboratoire, nom_laboratoire, contact_laboratoire,adresse_laboratoire, " +
                " id_unite,nom_unite ,prix_achat,minimum_achat " +
                "FROM medicament_details " +
                "WHERE id_laboratoire = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, idLaboratoire);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String medicamentId = rs.getString("id_medicament");
                    String medicamentNom = rs.getString("nom_medicament");
                    String description = rs.getString("description_medicament");
                    Medicament medicament = new Medicament(medicamentId, medicamentNom, description);

                    String nom_laboratoire = rs.getString("nom_laboratoire");
                    String contact_laboratoire = rs.getString("contact_laboratoire");
                    String adresse_laboratoire = rs.getString("adresse_laboratoire");
                    Laboratoire laboratoire = new Laboratoire(idLaboratoire, nom_laboratoire, contact_laboratoire,
                            adresse_laboratoire);
                    Unite unite = new Unite(
                            rs.getString("id_unite"),
                            rs.getString("nom_unite"),
                            null);
                    int minimum_quantite = rs.getInt("minimum_achat");
                    double prix_achat = rs.getDouble("prix_achat");
                    MedicamentLaboratoire medicamentLaboratoire = new MedicamentLaboratoire(medicament, laboratoire,
                            unite, prix_achat, minimum_quantite);
                    medicament_laboratoires.add(medicamentLaboratoire);
                }
            }
        }
        return medicament_laboratoires.toArray(new MedicamentLaboratoire[0]);
    }

    public static MedicamentLaboratoire[] getMedicamentByIdMedicament(Connection conn, String idMedicament)
            throws SQLException {
        List<MedicamentLaboratoire> medicament_laboratoires = new ArrayList<>();

        String query = "SELECT " +
                "id_medicament, nom_medicament,description_medicament, " +
                "id_laboratoire, nom_laboratoire, contact_laboratoire,adresse_laboratoire, " +
                " id_unite,nom_unite ,prix_achat,minimum_achat " +
                "FROM medicament_details " +
                "WHERE id_medicament = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, idMedicament);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {

                    String medicamentNom = rs.getString("nom_medicament");
                    String description = rs.getString("description_medicament");
                    Medicament medicament = new Medicament(idMedicament, medicamentNom, description);

                    String idLaboratoire = rs.getString("id_laboratoire");
                    String nom_laboratoire = rs.getString("nom_laboratoire");
                    String contact_laboratoire = rs.getString("contact_laboratoire");
                    String adresse_laboratoire = rs.getString("adresse_laboratoire");
                    Laboratoire laboratoire = new Laboratoire(idLaboratoire, nom_laboratoire, contact_laboratoire,
                            adresse_laboratoire);
                    Unite unite = new Unite(
                            rs.getString("id_unite"),
                            rs.getString("nom_unite"),
                            null);
                    int minimum_quantite = rs.getInt("minimum_achat");
                    double prix_achat = rs.getDouble("prix_achat");
                    MedicamentLaboratoire medicamentLaboratoire = new MedicamentLaboratoire(medicament, laboratoire,
                            unite, prix_achat, minimum_quantite);
                    medicament_laboratoires.add(medicamentLaboratoire);
                }
            }
        }
        return medicament_laboratoires.toArray(new MedicamentLaboratoire[0]);
    }

    public static int checkMedicamentLaboratoire(Connection conn, MedicamentLaboratoire medicamentLaboratoire)
            throws SQLException {
        String query = "SELECT * FROM medicament_laboratoire WHERE id_medicament = ? AND id_unite = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, medicamentLaboratoire.getMedicament().getIdMedicament());
            stmt.setString(2, medicamentLaboratoire.getUnite().getIdUnite());

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? 1 : 0;
            }
        }
    }

    public static int save(Connection conn, MedicamentLaboratoire medicamentLaboratoire) throws SQLException {
        String query = "INSERT INTO  medicament_laboratoire  (id_medicament,id_laboratoire,id_unite,prix_achat,minimum_achat) VALUES (?,?,?,?,?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, medicamentLaboratoire.getMedicament().getIdMedicament());
            stmt.setString(2, medicamentLaboratoire.getLaboratoire().getIdLaboratoire());
            stmt.setString(3, medicamentLaboratoire.getUnite().getIdUnite());
            stmt.setDouble(4, medicamentLaboratoire.getPrixAchat());
            stmt.setDouble(5, medicamentLaboratoire.getMinimumAchat());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static int delete(Connection conn, MedicamentLaboratoire medicamentLaboratoire) throws SQLException {
        String query = "DELETE FROM medicament_laboratoire WHERE id_medicament = ? AND id_laboratoire = ? AND id_unite = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, medicamentLaboratoire.getMedicament().getIdMedicament());
            stmt.setString(2, medicamentLaboratoire.getLaboratoire().getIdLaboratoire());
            stmt.setString(3, medicamentLaboratoire.getUnite().getIdUnite());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }
}
