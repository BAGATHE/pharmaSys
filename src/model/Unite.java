package model;

public class Unite {

    private String idUnite;
    private String nom;

    public Unite(String nom) {
        this.setNom(nom);
    }

    public Unite(String idUnite, String nom) {
        this.setIdUnite(idUnite);
        this.setNom(nom);
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

}