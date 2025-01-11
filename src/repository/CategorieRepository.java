package repository;

import model.categorie.Categorie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategorieRepository {

    // Méthode pour récupérer toutes les catégories
    public static Categorie[] getAll(Connection conn) throws SQLException {
        List<Categorie> categories = new ArrayList<>();
        String query = "SELECT * FROM categorie";

        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                categories.add(new Categorie(
                        rs.getString("id_categorie"),
                        rs.getString("categorie"),
                        rs.getInt("age_max") // `getInt` pour récupérer un int
                ));
            }
        }
        return categories.toArray(new Categorie[0]); // Convertir la liste en tableau
    }

    // Méthode pour récupérer une catégorie par son ID
    public static Categorie getById(Connection conn, String idCategorie) throws SQLException {
        String query = "SELECT * FROM categorie WHERE id_categorie = ?";
        Categorie categorie = null;

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, idCategorie);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    categorie = new Categorie(
                            rs.getString("id_categorie"),
                            rs.getString("categorie"),
                            rs.getInt("age_max"));
                }
            }
        }
        return categorie;
    }

}
