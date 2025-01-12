package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.medicament.TypeMedicament;

public class TypeMedicamentRepository {

    // Méthode pour insérer un nouveau type de médicament
    public static int save(Connection conn, TypeMedicament typeMedicament) throws SQLException {
        String query = "INSERT INTO type_medicament (type_medicament) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, typeMedicament.getTypeMedicament());
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    // Méthode pour mettre à jour un type de médicament
    public static int update(Connection conn, TypeMedicament typeMedicament) throws SQLException {
        String query = "UPDATE type_medicament SET type_medicament = ? WHERE id_type = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, typeMedicament.getTypeMedicament());
            stmt.setString(2, typeMedicament.getIdType());
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    // Méthode pour supprimer un type de médicament par ID
    public static int delete(Connection conn, String idType) throws SQLException {
        String query = "DELETE FROM type_medicament WHERE id_type = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, idType);
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    // Méthode pour récupérer un type de médicament par ID
    public static TypeMedicament getById(Connection conn, String idType) throws SQLException {
        String query = "SELECT * FROM type_medicament WHERE id_type = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, idType);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new TypeMedicament(
                            rs.getString("id_type"),
                            rs.getString("type_medicament"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return null;
    }

    // Méthode pour récupérer tous les types de médicaments
    public static TypeMedicament[] getAll(Connection conn) throws SQLException {
        List<TypeMedicament> types = new ArrayList<>();
        String query = "SELECT * FROM type_medicament";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                types.add(new TypeMedicament(
                        rs.getString("id_type"),
                        rs.getString("type_medicament")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return types.toArray(new TypeMedicament[0]);
    }
}
