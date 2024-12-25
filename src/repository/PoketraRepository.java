package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.poketra.Poketra;
import model.poketra.TypePoketra;
import model.poketra.LookPoketra;
import model.poketra.PoketraFilter;

public class PoketraRepository {

    public static Poketra[] getAllPoketra(Connection connection, PoketraFilter filter) {
        List<Object> parameters = new ArrayList<>();

        ArrayList<Poketra> poketraList = new ArrayList<>();

        StringBuilder query = new StringBuilder(
                "SELECT id_poketra, nom_poketra, id_type_poketra, type_poketra, id_look, look FROM v_poketra_details WHERE 1=1");
        if (filter.getNomPoketra() != null && !filter.getNomPoketra().isEmpty()) {
            query.append(" AND nom_poketra LIKE ?");
            parameters.add("%" + filter.getNomPoketra() + "%");
        }
        if (filter.getIdType() != null && !filter.getIdType().isEmpty()) {
            query.append(" AND id_type_poketra = ?");
            parameters.add(filter.getIdType());
        }
        if (filter.getIdLook() != null && !filter.getIdLook().isEmpty()) {
            query.append(" AND id_look = ?");
            parameters.add(filter.getIdLook());
        }
        // Ajout de la pagination
        int offset = (filter.getPage() - 1) * filter.getPageSize();
        query.append(" LIMIT ? OFFSET ?");
        parameters.add(filter.getPageSize());
        parameters.add(offset);
        try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    String idPoketra = resultSet.getString("id_poketra");
                    String nomPoketra = resultSet.getString("nom_poketra");

                    String idTypePoketra = resultSet.getString("id_type_poketra");
                    String typePoketraName = resultSet.getString("type_poketra");
                    TypePoketra typePoketra = new TypePoketra(idTypePoketra, typePoketraName);

                    String idLook = resultSet.getString("id_look");
                    String lookName = resultSet.getString("look");
                    LookPoketra lookPoketra = new LookPoketra(idLook, lookName);

                    Poketra poketra = new Poketra(idPoketra, nomPoketra, lookPoketra, typePoketra);
                    poketraList.add(poketra);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Erreur de connexion à la base de données !");
            e.printStackTrace();
        }

        return poketraList.toArray(new Poketra[0]);
    }

    public static int countPoketra(Connection connection, PoketraFilter filter) {
        int count = 0;
        List<Object> parameters = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM v_poketra_details WHERE 1=1");

        if (filter.getNomPoketra() != null && !filter.getNomPoketra().isEmpty()) {
            query.append(" AND nom_poketra LIKE ?");
            parameters.add("%" + filter.getNomPoketra() + "%");
        }
        if (filter.getIdType() != null && !filter.getIdType().isEmpty()) {
            query.append(" AND id_type_poketra = ?");
            parameters.add(filter.getIdType());
        }
        if (filter.getIdLook() != null && !filter.getIdLook().isEmpty()) {
            query.append(" AND id_look = ?");
            parameters.add(filter.getIdLook());
        }

        try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    count = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

}