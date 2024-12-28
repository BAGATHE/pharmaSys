package model;

public class Maladie {
    private String idMaladie;
    private String nom;
    private String description;

    public Maladie(String idMaladie) {
        this.idMaladie = idMaladie;
    }

    public Maladie(String idMaladie, String nom, String description) {
        this.idMaladie = idMaladie;
        this.nom = nom;
        this.description = description;
    }

    public Maladie(String nom, String description, Symptome[] symptomes, Traitement[] traitements) {
        this.nom = nom;
        this.description = description;
    }

    public Maladie(String idMaladie, String nom, String description, Symptome[] symptomes, Traitement[] traitements) {
        this.idMaladie = idMaladie;
        this.nom = nom;
        this.description = description;
    }

    public String getIdMaladie() {
        return idMaladie;
    }

    public void setIdMaladie(String idMaladie) {
        this.idMaladie = idMaladie;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
