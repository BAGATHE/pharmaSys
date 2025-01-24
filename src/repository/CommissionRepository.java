package repository;

import dto.VendeurDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.commission.Commission;
import model.commission.VendeurCommissionFilter;
import model.vente.Vente;

public class CommissionRepository {

    // Récupérer une commission par ID
    public static Commission getById(Connection conn, String idCommission) throws SQLException {
        String query = "SELECT * FROM commission WHERE id_commission = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, idCommission);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return new Commission(
                        rs.getString("id_commission"),
                        rs.getInt("pourcentage"),
                        rs.getDate("date_debut"),
                        rs.getDate("date_fin")
                );
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }

        return null; // Si aucune commission trouvée
    }

    // Récupérer toutes les commissions
    public static Commission[] getAll(Connection conn) throws SQLException {
        String query = "SELECT * FROM commission";
        List<Commission> commissions = new ArrayList<>();
        Statement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while (rs.next()) {
                commissions.add(new Commission(
                        rs.getString("id_commission"),
                        rs.getInt("pourcentage"),
                        rs.getDate("date_debut"),
                        rs.getDate("date_fin")
                ));
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }

        return commissions.toArray(new Commission[0]);

    }

    // Ajouter une nouvelle commission
    public static int save(Connection conn, Commission commission) throws SQLException {
        String query = "INSERT INTO commission (pourcentage, date_debut, date_fin) VALUES (?, ?, ?)";
        PreparedStatement stmt = null;

        try {
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, commission.getPourcentage());
            stmt.setDate(2, new java.sql.Date(commission.getDateDebut().getTime()));
            stmt.setDate(3, new java.sql.Date(commission.getDateFin().getTime()));

            return stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
        }
    }

    // Mettre à jour une commission
    public static int update(Connection conn, Commission commission) throws SQLException {
        String query = "UPDATE commission SET pourcentage = ?, date_debut = ?, date_fin = ? WHERE id_commission = ?";
        PreparedStatement stmt = null;

        try {
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, commission.getPourcentage());
            stmt.setDate(2, new java.sql.Date(commission.getDateDebut().getTime()));
            stmt.setDate(3, new java.sql.Date(commission.getDateFin().getTime()));
            stmt.setString(4, commission.getIdCommission());

            return stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
        }
    }

    // Supprimer une commission par ID
    public static int deleteById(Connection conn, String idCommission) throws SQLException {
        String query = "DELETE FROM commission WHERE id_commission = ?";
        PreparedStatement stmt = null;

        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, idCommission);

            return stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
        }
    }

    // Récupérer la commission actuelle
    public static Commission getCurrentCommission(Connection conn) throws SQLException {
        String query = "SELECT * FROM commission WHERE date_debut <= CURRENT_DATE AND date_fin >= CURRENT_DATE";

        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return new Commission(
                        rs.getString("id_commission"),
                        rs.getInt("pourcentage"),
                        rs.getDate("date_debut"),
                        rs.getDate("date_fin")
                );
            }
        }

        return null;
    }

    public static Vente[] getVenteVendeurWithFilter(Connection conn, VendeurCommissionFilter vendeurCommissionFilter) throws Exception {
        List<Vente> ventes = new ArrayList<>();
        List<Object> parameters = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT  * " +
                "FROM ventes " +
                "WHERE 1=1");

        // Ajout des filtres pour les dates
        if ((vendeurCommissionFilter.getDateDebut() == null || vendeurCommissionFilter.getDateDebut().isEmpty()) &&
                (vendeurCommissionFilter.getDateFin() == null || vendeurCommissionFilter.getDateFin().isEmpty())) {
            query.append(" AND date_vente = CURRENT_DATE");
        } else {
            query.append(" AND date_vente >= ? AND date_vente <= ?");
            parameters.add(java.sql.Date.valueOf(vendeurCommissionFilter.getDateDebut()));
            parameters.add(java.sql.Date.valueOf(vendeurCommissionFilter.getDateFin()));
        }

       

       
        if (vendeurCommissionFilter.getIdUtilisateur() != null && !vendeurCommissionFilter.getIdUtilisateur() .isEmpty()) {
            query.append(" AND id_utilisateur = ?");
            parameters.add(vendeurCommissionFilter.getIdUtilisateur() );
        }

        try (PreparedStatement statement = conn.prepareStatement(query.toString())) {
            // Injection des paramètres dans la requête
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet resultSet = statement.executeQuery()) {
                // Récupération des résultats
                while (resultSet.next()) {
                    Vente vente = new Vente();
                    vente.setIdVente(resultSet.getString("id_vente"));
                    vente.setDateVente(resultSet.getDate("date_vente"));
                    vente.setCommissionVendeur(resultSet.getDouble("commission_vendeur"));
                    vente.setVenteDetails(VenteDetailRepository.getByIdVente(conn, resultSet.getString("id_vente")));
                    vente.setClient(ClientRepository.getById(conn, resultSet.getString("id_client")));
                    if (vente != null) {
                        ventes.add(vente);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
            throw new Exception("Une erreur est survenue lors de la récupération des ventes des vendeur.", e);
        }

        return ventes.toArray(new Vente[0]);
    }

    public static VendeurDTO[] getCommissionbyGenre(Connection conn, VendeurCommissionFilter vendeurCommissionFilter) throws Exception {
        List<VendeurDTO> result = new ArrayList<>();
        List<Object> parameters = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT u.esthomme, SUM(v.commission_vendeur) AS total_commission " +
                "FROM ventes v " +
                "JOIN utilisateurs u ON v.id_utilisateur = u.id_utilisateur " +
                "WHERE 1=1");
    
        // Ajout des filtres pour les dates
        if ((vendeurCommissionFilter.getDateDebut() == null || vendeurCommissionFilter.getDateDebut().isEmpty()) &&
                (vendeurCommissionFilter.getDateFin() == null || vendeurCommissionFilter.getDateFin().isEmpty())) {
            query.append(" AND v.date_vente = CURRENT_DATE");
        } else {
            query.append(" AND v.date_vente >= ? AND v.date_vente <= ?");
            parameters.add(java.sql.Date.valueOf(vendeurCommissionFilter.getDateDebut()));
            parameters.add(java.sql.Date.valueOf(vendeurCommissionFilter.getDateFin()));
        }
        query.append(" GROUP BY u.esthomme");
    
        try (PreparedStatement statement = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }
    
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    boolean estHomme = resultSet.getBoolean("esthomme");
                    double totalCommission = resultSet.getDouble("total_commission");
    
                    // Créer un VendeurDTO pour chaque genre
                    String genre = estHomme ? "Homme" : "Femme";
                    result.add(new VendeurDTO(genre, totalCommission));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
            throw new Exception("Une erreur est survenue lors de la récupération des ventes des vendeurs.", e);
        }
    
        // Convertir la liste en tableau et le retourner
        return result.toArray(new VendeurDTO[0]);
    }
}
