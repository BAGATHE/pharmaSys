package model;

public class Utilisateur {
    private String idUtilisateur;
    private String nomComplet;
    private String email;
    private String motDePasse;
    private String contact;
    private String role;
    private boolean estHomme;

    public Utilisateur(String nomComplet, String email, String motDePasse, String contact, String role) {
        setIdUtilisateur(idUtilisateur);
        setNomComplet(nomComplet);
        setEmail(email);
        setMotDePasse(motDePasse);
        setContact(contact);
        setRole(role);
    }

    public Utilisateur(String idUtilisateur, String nomComplet, String email, String motDePasse, String contact,
            String role) {
        setIdUtilisateur(idUtilisateur);
        setNomComplet(nomComplet);
        setEmail(email);
        setMotDePasse(motDePasse);
        setContact(contact);
        setRole(role);
    }

    public String getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(String idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public String getNomComplet() {
        return nomComplet;
    }

    public void setNomComplet(String nomComplet) {
        this.nomComplet = nomComplet;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean estHomme() {
        return estHomme;
    }

    public void setEstHomme(boolean estHomme) {
        this.estHomme = estHomme;
    }
}
