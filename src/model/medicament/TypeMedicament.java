package model.medicament;

public class TypeMedicament {
    private String idType;
    private String typeMedicament;

    // Constructeur avec l'ID et le type de médicament
    public TypeMedicament(String idType, String typeMedicament) {
        this.idType = idType;
        this.typeMedicament = typeMedicament;
    }

    public TypeMedicament(String idType) {
        this.idType = idType;
    }

    // Getters et setters
    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public String getTypeMedicament() {
        return typeMedicament;
    }

    public void setTypeMedicament(String typeMedicament) {
        this.typeMedicament = typeMedicament;
    }

    @Override
    public String toString() {
        return "TypeMedicament{" +
                "idType='" + idType + '\'' +
                ", typeMedicament='" + typeMedicament + '\'' +
                '}';
    }
}
