package model.configuration;

import model.medicament.Medicament;

public class Conversion {
    private Medicament medicament;
    private Unite uniteMere;
    private Unite uniteFille;
    private double quantite;

    public Conversion(Medicament medicament, Unite uniteMere, double quantite) {
        this.medicament = medicament;
        this.uniteMere = uniteMere;
        this.quantite = quantite;
    }

    public Conversion(Medicament medicament, Unite uniteMere, Unite uniteFille, double quantite) {
        this.medicament = medicament;
        this.uniteMere = uniteMere;
        this.uniteFille = uniteFille;
        this.quantite = quantite;
    }

    public Unite getUniteMere() {
        return uniteMere;
    }

    public void setUniteMere(Unite uniteMere) {
        this.uniteMere = uniteMere;
    }

    public Unite getUniteFille() {
        return uniteFille;
    }

    public void setUniteFille(Unite uniteFille) {
        this.uniteFille = uniteFille;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public Medicament getMedicament() {
        return medicament;
    }

    public void setMedicament(Medicament medicament) {
        this.medicament = medicament;
    }

}
