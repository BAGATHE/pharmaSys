package model.status;

public class Status {
    private String idStatus;
    private String nom;

    public String getIdStatus() {
        return idStatus;
    }

    public void setIdStatus(String idStatus) {
        this.idStatus = idStatus;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Status(String idStatus, String nom) {
        this.idStatus = idStatus;
        this.nom = nom;
    }

}
