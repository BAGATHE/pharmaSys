package model;

public class Laboratoire {
    private String idLaboratoire;
    private String nom;
    private String contact;
    private String adresse;
    private MedicamentLaboratoire[] medicamentLaboratoires;

    public Laboratoire(String nom, String contact, String adresse) {
        this.nom = nom;
        this.contact = contact;
        this.adresse = adresse;
    }

    public Laboratoire(String nom, String contact, String adresse, MedicamentLaboratoire[] medicamentLaboratoires) {
        this.nom = nom;
        this.contact = contact;
        this.adresse = adresse;
        this.medicamentLaboratoires = medicamentLaboratoires;
    }

    public Laboratoire(String idLaboratoire, String nom, String contact, String adresse,
            MedicamentLaboratoire[] medicamentLaboratoires) {
        this.idLaboratoire = idLaboratoire;
        this.nom = nom;
        this.contact = contact;
        this.adresse = adresse;
        this.medicamentLaboratoires = medicamentLaboratoires;
    }

    public String getIdLaboratoire() {
        return idLaboratoire;
    }

    public void setIdLaboratoire(String idLaboratoire) {
        this.idLaboratoire = idLaboratoire;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public MedicamentLaboratoire[] getMedicamentLaboratoires() {
        return medicamentLaboratoires;
    }

    public void setMedicamentLaboratoires(MedicamentLaboratoire[] medicamentLaboratoires) {
        this.medicamentLaboratoires = medicamentLaboratoires;
    }

}
