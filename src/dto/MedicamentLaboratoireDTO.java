package dto;

public class MedicamentLaboratoireDTO {
    private String idMedicament;
    private String idLaboratoire;
    private double prixAchat;
    private int minimumAchat;

    public MedicamentLaboratoireDTO(String idMedicament, String idLaboratoire, double prixAchat, int minimumAchat)
            throws Exception {
        this.setIdMedicament(idMedicament);
        this.setIdLaboratoire(idLaboratoire);
        this.setPrixAchat(prixAchat);
        this.setMinimumAchat(minimumAchat);
    }

    public String getIdMedicament() {
        return idMedicament;
    }

    public void setIdMedicament(String idMedicament) {
        this.idMedicament = idMedicament;
    }

    public String getIdLaboratoire() {
        return idLaboratoire;
    }

    public void setIdLaboratoire(String idLaboratoire) {
        this.idLaboratoire = idLaboratoire;
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

}
