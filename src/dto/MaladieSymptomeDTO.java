package dto;

public class MaladieSymptomeDTO {
    private String idmaladie;
    private String idSymptome;

    public MaladieSymptomeDTO(String idmaladie, String idSymptome) {
        this.idmaladie = idmaladie;
        this.idSymptome = idSymptome;
    }

    public String getIdmaladie() {
        return idmaladie;
    }

    public void setIdmaladie(String idmaladie) {
        this.idmaladie = idmaladie;
    }

    public String getIdSymptome() {
        return idSymptome;
    }

    public void setIdSymptome(String idSymptome) {
        this.idSymptome = idSymptome;
    }

}
