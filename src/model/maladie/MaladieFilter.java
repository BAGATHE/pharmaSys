package model.maladie;

public class MaladieFilter {
    private String nom;
    private String nomSymptome;
    private String medicament;
    private int page;
    private int pageSize;

    // Constructeur par défaut
    public MaladieFilter() {
        this.page = 1; // Page par défaut
        this.pageSize = 10; // Taille de page par défaut
    }

    // Constructeur avec tous les paramètres
    public MaladieFilter(String nom, String nomSymptome, String medicament, int page, int pageSize) {
        this.nom = nom;
        this.nomSymptome = nomSymptome;
        this.medicament = medicament;
        setPage(page); // Utilisation du setter pour validation
        setPageSize(pageSize); // Utilisation du setter pour validation
    }

    // Getters et Setters
    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getNomSymptome() {
        return nomSymptome;
    }

    public void setNomSymptome(String nomSymptome) {
        this.nomSymptome = nomSymptome;
    }

    public String getMedicament() {
        return medicament;
    }

    public void setMedicament(String medicament) {
        this.medicament = medicament;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        if (page <= 0) {
            throw new IllegalArgumentException("Page must be greater than 0");
        }
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        if (pageSize <= 0) {
            throw new IllegalArgumentException("Page size must be greater than 0");
        }
        this.pageSize = pageSize;
    }

}
