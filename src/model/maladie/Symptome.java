package model.maladie;

public class Symptome {
    private String idSymptome;
    private String nom;

    public Symptome(String nom) {
        this.nom = nom;
    }

    public Symptome(String idSymptome, String nom) {
        this.idSymptome = idSymptome;
        this.nom = nom;
    }

    public String getIdSymptome() {
        return idSymptome;
    }

    public void setIdSymptome(String idSymptome) {
        this.idSymptome = idSymptome;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}