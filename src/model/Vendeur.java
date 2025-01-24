package model;

import model.vente.Vente;

public class Vendeur extends Utilisateur {
     private Vente[] ventes;
     // Constructeur pour initialiser un vendeur
    public Vendeur(String idUtilisateur, String nomComplet, String email, String motDePasse, String contact, Vente[] ventes) {
        super(idUtilisateur, nomComplet, email, motDePasse, contact, "vendeur"); 
        this.ventes = ventes;
    }

    // Getter pour les ventes
    public Vente[] getVentes() {
        return ventes;
    }

    // Setter pour les ventes
    public void setVentes(Vente[] ventes) {
        this.ventes = ventes;
    }
    public double getTotalCommission(){
        double commission = 0;
        for (Vente vente: this.getVentes()) {
            commission += vente.getCommissionVendeur();
        }
        return commission;
    }

}
