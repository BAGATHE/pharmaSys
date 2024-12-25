package model.poketra;
public class LookPoketra {
    private String idLook;
    private String look;

    // Constructeur
    public LookPoketra(String idLook, String look) {
        this.idLook = idLook;
        this.look = look;
    }

    // Getters et Setters
    public String getIdLook() {
        return idLook;
    }

    public void setIdLook(String idLook) {
        this.idLook = idLook;
    }

    public String getLook() {
        return look;
    }

    public void setLook(String look) {
        this.look = look;
    }

    // Méthode toString pour afficher les informations de l'objet
    @Override
    public String toString() {
        return "LookPoketra{" +
                "idLook='" + idLook + '\'' +
                ", look='" + look + '\'' +
                '}';
    }
}
