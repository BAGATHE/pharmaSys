package model.vente;

public class VenteFilter {
    private String idType;
    private String idCategorie;
    private String date_debut;
    private String date_fin;
    private String id_client;

    public String getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(String date_debut) {
        this.date_debut = date_debut;
    }

    public String getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(String date_fin) {
        this.date_fin = date_fin;
    }

    public VenteFilter(String idType, String idCategorie, String date_debut, String date_fin) {
        this.idType = idType;
        this.idCategorie = idCategorie;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
    }

    // Getter pour idType
    public String getIdType() {
        return idType;
    }

    // Setter pour idType
    public void setIdType(String idType) {
        this.idType = idType;
    }

    // Getter pour idCategorie
    public String getIdCategorie() {
        return idCategorie;
    }

    // Setter pour idCategorie
    public void setIdCategorie(String idCategorie) {
        this.idCategorie = idCategorie;
    }

    public String getId_client() {
        return id_client;
    }

    public void setId_client(String id_client) {
        this.id_client = id_client;
    }
}
