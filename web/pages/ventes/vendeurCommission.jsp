<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@ page import="model.Vendeur" %>
<%@ page import="model.vente.Vente" %>
<%@ page import="dto.VendeurDTO" %>

<%
Vendeur[] vendeurs = (Vendeur[]) request.getAttribute("vendeurs");
VendeurDTO[] commissions = (VendeurDTO[]) request.getAttribute("commissions");
%>

<div class="main-panel">
    <div class="main-header">
      <div class="main-header-logo">
        <!-- Logo Header -->
        <div class="logo-header" data-background-color="dark">
          <a href="index.html" class="logo">
            <img
              src="<%= request.getContextPath() %>assets/img/kaiadmin/logo_light.svg"
              alt="navbar brand"
              class="navbar-brand"
              height="20"
            />
          </a>
          <div class="nav-toggle">
            <button class="btn btn-toggle toggle-sidebar">
              <i class="gg-menu-right"></i>
            </button>
            <button class="btn btn-toggle sidenav-toggler">
              <i class="gg-menu-left"></i>
            </button>
          </div>
          <button class="topbar-toggler more">
            <i class="gg-more-vertical-alt"></i>
          </button>
        </div>
        <!-- End Logo Header -->
      </div>
      <!-- Navbar Header -->
      <nav
        class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom"
        style="background-color: #171a38;"
      >
        <div class="container-fluid">
          <nav
            class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex"
          >
            
          </nav>

          <ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
           
          </ul>
        </div>
      </nav>
      <!-- End Navbar -->
    </div>

    <div class="container">
        <div class="page-inner">
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">

                </div>
                <div class="card-body">
                    <div class="card-sub">
                        <div class="row mb-3">
                            <form  method="POST" action=""class="row g-3">
                                <div class="col-3">
                                  <div class="form-group">
                                    <label for="nom">date min </label>
                                    <input
                                      type="date"
                                      class="form-control"
                                      name="date_debut"
                                    />
                                  </div>
                                </div>
                                <div class="col-3">
                                  <div class="form-group">
                                    <label for="nom">date max</label>
                                    <input
                                      type="date"
                                      class="form-control"
                                      name="date_fin"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-2">
                                  <button type="submit" class="btn btn-success">Valider</button>
                              </div>
                                </form>
                        </div>
                        <table class="table table-bordered table-head-bg-success mt-3">
                            <thead>
                                <tr>
                                    <th scope="col">Nom Vendeur</th>
                                    <th scope="col">genre</th>
                                    <th scope="col">Total Commission</th>
                                    <th scope="col">voir</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                if (vendeurs != null && vendeurs.length > 0) { 
                                    int indice = 0; // Initialisation de l'indice
                                    for (int i = 0; i < vendeurs.length; i++) {
                                        Vendeur vendeur = vendeurs[i];
                                %>
                                <tr>
                                    <td><%= vendeur.getNomComplet() %></td>
                                    <td><%= vendeur.estHomme()? "Homme" : "Femme" %></td>
                                    <td><span class="fw-bold"><%= String.format("%,.2f", vendeur.getTotalCommission()) %> Ar</span></td> 
                                    <td class="text-center">
                                        <!-- Bouton pour afficher le modal -->
                                        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#modalPrix_<%= indice %>">
                                            Voir
                                        </button>
                            
                                        <!-- Modal -->
                                        <div class="modal fade" id="modalPrix_<%= indice %>" tabindex="-1" aria-labelledby="modalPrixLabel_<%= indice %>" aria-hidden="true">
                                            <div class="modal-dialog  modal-lg">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="modalPrixLabel_<%= indice %>">Détails des ventes de <%= vendeur.getNomComplet() %></h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <% 
                                                        Vente[] ventes = vendeur.getVentes();
                                                        if (ventes != null && ventes.length > 0) {
                                                        %>
                                                        <table class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th>ID Vente</th>
                                                                    <th>Date Vente</th>
                                                                    <th>Client</th>
                                                                    <th>Total Vente</th>
                                                                    <th>Commission</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (Vente vente : ventes) { %>
                                                                <tr>
                                                                    <td><%= vente.getIdVente() %></td>
                                                                    <td><%= vente.getDateVente() %></td>
                                                                    <td><%= vente.getClient().getNom() %></td>
                                                                    <td><%= String.format("%,.2f", vente.getTotal()) %> Ar</td>
                                                                    <td><%= String.format("%,.2f", vente.getCommissionVendeur()) %> Ar</td>
                                                                </tr>
                                                                <% } %>
                                                            </tbody>
                                                        </table>
                                                        <% } else { %>
                                                        <p>Aucune vente trouvée pour ce vendeur.</p>
                                                        <% } %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <% 
                                        indice++; 
                                    } 
                                } else { 
                                %>
                                <tr>
                                    <td class="text-center" colspan="5">Aucun vendeur.</td>
                                </tr>
                                <% } %>
                                <input type="hidden" name="nombreLignes" value="<%= vendeurs != null ? vendeurs.length : 0 %>">
                            </tbody>
                            
                        
                      </table>
                      <h3 class="text-center"> Groupage par genre</h3> 
                      <table class="table table-bordered table-head-bg-success mt-3">
                        <thead>
                            <tr>
                                <th scope="col">Genre</th>
                                <th scope="col">Total Commission</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            if (commissions != null) {
                                for (VendeurDTO vendeur : commissions) {
                            %>
                                    <tr>
                                        <td><%= vendeur.getGenre() %></td>
                                        <td><%= vendeur.getSomme() %></td>
                                    </tr>
                            <%
                                }
                            } else {
                            %>
                                <tr>
                                    <td colspan="2">Aucune commission disponible.</td>
                                </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                </div>
              </div>
             
            </div>
           
            
          </div>

         



        </div>

       









      </div>
      <script>
        document.addEventListener("DOMContentLoaded", function () {
  // Fonction pour calculer les totaux
  function calculerTotal() {
    let lignes = document.querySelectorAll("tbody tr");
    let totalGeneral = 0;

    lignes.forEach((ligne) => {
      let quantiteInput = ligne.querySelector(".quantite");
      let uniteSelect = ligne.querySelector(".form-select");
      let ligneTotalElement = ligne.querySelector(".ligne-total");

      if (quantiteInput && uniteSelect && ligneTotalElement) {
        let quantite = parseFloat(quantiteInput.value) || 0;
        let prixUnitaire = parseFloat(uniteSelect.options[uniteSelect.selectedIndex]?.dataset?.prix) || 0;
        let ligneTotal = quantite * prixUnitaire;

        // Mettre à jour le total de la ligne
        ligneTotalElement.textContent = ligneTotal.toFixed(2) + " Ar";

        // Ajouter au total général
        totalGeneral += ligneTotal;
      }
    });

    // Mettre à jour le total général
    document.getElementById("total-general").textContent = totalGeneral.toFixed(2) + " Ar";
  }

  // Écouteurs pour les inputs de quantité et les selects d'unité
  document.querySelectorAll(".quantite").forEach((input) => {
    input.addEventListener("change", calculerTotal);
  });

  document.querySelectorAll(".form-select").forEach((select) => {
    select.addEventListener("change", calculerTotal);
  });
});

      </script>
      
    
<%@ include file="../elements/footer.jsp" %>