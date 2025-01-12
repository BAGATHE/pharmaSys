package model.status;

public class MedicamentStatusStock {
    private String idMedicament;
    private String idStatus;
    private int minimum;
    private int maximum;
    private Status status;

    // Constructeur par défaut
    public MedicamentStatusStock() {
    }

    // Constructeur avec paramètres
    public MedicamentStatusStock(String idMedicament, String idStatus, int minimum, int maximum) {
        this.idMedicament = idMedicament;
        this.idStatus = idStatus;
        this.minimum = minimum;
        this.maximum = maximum;
    }

    // Getters et Setters
    public String getIdMedicament() {
        return idMedicament;
    }

    public void setIdMedicament(String idMedicament) {
        this.idMedicament = idMedicament;
    }

    public String getIdStatus() {
        return idStatus;
    }

    public void setIdStatus(String idStatus) {
        this.idStatus = idStatus;
    }

    public int getMinimum() {
        return minimum;
    }

    public void setMinimum(int minimum) {
        this.minimum = minimum;
    }

    public int getMaximum() {
        return maximum;
    }

    public void setMaximum(int maximum) {
        this.maximum = maximum;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

}
