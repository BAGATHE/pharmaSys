package model.poketra;

public class Poketra {
    private String idPoketra;
    private String nomPoketra;
    private LookPoketra lookPoketra; 
    private TypePoketra typePoketra; 

    // Constructeur
    public Poketra(String idPoketra, String nomPoketra, LookPoketra lookPoketra, TypePoketra typePoketra) {
        this.idPoketra = idPoketra;
        this.nomPoketra = nomPoketra;
        this.lookPoketra = lookPoketra;
        this.typePoketra = typePoketra;
    }

    // Getters et Setters
    public String getIdPoketra() {
        return idPoketra;
    }

    public void setIdPoketra(String idPoketra) {
        this.idPoketra = idPoketra;
    }

    public String getNomPoketra() {
        return nomPoketra;
    }

    public void setNomPoketra(String nomPoketra) {
        this.nomPoketra = nomPoketra;
    }

    public LookPoketra getLookPoketra() {
        return lookPoketra;
    }

    public void setLookPoketra(LookPoketra lookPoketra) {
        this.lookPoketra = lookPoketra;
    }

    public TypePoketra getTypePoketra() {
        return typePoketra;
    }

    public void setTypePoketra(TypePoketra typePoketra) {
        this.typePoketra = typePoketra;
    }

     






}
