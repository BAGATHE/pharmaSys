package model.categorie;

public class Categorie {

    private String idCategorie; // Correspond à id_categorie
    private String categorie;
    private int ageMax; // Correspond à age_max

    // Constructeur par défaut
    public Categorie() {
    }

    // Constructeur avec tous les paramètres
    public Categorie(String idCategorie, String categorie, int ageMax) {
        this.idCategorie = idCategorie;
        this.categorie = categorie;
        this.ageMax = ageMax;
    }

    // Getters et Setters

    public String getIdCategorie() {
        return idCategorie;
    }

    public void setIdCategorie(String idCategorie) {
        this.idCategorie = idCategorie;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public int getAgeMax() {
        return ageMax;
    }

    public void setAgeMax(int ageMax) {
        this.ageMax = ageMax;
    }

    // Méthode toString pour afficher les informations de l'objet
    @Override
    public String toString() {
        return "Categorie{" +
                "idCategorie='" + idCategorie + '\'' +
                ", categorie='" + categorie + '\'' +
                ", ageMax=" + ageMax +
                '}';
    }
}
