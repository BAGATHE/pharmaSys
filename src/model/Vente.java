package model;

import java.sql.Date;

public class Vente {
    private String idVente;
    private Date dateVente;
    private VenteDetail[] venteDetails;

    public String getIdVente() {
        return idVente;
    }
    public void setIdVente(String idVente) {
        this.idVente = idVente;
    }
    public Date getDateVente() {
        return dateVente;
    }
    public void setDateVente(Date dateVente) {
        this.dateVente = dateVente;
    }
    public VenteDetail[] getVenteDetails() {
        return venteDetails;
    }
    public void setVenteDetails(VenteDetail[] venteDetails) {
        this.venteDetails = venteDetails;
    }

    public Vente(String idVente, Date dateVente, VenteDetail[] venteDetails){
        this.setIdVente(idVente);
        this.setDateVente(dateVente);
        this.setVenteDetails(venteDetails);
    }
}
