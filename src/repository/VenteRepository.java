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
        StringBuilder query = new StringBuilder("select vd.id_vente from vente_details vd join medicaments m on vd.id_medicament = m.id_medicament\n" +
                "join traitements t on t.id_medicament = m.id_medicament WHERE 1=1");

        // Ajouter des conditions de filtre sur id_type
        if (venteFilter.getIdType() != null && !venteFilter.getIdType().isEmpty()) {
            query.append(" AND m.id_type = ?");
            parameters.add(venteFilter.getIdType());
        }

        // Ajouter des conditions de filtre sur id_categorie
        if (venteFilter.getIdCategorie() != null && !venteFilter.getIdCategorie().isEmpty()) {
            query.append(" AND t.id_categorie = ?");
            parameters.add(venteFilter.getIdCategorie());
        }

        try (PreparedStatement statement = conn.prepareStatement(query.toString())) {
            // Paramétrer la requête avec les valeurs de filtre
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    String idVente = resultSet.getString("id_vente");
                    Vente vente = VenteRepository.getById(conn, idVente); // Méthode pour récupérer une vente par son ID

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
        String sql = "SELECT * FROM ventes";
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
