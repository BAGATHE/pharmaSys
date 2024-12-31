package model;

import repository.ConversionRepository;
import repository.StockMedicamentRepository;
import java.sql.Connection;
import java.sql.Date;

public class Vente {
    private String idVente;
    private Date dateVente;
    private VenteDetail[] venteDetails;

    public String getIdVente() {
        return idVente;
    }

    public void setIdVente(String idVente) {
        this.idVente = idVente;
    }

    public Date getDateVente() {
        return dateVente;
    }

    public void setDateVente(Date dateVente) {
        this.dateVente = dateVente;
    }

    public VenteDetail[] getVenteDetails() {
        return venteDetails;
    }

    public void setVenteDetails(VenteDetail[] venteDetails) {
        this.venteDetails = venteDetails;
    }

    public String getDateString() {
        return this.getDateVente().toString();
    }

    public double getTotal() {
        double total = 0;
        for (VenteDetail v : this.getVenteDetails()) {
            total += v.getPrixVente() * v.getQuantite();
        }
        return total;
    }

    public Vente(String idVente, Date dateVente, VenteDetail[] venteDetails) {
        this.setIdVente(idVente);
        this.setDateVente(dateVente);
        this.setVenteDetails(venteDetails);
    }

    public void fifo(Connection con) throws Exception {
        try {
            StockMedicament[] stockMedicaments = StockMedicamentRepository.getAllNonPerimesASC(con);
            for (VenteDetail vd : this.getVenteDetails()) {
                double besoin = vd.getQuantite();
                Unite uniteActuel = vd.getUnite().cloner();
                Unite uniteMere = uniteActuel.getMere(con);
                while (uniteMere != null) {
                    Conversion conversion = ConversionRepository.getById(con, uniteMere.getIdUnite(),
                            vd.getMedicament().getIdMedicament());
                    besoin *= 1 / conversion.getQuantite();
                    uniteActuel = uniteMere.cloner();
                    uniteMere = uniteMere.getMere(con);
                }
                for (StockMedicament sm : stockMedicaments) {
                    if (uniteActuel.getIdUnite().equals(sm.getUnite().getIdUnite())
                            && vd.getMedicament().getIdMedicament().equals(sm.getMedicament().getIdMedicament())) {
                        double restant = Math.max(0, sm.getQuantiteBoite() - besoin);
                        besoin -= sm.getQuantiteBoite();

                        sm.setQuantiteBoite(restant);
                        if (besoin <= 0) {
                            break;
                        }
                    }
                }
                if (besoin > 0) {
                    throw new Exception("Stock de " + vd.getUnite().getNom() + " de " + vd.getMedicament().getNom()
                            + " insuffisant ");
                }
            }
            for (StockMedicament sm : stockMedicaments) {
                StockMedicamentRepository.updateStock(con, sm);
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la verification de stock " + e.getMessage());
        }
    }
}
