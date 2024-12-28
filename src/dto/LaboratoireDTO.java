package dto;

public class LaboratoireDTO {
    private String idLaboratoire;
    private String nom;
    private String contact;
    private String adresse;

    public LaboratoireDTO(String nom, String contact, String adresse) {
        this.nom = nom;
        this.contact = contact;
        this.adresse = adresse;
    }

    public LaboratoireDTO(String idLaboratoire, String nom, String contact, String adresse) {
        this.idLaboratoire = idLaboratoire;
        this.nom = nom;
        this.contact = contact;
        this.adresse = adresse;
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
}
