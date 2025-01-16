package model.recommandation;

import java.util.Date;
import model.medicament.Medicament;

public class Recommandation {
    private String idRecommandation;
    private Date dateDebut;
    private Date dateFin;
    private Medicament Medicament;

    public Recommandation(String idRecommandation, Date dateDebut, Date dateFin) {
        this.idRecommandation = idRecommandation;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    public Recommandation(Date dateDebut, Date dateFin, Medicament Medicament) {
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.Medicament = Medicament;
    }

    public Recommandation(String idRecommandation, Date dateDebut, Date dateFin, Medicament Medicament) {
        this.idRecommandation = idRecommandation;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.Medicament = Medicament;
    }

    public String getIdRecommandation() {
        return idRecommandation;
    }

    public void setIdRecommandation(String idRecommandation) {
        this.idRecommandation = idRecommandation;
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

    public Medicament getMedicament() {
        return Medicament;
    }

    public void setMedicament(Medicament medicament) {
        Medicament = medicament;
    }

}
