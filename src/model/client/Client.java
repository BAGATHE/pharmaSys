package model.client;

import java.sql.Timestamp;

public class Client {
    private String idClient;
    private String nom;
    private String identifiant;
    private String typeClient;
    private Timestamp dateCreation;

    public Client() {
    }

    public Client(String idClient, String nom, String identifiant, String typeClient, Timestamp dateCreation) {
        this.idClient = idClient;
        this.nom = nom;
        this.identifiant = identifiant;
        this.typeClient = typeClient;
        this.dateCreation = dateCreation;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getIdentifiant() {
        return identifiant;
    }

    public void setIdentifiant(String identifiant) {
        this.identifiant = identifiant;
    }

    public String getTypeClient() {
        return typeClient;
    }

    public void setTypeClient(String typeClient) {
        this.typeClient = typeClient;
    }

    public Timestamp getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Timestamp dateCreation) {
        this.dateCreation = dateCreation;
    }

}
