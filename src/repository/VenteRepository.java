package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.vente.Vente;
import model.vente.VenteFilter;

public class VenteRepository {

    public static Vente[] getAllwithFiltre(Connection conn, VenteFilter venteFilter) throws Exception {
        List<Vente> ventes = new ArrayList<>();
        List<Object> parameters = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT DISTINCT v.id_vente " +
                        "FROM ventes v " +
                        "JOIN vente_details vd ON v.id_vente = vd.id_vente " +
                        "JOIN medicaments m ON vd.id_medicament = m.id_medicament " +
                        "LEFT JOIN traitements t ON m.id_medicament = t.id_medicament " +
                        "WHERE 1=1");

        // Ajout des filtres pour les dates
        if ((venteFilter.getDate_debut() == null || venteFilter.getDate_debut().isEmpty()) &&
                (venteFilter.getDate_fin() == null || venteFilter.getDate_fin().isEmpty())) {
            query.append(" AND v.date_vente = CURRENT_DATE");
        } else {
            query.append(" AND v.date_vente >= ? AND v.date_vente <= ?");
            parameters.add(java.sql.Date.valueOf(venteFilter.getDate_debut()));
            parameters.add(java.sql.Date.valueOf(venteFilter.getDate_fin()));
        }

        // Filtre par type
        if (venteFilter.getIdType() != null && !venteFilter.getIdType().isEmpty()) {
            query.append(" AND m.id_type = ?");
            parameters.add(venteFilter.getIdType());
        }

        // Filtre par catégorie
        if (venteFilter.getIdCategorie() != null && !venteFilter.getIdCategorie().isEmpty()) {
            query.append(" AND t.id_categorie = ?");
            parameters.add(venteFilter.getIdCategorie());
        }

        try (PreparedStatement statement = conn.prepareStatement(query.toString())) {
            // Injection des paramètres dans la requête
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet resultSet = statement.executeQuery()) {
                // Récupération des résultats
                while (resultSet.next()) {
                    String idVente = resultSet.getString("id_vente");
                    Vente vente = VenteRepository.getById(conn, idVente);

                    if (vente != null) {
                        ventes.add(vente);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
            throw new Exception("Une erreur est survenue lors de la récupération des ventes.", e);
        }

        return ventes.toArray(new Vente[0]);
    }

    public static String save(Connection con, Vente vente) throws Exception {
        String sql = "INSERT INTO ventes (date_vente, total) VALUES (?, ?)";
        String generatedId = null;

        try (PreparedStatement prst = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            prst.setDate(1, vente.getDateVente());
            prst.setDouble(2, vente.getTotal());

            prst.executeUpdate();

            try (ResultSet rs = prst.getGeneratedKeys()) {
                if (rs.next()) {
                    generatedId = rs.getString(1);
                }
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de l'insertion de la vente : " + e.getMessage());
        }

        return generatedId;
    }

    public static void update(Connection con, Vente vente) throws Exception {
        String sql = "UPDATE ventes SET date_vente = ?, total = ? WHERE id_vente = ?";
        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setDate(1, vente.getDateVente());
            prst.setDouble(2, vente.getTotal());
            prst.setString(3, vente.getIdVente());

            prst.executeUpdate();
        } catch (Exception e) {
            throw new Exception("Erreur lors de la mise a jour de la vente : " + e.getMessage());
        }
    }

    public static Vente[] getAll(Connection con) throws Exception {
        List<Vente> ventes = new ArrayList<>();
        String sql = "SELECT * FROM ventes where date_vente = CURRENT_DATE";
        try (PreparedStatement prst = con.prepareStatement(sql);
                ResultSet res = prst.executeQuery()) {
            while (res.next()) {
                Vente vente = new Vente(
                        res.getString("id_vente"),
                        res.getDate("date_vente"),
                        VenteDetailRepository.getByIdVente(con, res.getString("id_vente")));
                ventes.add(vente);
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la recuperation des ventes : " + e.getMessage());
        }
        return ventes.toArray(new Vente[0]);
    }

    public static Vente getById(Connection con, String idVente) throws Exception {
        Vente vente = null;
        String sql = "SELECT * FROM ventes WHERE id_vente = ?";
        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, idVente);
            try (ResultSet res = prst.executeQuery()) {
                if (res.next()) {
                    vente = new Vente(
                            res.getString("id_vente"),
                            res.getDate("date_vente"),
                            VenteDetailRepository.getByIdVente(con, res.getString("id_vente")));
                }
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la recuperation de la vente par id : " + e.getMessage());
        }
        return vente;
    }

    public static void delete(Connection con, String idVente) throws UnsupportedOperationException {
        throw new UnsupportedOperationException("La suppression des ventes n'est pas encore implementee");
    }
}
