package model;

public class TypeUnite {
    private String idTypeUnite;
    private String type;

    public TypeUnite() {
    }

    public TypeUnite(String type) {
        this.type = type;
    }

    public TypeUnite(String idTypeUnite, String type) {
        this.idTypeUnite = idTypeUnite;
        this.type = type;
    }

    public String getIdTypeUnite() {
        return idTypeUnite;
    }

    public void setIdTypeUnite(String idTypeUnite) {
        this.idTypeUnite = idTypeUnite;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

}
