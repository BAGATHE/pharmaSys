package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Utilisateur;
import model.Vendeur;
import model.commission.VendeurCommissionFilter;

public class UtilisateurRepository {

    public static Utilisateur checkUtilisateur(Connection conn, String email, String mot_de_passe) throws SQLException {
        String query = "SELECT * FROM utilisateurs where email=? and mot_de_passe= crypt(?,mot_de_passe)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, mot_de_passe);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Utilisateur utilisateur = new Utilisateur(
                        rs.getString("id_utilisateur"),
                        rs.getString("nom_complet"),
                        rs.getString("email"),
                        rs.getString("mot_de_passe"),
                        rs.getString("contact"),
                        rs.getString("role"));
                        utilisateur.setEstHomme(rs.getBoolean("esthomme"));
                return utilisateur;
            }
        }
        return null;

    }
    public static Vendeur[] getAllVendeur(Connection con, VendeurCommissionFilter vendeurCommissionFilter) throws Exception {
        List<Vendeur> vendeurs = new ArrayList<>();
        String sql = "SELECT * FROM utilisateurs WHERE role = ?";
        
        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, "vendeur");
            
            try (ResultSet rs = prst.executeQuery()) {
                while (rs.next()) {
                    vendeurCommissionFilter.setIdUtilisateur(rs.getString("id_utilisateur"));
                    Vendeur vendeur = new Vendeur(
                        rs.getString("id_utilisateur"), 
                        rs.getString("nom_complet"), 
                        "", 
                        "", 
                        "",
                        CommissionRepository.getVenteVendeurWithFilter(con, vendeurCommissionFilter)
                    );
                    vendeur.setEstHomme(rs.getBoolean("esthomme"));
                    vendeurs.add(vendeur);
                }
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la récupération des vendeurs : " + e.getMessage(), e);
        }
        
        return vendeurs.toArray(new Vendeur[0]);
    }
    
}