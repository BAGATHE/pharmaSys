package model;

public class Medicament {
    private String idMedicament;
    private String nom;
    private String description;
    private PrixMedicament[] prixMedicament;

    public Medicament(String idMedicament) {
        this.idMedicament = idMedicament;
    }

    public Medicament(String idMedicament, String nom, String description) {
        this.idMedicament = idMedicament;
        this.nom = nom;
        this.description = description;
    }

    public Medicament(String nom, String description, PrixMedicament[] prixMedicament) {
        this.nom = nom;
        this.description = description;
        this.prixMedicament = prixMedicament;
    }

    public Medicament(String idMedicament, String nom, String description, PrixMedicament[] prixMedicament) {
        this.idMedicament = idMedicament;
        this.nom = nom;
        this.description = description;
        this.prixMedicament = prixMedicament;
    }

    public String getIdMedicament() {
        return idMedicament;
    }

    public void setIdMedicament(String idMedicament) {
        this.idMedicament = idMedicament;
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

    public PrixMedicament[] getPrixMedicament() {
        return prixMedicament;
    }

    public void setPrixMedicament(PrixMedicament[] prixMedicament) {
        this.prixMedicament = prixMedicament;
    }

}
