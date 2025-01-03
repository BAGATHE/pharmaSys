package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Traitement;
import model.maladie.Maladie;
import model.Medicament;

public class TraitementRepository {

    public static Traitement[] getByMaladieId(Connection conn, String idMaladie) throws SQLException {
        String query = "SELECT t.efficacite, m.id_medicament, m.nom AS nom_medicament, m.description AS description_medicament, "
                +
                "mal.id_maladie, mal.nom AS nom_maladie, mal.description AS description_maladie " +
                "FROM traitements t " +
                "JOIN maladies mal ON t.id_maladie = mal.id_maladie " +
                "JOIN medicaments m ON t.id_medicament = m.id_medicament " +
                "WHERE t.id_maladie = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Traitement> traitements = new ArrayList<>();

        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, idMaladie);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Maladie maladie = new Maladie(
                        rs.getString("id_maladie"),
                        rs.getString("nom_maladie"),
                        rs.getString("description_maladie"));

                Medicament medicament = new Medicament(
                        rs.getString("id_medicament"),
                        rs.getString("nom_medicament"),
                        rs.getString("description_medicament"));

                Traitement traitement = new Traitement(
                        maladie,
                        medicament,
                        rs.getInt("efficacite"));

                traitements.add(traitement);
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

        return traitements.toArray(new Traitement[0]);
    }

    public static Traitement[] getAll(Connection conn) throws SQLException {
        List<Traitement> traitements = new ArrayList<>();
        String query = "SELECT * FROM traitements";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Maladie maladie = MaladieRepository.getById(conn, rs.getString("id_maladie"));
                Medicament medicament = MedicamentRepository.getById(conn, rs.getString("id_medicament"));
                traitements.add(new Traitement(maladie, medicament, rs.getInt("efficacite")));
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
        return traitements.toArray(new Traitement[0]);
    }

    public static int save(Connection conn, Traitement traitement) throws SQLException {
        String query = "INSERT INTO traitements (id_maladie, id_medicament, efficacite) VALUES (?, ?, ?)";
        PreparedStatement stmt = null;

        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, traitement.getMaladie().getIdMaladie());
            stmt.setString(2, traitement.getMedicament().getIdMedicament());
            stmt.setInt(3, traitement.getEfficacite());

            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static int deleteByMaladieAndMedicament(Connection conn, String idMaladie, String idMedicament)
            throws SQLException {
        String query = "DELETE FROM traitements WHERE id_maladie = ? AND id_medicament = ?";
        PreparedStatement stmt = null;

        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, idMaladie);
            stmt.setString(2, idMedicament);

            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
