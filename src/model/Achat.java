package model;

import java.sql.Date;

public class Achat {
    private String idAchat;
    private Laboratoire laboratoire;
    private Date dateAchat;
    private AchatDetail[] achatDetails;

    public String getIdAchat() {
        return idAchat;
    }
    public void setIdAchat(String idAchat) {
        this.idAchat = idAchat;
    }
    public Laboratoire getLaboratoire() {
        return laboratoire;
    }
    public void setLaboratoire(Laboratoire laboratoire) {
        this.laboratoire = laboratoire;
    }
    public Date getDateAchat() {
        return dateAchat;
    }
    public void setDateAchat(Date dateAchat) {
        this.dateAchat = dateAchat;
    }
    public AchatDetail[] getAchatDetails() {
        return achatDetails;
    }
    public void setAchatDetails(AchatDetail[] achatDetails) {
        this.achatDetails = achatDetails;
    }

    public Achat(String idAchat, Laboratoire laboratoire, Date dateAchat, AchatDetail[] achatDetails){
        this.setIdAchat(idAchat);
        this.setLaboratoire(laboratoire);
        this.setDateAchat(dateAchat);
        this.setAchatDetails(achatDetails);
    }
}
