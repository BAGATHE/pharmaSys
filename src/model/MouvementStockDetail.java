package model;

public class MouvementStockDetail {
    private String idMouvementStockDetail;
    private String idMouvementStock;
    private double entree;
    private double sortie;
    private double prixUnitaire;
    private Unite unite;
    private Medicament medicament;

    public String getIdMouvementStockDetail() {
        return idMouvementStockDetail;
    }
    public void setIdMouvementStockDetail(String idMouvementStockDetail) {
        this.idMouvementStockDetail = idMouvementStockDetail;
    }
    public String getIdMouvementStock() {
        return idMouvementStock;
    }
    public void setIdMouvementStock(String idMouvementStock) {
        this.idMouvementStock = idMouvementStock;
    }
    public double getEntree() {
        return entree;
    }
    public void setEntree(double entree) {
        this.entree = entree;
    }
    public double getSortie() {
        return sortie;
    }
    public void setSortie(double sortie) {
        this.sortie = sortie;
    }
    public double getPrixUnitaire() {
        return prixUnitaire;
    }
    public void setPrixUnitaire(double prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
    }
    public Unite getUnite() {
        return unite;
    }
    public void setUnite(Unite unite) {
        this.unite = unite;
    }
    public Medicament getMedicament() {
        return medicament;
    }
    public void setMedicament(Medicament medicament) {
        this.medicament = medicament;
    }

    public MouvementStockDetail(String idMouvementStockDetail, String idMouvementStock, double entree, double sortie, double prixUnitaire, Unite unite, Medicament medicament){
        this.setIdMouvementStockDetail(idMouvementStockDetail);
        this.setIdMouvementStock(idMouvementStock);
        this.setEntree(entree);
        this.setSortie(sortie);
        this.setPrixUnitaire(prixUnitaire);
        this.setUnite(unite);
        this.setMedicament(medicament);
    }
}
