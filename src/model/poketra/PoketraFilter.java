package model.poketra;

public class PoketraFilter {
    private String nomPoketra;
    private String idType;
    private String idLook;
    private int page;
    private int pageSize;

    // Constructeurs
    public PoketraFilter(String nomPoketra, String idType, String idLook, int page, int pageSize) {
        this.nomPoketra = nomPoketra;
        this.idType = idType;
        this.idLook = idLook;
        this.page = page;
        this.pageSize = pageSize;
    }

    // Getters et setters
    public String getNomPoketra() {
        return nomPoketra;
    }

    public void setNomPoketra(String nomPoketra) {
        this.nomPoketra = nomPoketra;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public String getIdLook() {
        return idLook;
    }

    public void setIdLook(String idLook) {
        this.idLook = idLook;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
}
