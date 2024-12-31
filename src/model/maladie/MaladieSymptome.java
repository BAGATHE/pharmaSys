package model.maladie;

public class MaladieSymptome {
    private String idMaladie;
    private String idSymptome;

    public MaladieSymptome(String idMaladie, String idSymptome) {
        this.idMaladie = idMaladie;
        this.idSymptome = idSymptome;
    }

    public String getIdMaladie() {
        return idMaladie;
    }

    public void setIdMaladie(String idMaladie) {
        this.idMaladie = idMaladie;
    }

    public String getIdSymptome() {
        return idSymptome;
    }

    public void setIdSymptome(String idSymptome) {
        this.idSymptome = idSymptome;
    }

}
