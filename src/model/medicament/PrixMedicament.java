package model.medicament;

import java.sql.Timestamp;
import model.configuration.Unite;

public class PrixMedicament {
    private String idPrixMedicament;
    private Medicament medicament;
    private double prixVenteUnitaire;
    private Unite unite;
    private Timestamp dateInsertion;

    public PrixMedicament(Medicament medicament, double prixVenteUnitaire, Unite unite) {
        this.medicament = medicament;
        this.prixVenteUnitaire = prixVenteUnitaire;
        this.unite = unite;
    }

    public PrixMedicament(String idPrixMedicament, Medicament medicament, double prixVenteUnitaire, Unite unite) {
        this.idPrixMedicament = idPrixMedicament;
        this.medicament = medicament;
        this.prixVenteUnitaire = prixVenteUnitaire;
        this.unite = unite;
    }

    public String getIdPrixMedicament() {
        return idPrixMedicament;
    }

    public void setIdPrixMedicament(String idPrixMedicament) {
        this.idPrixMedicament = idPrixMedicament;
    }

    public Medicament getMedicament() {
        return medicament;
    }

    public void setMedicament(Medicament medicament) {
        this.medicament = medicament;
    }

    public double getPrixVenteUnitaire() {
        return prixVenteUnitaire;
    }

    public void setPrixVenteUnitaire(double prixVenteUnitaire) {
        this.prixVenteUnitaire = prixVenteUnitaire;
    }

    public Unite getUnite() {
        return unite;
    }

    public void setUnite(Unite unite) {
        this.unite = unite;
    }

    public Timestamp getDateInsertion() {
        return dateInsertion;
    }

    public void setDateInsertion(Timestamp dateInsertion) {
        this.dateInsertion = dateInsertion;
    }

    

}
