package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.poketra.TypePoketra;

public class TypePoketraRepository {

    public static TypePoketra getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM type_poketra WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new TypePoketra(rs.getString("id_type_poketra"), rs.getString("type_poketra"));
            }
        }
        return null;
    }

    public TypePoketra[] getAll(Connection conn) throws SQLException {
        List<TypePoketra> type_poketras = new ArrayList<>();
        String query = "SELECT * FROM type_poketra";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                type_poketras.add(new TypePoketra(rs.getString("id_type_poketra"), rs.getString("type_poketra")));
            }
        }
        return type_poketras.toArray(new TypePoketra[0]);
    }

    public static int save(Connection conn, TypePoketra type_poketra) throws SQLException {
        String query = "INSERT INTO type_poketra (type_poketra) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, type_poketra.getTypePoketra());
            stmt.executeUpdate();

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static int update(Connection conn, TypePoketra type_poketra) throws SQLException {
        String query = "UPDATE type_poketra SET type_poketra = ? WHERE id_type_poketra = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, type_poketra.getTypePoketra());
            stmt.setString(2, type_poketra.getIdTypePoketra());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static int delete(Connection conn, String id) throws SQLException {
        String query = "DELETE FROM type_poketra WHERE id_type_poketra = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }
}
