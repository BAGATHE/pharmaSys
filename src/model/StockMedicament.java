package model;

import java.sql.Date;

public class StockMedicament {
    private String idStockMedicament;
    private Date datePeremption;
    private double quantiteBoite;
    private Medicament medicament;
    private Laboratoire laboratoire;
    private Unite unite;

    public String getIdStockMedicament() {
        return idStockMedicament;
    }

    public void setIdStockMedicament(String idStockMedicament) {
        this.idStockMedicament = idStockMedicament;
    }

    public Date getDatePeremption() {
        return datePeremption;
    }

    public void setDatePeremption(Date datePeremption) {
        this.datePeremption = datePeremption;
    }

    public double getQuantiteBoite() {
        return quantiteBoite;
    }

    public void setQuantiteBoite(double quantiteBoite) {
        this.quantiteBoite = quantiteBoite;
    }

    public Medicament getMedicament() {
        return medicament;
    }

    public void setMedicament(Medicament medicament) {
        this.medicament = medicament;
    }

    public Laboratoire getLaboratoire() {
        return laboratoire;
    }

    public void setLaboratoire(Laboratoire laboratoire) {
        this.laboratoire = laboratoire;
    }

    public Unite getUnite() {
        return unite;
    }

    public void setUnite(Unite unite) {
        this.unite = unite;
    }

    public StockMedicament(String idStockMedicament, Date datePeremption, double quantiteBoite, Medicament medicament,
            Laboratoire laboratoire, Unite unite) {
        this.setIdStockMedicament(idStockMedicament);
        this.setDatePeremption(datePeremption);
        this.setQuantiteBoite(quantiteBoite);
        this.setMedicament(medicament);
        this.setLaboratoire(laboratoire);
        this.setUnite(unite);
    }

    public StockMedicament() {
        this.setIdStockMedicament("");
    }

    // algorithme de valorisation de stock
    public void fifo() {
    }
}
