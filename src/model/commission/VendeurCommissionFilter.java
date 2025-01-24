package model.commission;

public class VendeurCommissionFilter {
    private String dateDebut;
    private String dateFin;
    private String idUtilisateur;
    private boolean esthomme;
    public String getDateDebut() {
        return dateDebut;
    }
    public void setDateDebut(String dateDebut) {
        this.dateDebut = dateDebut;
    }
    public String getDateFin() {
        return dateFin;
    }
    public void setDateFin(String dateFin) {
        this.dateFin = dateFin;
    }
    public VendeurCommissionFilter(String dateDebut, String dateFin) {
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    public String getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(String idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }
    public boolean isEsthomme() {
        return esthomme;
    }
    public void setEsthomme(boolean esthomme) {
        this.esthomme = esthomme;
    }
    
}
