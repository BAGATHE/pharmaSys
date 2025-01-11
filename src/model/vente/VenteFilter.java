package model.vente;

public class VenteFilter {
    private String idType;
    private String idCategorie;

    // Constructeur avec paramètres
    public VenteFilter(String idType, String idCategorie) {
        this.idType = idType;
        this.idCategorie = idCategorie;
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
}
