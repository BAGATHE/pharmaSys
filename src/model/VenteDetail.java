package model;

public class VenteDetail {
    private String idVente;
    private String idVenteDetail;
    //en boite
    private double quantite;
    private double prixVente;
    private double reduction;
    private Medicament medicament;
    private Unite unite;

    public String getIdVente() {
        return idVente;
    }
    public void setIdVente(String idVente) {
        this.idVente = idVente;
    }
    public String getIdVenteDetail() {
        return idVenteDetail;
    }
    public void setIdVenteDetail(String idVenteDetail) {
        this.idVenteDetail = idVenteDetail;
    }
    public double getQuantite() {
        return quantite;
    }
    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }
    public double getPrixVente() {
        return prixVente;
    }
    public void setPrixVente(double prixVente) {
        this.prixVente = prixVente;
    }
    public double getReduction() {
        return reduction;
    }
    public void setReduction(double reduction) {
        this.reduction = reduction;
    }
    public Medicament getMedicament() {
        return medicament;
    }
    public void setMedicament(Medicament medicament) {
        this.medicament = medicament;
    }
    public Unite getUnite() {
        return unite;
    }

    public void setUnite(Unite unite) {
        this.unite = unite;
    }
    
    public VenteDetail(String idVenteDetail, String idVente, double quantite, double prixVente, Medicament medicament, Unite unite){
        this.setIdVente(idVente);
        this.setIdVenteDetail(idVenteDetail);
        this.setQuantite(quantite);
        this.setPrixVente(prixVente);
        this.setMedicament(medicament);
        this.setUnite(unite);

        this.convertirEnBoite();
    }

    //converti la quantite en boite pour la faire rentree dans le stock
    public void convertirEnBoite(){}

}
