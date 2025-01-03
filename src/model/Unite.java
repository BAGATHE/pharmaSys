package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import repository.UniteRepository;

public class Unite {

    private String idUnite;
    private String nom;
    private String idUniteMere;

    public Unite(String idUnite) {
        this.idUnite = idUnite;
    }

    public Unite(String nom, String idUniteMere) {
        this.nom = nom;
        this.idUniteMere = idUniteMere;
    }

    public Unite(String idUnite, String nom, String idUniteMere) {
        this.idUnite = idUnite;
        this.nom = nom;
        this.idUniteMere = idUniteMere;
    }

    public String getIdUnite() {
        return idUnite;
    }

    public void setIdUnite(String idUnite) {
        this.idUnite = idUnite;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getIdUniteMere() {
        return idUniteMere;
    }

    public void setIdUniteMere(String idUniteMere) {
        this.idUniteMere = idUniteMere;
    }

    public Unite getMere(Connection con) throws Exception {
        String sql = "SELECT id_unite_mere FROM unites WHERE id_unite=?";
        Unite mere = null;
        try (PreparedStatement prst = con.prepareStatement(sql)) {
            prst.setString(1, this.getIdUnite());
            ResultSet res = prst.executeQuery();
            if (res.next()) {
                String idUniteMere = res.getString("id_unite_mere");
                mere = UniteRepository.getById(con, idUniteMere);
            }
            res.close();
        } catch (Exception e) {
            throw new Exception("Erreur lors de la verification du type unite " + e.getMessage());
        }
        return mere;
    }

    public Unite cloner() {
        return new Unite(this.getIdUnite(), this.getNom(), this.getIdUniteMere());
    }

}