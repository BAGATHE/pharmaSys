package model;

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

}