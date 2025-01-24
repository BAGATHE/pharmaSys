package dto;

public class VendeurDTO {
    private String genre;
    private double somme;

    
    public VendeurDTO(String genre, double somme) {
        this.genre = genre;
        this.somme = somme;
    }
    public String getGenre() {
        return genre;
    }
    public void setGenre(String genre) {
        this.genre = genre;
    }
    public double getSomme() {
        return somme;
    }
    public void setSomme(double somme) {
        this.somme = somme;
    }
    
}
