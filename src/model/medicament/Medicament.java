package model.medicament;

public class Medicament {
    private String idMedicament;
    private String nom;
    private String description;
    private TypeMedicament typeMedicament;
    private PrixMedicament[] prixMedicament;

    public Medicament(String nom, String description, TypeMedicament typeMedicament, PrixMedicament[] prixMedicament) {
        this.nom = nom;
        this.description = description;
        this.typeMedicament = typeMedicament;
        this.prixMedicament = prixMedicament;
    }

    public Medicament(String nom, String description, TypeMedicament typeMedicament) {
        this.nom = nom;
        this.description = description;
        this.typeMedicament = typeMedicament;
    }

    public Medicament(String idMedicament) {
        this.idMedicament = idMedicament;
    }

    public Medicament(String nom, String description) {
        this.nom = nom;
        this.description = description;
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

    public TypeMedicament getTypeMedicament() {
        return typeMedicament;
    }

    public void setTypeMedicament(TypeMedicament typeMedicament) {
        this.typeMedicament = typeMedicament;
    }
}
