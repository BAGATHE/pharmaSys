package model.recommandation;

public class RecommandationFilter {
    private String date;
    private String idMedicament;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getIdMedicament() {
        return idMedicament;
    }

    public void setIdMedicament(String idMedicament) {
        this.idMedicament = idMedicament;
    }

    public RecommandationFilter(String date, String idMedicament) {
        this.date = date;
        this.idMedicament = idMedicament;
    }
}
