package dto;

import model.configuration.Unite;

public class UniteDTO {
    private Unite uniteParent;
    private Unite uniteEnfant;

    public UniteDTO(Unite uniteParent, Unite uniteEnfant) {
        this.uniteParent = uniteParent;
        this.uniteEnfant = uniteEnfant;
    }

    public Unite getUniteParent() {
        return uniteParent;
    }

    public void setUniteParent(Unite uniteParent) {
        this.uniteParent = uniteParent;
    }

    public Unite getUniteEnfant() {
        return uniteEnfant;
    }

    public void setUniteEnfant(Unite uniteEnfant) {
        this.uniteEnfant = uniteEnfant;
    }

}
