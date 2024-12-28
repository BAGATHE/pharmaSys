package model;

public class Unite {

    private String idUnite;
    private String nom;
    private TypeUnite typeUnite;

    public Unite(String nom, TypeUnite typeUnite) {
        this.nom = nom;
        this.typeUnite = typeUnite;
    }

    public Unite(String idUnite, String nom, TypeUnite typeUnite) {
        this.idUnite = idUnite;
        this.nom = nom;
        this.typeUnite = typeUnite;
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

    public TypeUnite getTypeUnite() {
        return typeUnite;
    }

    public void setTypeUnite(TypeUnite typeUnite) {
        this.typeUnite = typeUnite;
    }

}