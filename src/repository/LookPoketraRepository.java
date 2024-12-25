package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.poketra.LookPoketra;

public class LookPoketraRepository {
    public static LookPoketra getById(Connection conn, String id) throws SQLException {
        String query = "SELECT * FROM look_poketra WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new LookPoketra(rs.getString("id_look"), rs.getString("look"));
            }
        }
        return null;
    }

    public static LookPoketra[] getAll(Connection conn) throws SQLException {
        List<LookPoketra> look_poketras = new ArrayList<>();
        String query = "SELECT * FROM look_poketra";
        try (PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                look_poketras.add(new LookPoketra(rs.getString("id_look"), rs.getString("look")));
            }
        }
        return look_poketras.toArray(new LookPoketra[0]);
    }

    public static int save(Connection conn, LookPoketra look_poketra) throws SQLException {
        String query = "INSERT INTO look_poketra (look) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, look_poketra.getLook());
            stmt.executeUpdate();

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static int update(Connection conn, LookPoketra look_poketra) throws SQLException {
        String query = "UPDATE look_poketra SET look = ? WHERE id_look = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, look_poketra.getLook());
            stmt.setString(2, look_poketra.getIdLook());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
            return 0;
        }
    }

    public static int delete(Connection conn, String id) throws SQLException {
        String query = "DELETE FROM look_poketra WHERE id_look = ?";
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
