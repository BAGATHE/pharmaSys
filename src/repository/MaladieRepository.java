package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.maladie.Maladie;
import model.maladie.MaladieFilter;

public class MaladieRepository {

    public static Maladie getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM maladies WHERE id_maladie = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return new Maladie(
                        rs.getString("id_maladie"),
                        rs.getString("nom"),
                        rs.getString("description"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log error
            throw e; // Rethrow the exception if needed
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace(); // Log error while closing ResultSet
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace(); // Log error while closing PreparedStatement
                }
            }
        }
        return null;
    }

    public static int save(Connection conn, Maladie maladie) throws SQLException {
        String query = "INSERT INTO maladies (nom, description) VALUES (?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, maladie.getNom());
            stmt.setString(2, maladie.getDescription());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1; // succès
            }
            return 0; // échec
        } catch (SQLException e) {
            e.printStackTrace(); // Log error
            throw e; // Rethrow the exception if needed
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace(); // Log error while closing PreparedStatement
                }
            }
        }
    }

    public static int update(Connection conn, Maladie maladie) throws SQLException {
        String query = "UPDATE maladies SET nom = ?, description = ? WHERE id_maladie = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, maladie.getNom());
            stmt.setString(2, maladie.getDescription());
            stmt.setString(3, maladie.getIdMaladie());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1; // succès
            }
            return 0; // échec
        } catch (SQLException e) {
            e.printStackTrace(); // Log error
            throw e; // Rethrow the exception if needed
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace(); // Log error while closing PreparedStatement
                }
            }
        }
    }

    public static int delete(Connection conn, String id) throws SQLException {
        String query = "DELETE FROM maladies WHERE id_maladie = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conn.prepareStatement(query);
            stmt.setString(1, id);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1; // succès
            }
            return 0; // échec
        } catch (SQLException e) {
            e.printStackTrace(); // Log error
            throw e; // Rethrow the exception if needed
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace(); // Log error while closing PreparedStatement
                }
            }
        }
    }

    public static Maladie[] getAllMaladies(Connection connection, MaladieFilter filter) {
        List<Object> parameters = new ArrayList<>();
        ArrayList<Maladie> maladieList = new ArrayList<>();

        // Construction de la requête SQL avec les filtres
        StringBuilder query = new StringBuilder(
                "SELECT m.id_maladie, m.nom AS nom_maladie, m.description AS description_maladie " +
                        "FROM maladies m " +
                        "LEFT JOIN maladies_symptomes ms ON m.id_maladie = ms.id_maladie " +
                        "LEFT JOIN symptomes s ON ms.id_symptomes = s.id_symptomes " +
                        "LEFT JOIN traitements t ON m.id_maladie = t.id_maladie " +
                        "LEFT JOIN medicaments med ON t.id_medicament = med.id_medicament " +
                        "WHERE 1=1");

        // Ajout du filtre pour le nom de la maladie
        if (filter.getNom() != null && !filter.getNom().isEmpty()) {
            query.append(" AND m.nom ILIKE ?");
            parameters.add("%" + filter.getNom() + "%");
        }

        // Ajout du filtre pour le nom du symptôme
        if (filter.getNomSymptome() != null && !filter.getNomSymptome().isEmpty()) {
            query.append(" AND s.nom ILIKE ?");
            parameters.add("%" + filter.getNomSymptome() + "%");
        }

        // Ajout du filtre pour le nom du médicament
        if (filter.getMedicament() != null && !filter.getMedicament().isEmpty()) {
            query.append(" AND med.nom ILIKE ?");
            parameters.add("%" + filter.getMedicament() + "%");
        }

        // Pagination (limit et offset)
        int offset = (filter.getPage() - 1) * filter.getPageSize();
        query.append(" LIMIT ? OFFSET ?");
        parameters.add(filter.getPageSize());
        parameters.add(offset);

        // Initialisation des ressources
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        // Exécution de la requête
        try {
            statement = connection.prepareStatement(query.toString());
            // Paramétrage des valeurs
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            resultSet = statement.executeQuery();
            // Traitement des résultats
            while (resultSet.next()) {
                String idMaladie = resultSet.getString("id_maladie");
                String nomMaladie = resultSet.getString("nom_maladie");
                String descriptionMaladie = resultSet.getString("description_maladie");

                Maladie maladie = new Maladie(idMaladie, nomMaladie, descriptionMaladie);
                maladieList.add(maladie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Erreur de connexion à la base de données !");
            e.printStackTrace();
        } finally {
            // Fermeture des ressources
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Log error while closing resources
            }
        }

        return maladieList.toArray(new Maladie[0]);
    }

    public static int countMaladie(Connection connection, MaladieFilter filter) {
        int count = 0;
        List<Object> parameters = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT COUNT(DISTINCT m.id_maladie) " +
                        "FROM maladies m " +
                        "LEFT JOIN maladies_symptomes ms ON m.id_maladie = ms.id_maladie " +
                        "LEFT JOIN symptomes s ON ms.id_symptomes = s.id_symptomes " +
                        "LEFT JOIN traitements t ON m.id_maladie = t.id_maladie " +
                        "LEFT JOIN medicaments med ON t.id_medicament = med.id_medicament " +
                        "WHERE 1=1");

        // Filtre par nom de la maladie
        if (filter.getNom() != null && !filter.getNom().isEmpty()) {
            query.append(" AND m.nom LIKE ?");
            parameters.add("%" + filter.getNom() + "%");
        }

        // Filtre par nom de symptôme
        if (filter.getNomSymptome() != null && !filter.getNomSymptome().isEmpty()) {
            query.append(" AND s.nom LIKE ?");
            parameters.add("%" + filter.getNomSymptome() + "%");
        }

        // Filtre par médicament
        if (filter.getMedicament() != null && !filter.getMedicament().isEmpty()) {
            query.append(" AND med.nom LIKE ?");
            parameters.add("%" + filter.getMedicament() + "%");
        }

        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            statement = connection.prepareStatement(query.toString());
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Fermeture des ressources
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Log error while closing resources
            }
        }

        return count;
    }

}