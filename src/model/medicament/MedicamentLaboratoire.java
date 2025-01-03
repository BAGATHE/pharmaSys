package model.medicament;

import model.configuration.Unite;

public class MedicamentLaboratoire {

    private Medicament medicament;
    private Laboratoire laboratoire;
    private Unite unite;
    private double prixAchat;
    private int minimumAchat;

    public MedicamentLaboratoire(Medicament medicament, Laboratoire laboratoire, Unite unite, double prixAchat,
            int minimumAchat) {
        this.medicament = medicament;
        this.laboratoire = laboratoire;
        this.unite = unite;
        this.prixAchat = prixAchat;
        this.minimumAchat = minimumAchat;
    }

    public double getPrixAchat() {
        return prixAchat;
    }

    public void setPrixAchat(double prixAchat) throws Exception {
        if (prixAchat < 0) {
            throw new Exception("prix achat devrais etre superieur a 0");
        }
        this.prixAchat = prixAchat;
    }

    public int getMinimumAchat() {
        return minimumAchat;
    }

    public void setMinimumAchat(int minimumAchat) throws Exception {
        if (minimumAchat < 0) {
            throw new Exception("minimum achat devrais etre superieur a 0");
        }
        this.minimumAchat = minimumAchat;
    }

    public Unite getUnite() {
        return unite;
    }

    public void setUnite(Unite unite) {
        this.unite = unite;
    }

    public Laboratoire getLaboratoire() {
        return laboratoire;
    }

    public void setLaboratoire(Laboratoire laboratoire) {
        this.laboratoire = laboratoire;
    }

    public Medicament getMedicament() {
        return medicament;
    }

    public void setMedicament(Medicament medicament) {
        this.medicament = medicament;
    }

}
