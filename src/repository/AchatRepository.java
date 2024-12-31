package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Achat;

public class AchatRepository {
    public static String save(Connection con, Achat achat) throws Exception {
        String sql = "INSERT INTO achats (date_achat, total, id_laboratoire) VALUES (?, ?, ?)";
        String generatedId = null;

        try (PreparedStatement prst = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            prst.setDate(1, achat.getDateAchat());
            prst.setDouble(2, achat.getTotal());
            prst.setString(3, achat.getLaboratoire().getIdLaboratoire());

            prst.executeUpdate();

            try (ResultSet rs = prst.getGeneratedKeys()) {
                if (rs.next()) {
                    generatedId = rs.getString(1);
                }
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de l'insertion de l'achat : " + e.getMessage());
        }

        return generatedId;
    }

    public static void update(Connection con, Achat achat) throws Exception {
        String sql = "UPDATE achats SET date_achat = ?, total = ?, id_laboratoire = ? WHERE id_achat = ?";
        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setDate(1, achat.getDateAchat());
            prst.setDouble(2, achat.getTotal());
            prst.setString(3, achat.getLaboratoire().getIdLaboratoire());
            prst.setString(4, achat.getIdAchat());
            prst.executeUpdate();
        } catch (Exception e) {
            throw new Exception("Erreur lors de la mise a jour de l'achat : " + e.getMessage());
        }
    }

    public static Achat[] getAll(Connection con) throws Exception {
        List<Achat> achats = new ArrayList<>();
        String sql = "SELECT * FROM achats";
        try (PreparedStatement prst = con.prepareStatement(sql);
                ResultSet res = prst.executeQuery()) {
            while (res.next()) {
                Achat achat = new Achat(
                        res.getString("id_achat"),
                        LaboratoireRepository.getById(con, res.getString("id_laboratoire")),
                        res.getDate("date_achat"),
                        AchatDetailRepository.getByIdAchat(con, res.getString("id_achat")));
                achat.setTotal(res.getDouble("total"));
                achats.add(achat);
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la recuperation des achats : " + e.getMessage());
        }
        return achats.toArray(new Achat[0]);
    }

    public static Achat getById(Connection con, String idAchat) throws Exception {
        Achat achat = null;
        String sql = "SELECT * FROM achats WHERE id_achat = ?";
        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, idAchat);
            try (ResultSet res = prst.executeQuery()) {
                if (res.next()) {
                    achat = new Achat(
                            res.getString("id_achat"),
                            LaboratoireRepository.getById(con, res.getString("id_laboratoire")),
                            res.getDate("date_achat"),
                            AchatDetailRepository.getByIdAchat(con, res.getString("id_achat")));
                }
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la recuperation de l'achat par id : " + e.getMessage());
        }
        return achat;
    }

    public static void delete(Connection con, String idAchat) throws UnsupportedOperationException {
        throw new UnsupportedOperationException("La suppression des achats n'est pas encore implémentée");
    }
}
