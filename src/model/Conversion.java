package model;

public class Conversion {
    private String idConversion;
    private String idMedicament;
    private Unite unite_1;
    private Unite unite_2;
    private double quantite;

    public Conversion(String idMedicament, Unite unite_1, Unite unite_2, double quantite) {
        this.idMedicament = idMedicament;
        this.unite_1 = unite_1;
        this.unite_2 = unite_2;
        this.quantite = quantite;
    }

    public Conversion(String idConversion, String idMedicament, Unite unite_1, Unite unite_2, double quantite) {
        this.idConversion = idConversion;
        this.idMedicament = idMedicament;
        this.unite_1 = unite_1;
        this.unite_2 = unite_2;
        this.quantite = quantite;
    }

    public String getIdConversion() {
        return idConversion;
    }

    public void setIdConversion(String idConversion) {
        this.idConversion = idConversion;
    }

    public String getIdMedicament() {
        return idMedicament;
    }

    public void setIdMedicament(String idMedicament) {
        this.idMedicament = idMedicament;
    }

    public Unite getUnite_1() {
        return unite_1;
    }

    public void setUnite_1(Unite unite_1) {
        this.unite_1 = unite_1;
    }

    public Unite getUnite_2() {
        return unite_2;
    }

    public void setUnite_2(Unite unite_2) {
        this.unite_2 = unite_2;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

}
