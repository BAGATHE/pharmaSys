package model.stock;

import java.sql.Date;

import model.achat.Achat;
import model.achat.AchatDetail;
import model.vente.Vente;
import model.vente.VenteDetail;

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

    public MouvementStock(String idMouvementStock, Date dateMouvementStock,
            MouvementStockDetail[] mouvementStockDetails) {
        this.setIdMouvementStock(idMouvementStock);
        this.setDateMouvementStock(dateMouvementStock);
        this.setMouvementStockDetails(mouvementStockDetails);
    }

    public MouvementStock() {
        this.setIdMouvementStock("");
    }

    public static MouvementStock genererMouvementStock(Achat achat) throws Exception {
        MouvementStock mouvementStock = new MouvementStock();
        mouvementStock.setDateMouvementStock(achat.getDateAchat());
        return mouvementStock;
    }

    public MouvementStockDetail[] genererMouvementStockDetails(Achat achat) throws Exception {
        MouvementStockDetail[] mvsd = new MouvementStockDetail[achat.getAchatDetails().length];
        for (int i = 0; i < mvsd.length; i++) {
            AchatDetail achatDetail = achat.getAchatDetails()[i];
            MouvementStockDetail mvs = new MouvementStockDetail();
            mvs.setEntree(achatDetail.getQuantite());
            mvs.setSortie(0);
            mvs.setUnite(achatDetail.getUnite());
            mvs.setMedicament(achatDetail.getMedicament());
            mvs.setPrixUnitaire(achatDetail.getPrixAchat());
            mvs.setIdMouvementStock(this.getIdMouvementStock());
            mvsd[i] = mvs;
        }
        this.setMouvementStockDetails(mvsd);
        return mvsd;
    }

    public static MouvementStock genererMouvementStock(Vente vente) throws Exception {
        MouvementStock mouvementStock = new MouvementStock();
        mouvementStock.setDateMouvementStock(vente.getDateVente());
        return mouvementStock;
    }

    public MouvementStockDetail[] genererMouvementStockDetails(Vente vente) throws Exception {
        MouvementStockDetail[] mvsd = new MouvementStockDetail[vente.getVenteDetails().length];
        for (int i = 0; i < mvsd.length; i++) {
            VenteDetail venteDetail = vente.getVenteDetails()[i];
            MouvementStockDetail mvs = new MouvementStockDetail();
            mvs.setEntree(0);
            mvs.setSortie(venteDetail.getQuantite());
            mvs.setUnite(venteDetail.getUnite());
            mvs.setMedicament(venteDetail.getMedicament());
            mvs.setPrixUnitaire(venteDetail.getPrixVente());
            mvs.setIdMouvementStock(this.getIdMouvementStock());
            mvsd[i] = mvs;
        }
        this.setMouvementStockDetails(mvsd);
        return mvsd;
    }
}
