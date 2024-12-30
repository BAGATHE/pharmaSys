package model;

public class AchatDetail {
    private String idAchatDetail;
    private String idAchat;
    private Medicament medicament;
    private int quantite;
    private double prixAchat;
    private Unite unite;

    public String getIdAchatDetail() {
        return idAchatDetail;
    }
    public void setIdAchatDetail(String idAchatDetail) {
        this.idAchatDetail = idAchatDetail;
    }
    public String getIdAchat() {
        return idAchat;
    }
    public void setIdAchat(String idAchat) {
        this.idAchat = idAchat;
    }
    public Medicament getMedicament() {
        return medicament;
    }
    public void setMedicament(Medicament medicament) {
        this.medicament = medicament;
    }
    public int getQuantite() {
        return quantite;
    }
    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }
    public double getPrixAchat() {
        return prixAchat;
    }
    public void setPrixAchat(double prixAchat) {
        this.prixAchat = prixAchat;
    }
    public Unite getUnite() {
        return unite;
    }
    public void setUnite(Unite unite) {
        this.unite = unite;
    }

    public AchatDetail(String idAchatDetail, String idAchat, Medicament medicament, int quantite, double prixAchat, Unite unite){
        this.setIdAchat(idAchat);
        this.setIdAchatDetail(idAchatDetail);
        this.setMedicament(medicament);
        this.setQuantite(quantite);
        this.setPrixAchat(prixAchat);
        this.setUnite(unite);
    }

    //verifie si ce laboratoire permet l'achat en tel quantite de tel medicament
    public boolean estPossible(Laboratoire laboratoire){ return true; }
}
