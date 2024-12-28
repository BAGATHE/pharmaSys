package model;

public class Traitement {
    private Maladie Maladie;
    private Medicament Medicament;
    private int efficacite;

    public Traitement(Maladie maladie, Medicament medicament, int efficacite) {
        this.setMaladie(maladie);
        this.setMedicament(medicament);
        this.efficacite = efficacite;
    }

    public int getEfficacite() {
        return efficacite;
    }

    public void setEfficacite(int efficacite) throws Exception {
        if (efficacite < 0 || efficacite > 100) {
            throw new Exception("efficacité devrais etre entre 0 et 100");
        }
        this.efficacite = efficacite;
    }

    public Medicament getMedicament() {
        return Medicament;
    }

    public void setMedicament(Medicament medicament) {
        Medicament = medicament;
    }

    public Maladie getMaladie() {
        return Maladie;
    }

    public void setMaladie(Maladie maladie) {
        Maladie = maladie;
    }

}
