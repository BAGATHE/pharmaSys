package model;

import java.sql.Date;

public class MouvementStock {
    private String idMouvementStock;
    private Date dateMouvementStock;
    private MouvementStockDetail[] mouvementStockDetails;
    
    public String getIdMouvementStock() {
        return idMouvementStock;
    }
    public void setIdMouvementStock(String idMouvementStock) {
        this.idMouvementStock = idMouvementStock;
    }
    public Date getDateMouvementStock() {
        return dateMouvementStock;
    }
    public void setDateMouvementStock(Date dateMouvementStock) {
        this.dateMouvementStock = dateMouvementStock;
    }
    public MouvementStockDetail[] getMouvementStockDetails() {
        return mouvementStockDetails;
    }
    public void setMouvementStockDetails(MouvementStockDetail[] mouvementStockDetails) {
        this.mouvementStockDetails = mouvementStockDetails;
    }

    public MouvementStock(String idMouvementStock, Date dateMouvementStock, MouvementStockDetail[] mouvementStockDetails){
        this.setIdMouvementStock(idMouvementStock);
        this.setDateMouvementStock(dateMouvementStock);
        this.setMouvementStockDetails(mouvementStockDetails);
    }
}
