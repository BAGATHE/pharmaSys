package model;

public class PrixMedicament {
    private String id_prix_medicament;
    private String id_medicament;
    private double prix_vente_unitaire;
    private Unite unite;

    public PrixMedicament(String id_medicament, double prix_vente_unitaire, Unite unite) throws Exception {
        this.setId_medicament(id_medicament);
        this.setUnite(unite);
        this.setPrix_vente_unitaire(prix_vente_unitaire);
    }

    public PrixMedicament(String id_prix_medicament, String id_medicament, double prix_vente_unitaire, Unite unite)
            throws Exception {
        this.setId_medicament(id_medicament);
        this.setId_prix_medicament(id_prix_medicament);
        this.setUnite(unite);
        this.setPrix_vente_unitaire(prix_vente_unitaire);
    }

    public String getId_prix_medicament() {
        return id_prix_medicament;
    }

    public void setId_prix_medicament(String id_prix_medicament) {
        this.id_prix_medicament = id_prix_medicament;
    }

    public String getId_medicament() {
        return id_medicament;
    }

    public void setId_medicament(String id_medicament) {
        this.id_medicament = id_medicament;
    }

    public double getPrix_vente_unitaire() {
        return prix_vente_unitaire;
    }

    public void setPrix_vente_unitaire(double prix_vente_unitaire) throws Exception {
        if (prix_vente_unitaire < 0) {
            throw new Exception("prix de vente doit etre superieur a 0");
        }
        this.prix_vente_unitaire = prix_vente_unitaire;
    }

    public Unite getUnite() {
        return unite;
    }

    public void setUnite(Unite unite) {
        this.unite = unite;
    }

}
