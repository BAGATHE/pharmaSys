package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Vente;

public class VenteRepository {
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
