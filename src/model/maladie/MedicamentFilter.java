package model.maladie;

public class MedicamentFilter {
    private String idMaladie;
    private String idCategorie;

    public String getIdMaladie() {
        return idMaladie;
    }

    public void setIdMaladie(String idMaladie) {
        this.idMaladie = idMaladie;
    }

    public String getIdCategorie() {
        return idCategorie;
    }

    public void setIdCategorie(String idCategorie) {
        this.idCategorie = idCategorie;
    }

    public MedicamentFilter(String idMaladie, String idCategorie) {
        this.idMaladie = idMaladie;
        this.idCategorie = idCategorie;
    }

}
