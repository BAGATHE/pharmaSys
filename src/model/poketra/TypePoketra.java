package model.poketra;
public class TypePoketra {
    private String idTypePoketra;
    private String typePoketra;

    // Constructeur
    public TypePoketra(String idTypePoketra, String typePoketra) {
        this.idTypePoketra = idTypePoketra;
        this.typePoketra = typePoketra;
    }

    // Getters et Setters
    public String getIdTypePoketra() {
        return idTypePoketra;
    }

    public void setIdTypePoketra(String idTypePoketra) {
        this.idTypePoketra = idTypePoketra;
    }

    public String getTypePoketra() {
        return typePoketra;
    }

    public void setTypePoketra(String typePoketra) {
        this.typePoketra = typePoketra;
    }

    // Méthode toString pour afficher les informations de l'objet
    @Override
    public String toString() {
        return "TypePoketra{" +
                "idTypePoketra='" + idTypePoketra + '\'' +
                ", typePoketra='" + typePoketra + '\'' +
                '}';
    }
}
