package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Utilisateur;

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
                return utilisateur;
            }
        }
        return null;

    }
}
