package model.maladie;

import model.categorie.Categorie;
import model.medicament.Medicament;

public class Traitement {
    private Maladie Maladie;
    private Medicament Medicament;
    private Categorie categorie;
    private int efficacite;

    public Traitement(Maladie maladie, Medicament medicament, int efficacite) {
        this.setMaladie(maladie);
        this.setMedicament(medicament);
        this.efficacite = efficacite;
    }

    public Traitement(model.maladie.Maladie maladie, model.medicament.Medicament medicament, Categorie categorie,
            int efficacite) {
        Maladie = maladie;
        Medicament = medicament;
        this.categorie = categorie;
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

    public Categorie getCategorie() {
        return categorie;
    }

    public void setCategorie(Categorie categorie) {
        this.categorie = categorie;
    }

}
