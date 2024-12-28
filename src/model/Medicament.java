package model;

public class Medicament {
    private String idMedicament;
    private String nom;
    private String description;
    private PrixMedicament[] prixMedicament;
    private Traitement[] traitements;
    private MedicamentLaboratoire[] medicamentLaboratoires;

    public Medicament(String idMedicament) {
        this.idMedicament = idMedicament;
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

    public Traitement[] getTraitements() {
        return traitements;
    }

    public void setTraitements(Traitement[] traitements) {
        this.traitements = traitements;
    }

    public MedicamentLaboratoire[] getMedicamentLaboratoires() {
        return medicamentLaboratoires;
    }

    public void setMedicamentLaboratoires(MedicamentLaboratoire[] medicamentLaboratoires) {
        this.medicamentLaboratoires = medicamentLaboratoires;
    }

    public PrixMedicament[] getPrixMedicament() {
        return prixMedicament;
    }

    public void setPrixMedicament(PrixMedicament[] prixMedicament) {
        this.prixMedicament = prixMedicament;
    }

}
