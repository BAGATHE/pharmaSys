package model.commission;

import java.sql.Date;

public class Commission {
    private String idCommission;
    private int pourcentage;
    private Date dateDebut;
    private Date dateFin;

    // Constructeur
    public Commission(String idCommission, int pourcentage, Date dateDebut, Date dateFin) {
        this.idCommission = idCommission;
        this.pourcentage = pourcentage;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    public Commission(int pourcentage, Date dateDebut, Date dateFin) {
        this.pourcentage = pourcentage;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    // Getters et Setters
    public String getIdCommission() {
        return idCommission;
    }

    public void setIdCommission(String idCommission) {
        this.idCommission = idCommission;
    }

    public int getPourcentage() {
        return pourcentage;
    }

    public void setPourcentage(int pourcentage) {
        this.pourcentage = pourcentage;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    // Méthode toString pour afficher les détails de la commission
    @Override
    public String toString() {
        return "Commission [idCommission=" + idCommission + ", pourcentage=" + pourcentage + ", dateDebut=" + dateDebut
                + ", dateFin=" + dateFin + "]";
    }
}
