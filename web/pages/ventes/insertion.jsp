<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.Medicament"%>
<%@page import="model.PrixMedicament"%>
<%@page import="model.Unite"%>
<%@page import="model.TypeUnite"%>

<%
    Medicament[] medicaments = (Medicament[]) request.getAttribute("medicaments");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    if (message != null && !message.trim().isEmpty()) {
     %>
         <script src="<%= request.getContextPath() %>/assets/js/plugin/sweetalert/sweetalert.min.js"></script>
         <script>
             swal({ title: "Notification", text: "<%= message %>", icon: "success", button: "OK" });
         </script>
     <%
             request.setAttribute("message", "");
         }
         if (error != null && !error.trim().isEmpty()) {
     %>
         <script src="<%= request.getContextPath() %>/assets/js/plugin/sweetalert/sweetalert.min.js"></script>
         <script>
             swal({ title: "Erreur", text: "<%= error %>", icon: "error", button: "OK" });
         </script>
     <%
             request.setAttribute("error", "");
         }
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
              <form action="" method="post">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                </div>
                <div class="card-body">
                    <div class="card-sub">
                        <div class="row mb-3">
                        </div>
                        <table class="table table-bordered table-head-bg-success mt-3">
                          <thead>
                              <tr>
                                  <th class="text-center" scope="col">Médicament</th>
                                  <th class="text-center" scope="col">Catalogue et prix</th>
                                  <th class="text-center" scope="col">quantité</th>
                                  <th class="text-center" scope="col">Unité</th>
                                  <th class="text-center" scope="col">Total</th>
                              </tr>
                          </thead>
                          <tbody>
                            <% if (medicaments != null && medicaments.length > 0) {
                              int nombre_ligne = 0;
                              int indice = 0;
                                for (int i = 0; i < medicaments.length; i++) {
                                    Medicament medicament = medicaments[i];
                                    String idMedicament = medicament.getIdMedicament();
                                    PrixMedicament[] prixMedicaments = medicament.getPrixMedicament();
                                    if(prixMedicaments.length > 0){  nombre_ligne+=1;%>
                                      
                                      <tr>
                                        <td class="text-center">
                                            <%= medicament.getNom() %>
                                            <input type="hidden" name="idMedicament_<%=indice  %>" value="<%= idMedicament %>">
                                        </td>
                                        <td class="text-center">
                                            <!-- Bouton pour afficher le modal -->
                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalPrix_<%=indice %>">
                                                Voir
                                            </button>
                                            <!-- Modal -->
                                            <div class="modal fade" id="modalPrix_<%= indice %>" tabindex="-1" aria-labelledby="modalPrixLabel_<%= indice %>" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="modalPrixLabel_<%= indice %>">Catalogue et Prix pour <%= medicament.getNom() %></h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <% if (prixMedicaments != null && prixMedicaments.length > 0) { %>
                                                                <table class="table table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Prix Unitaire</th>
                                                                            <th>Unité</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <% for (PrixMedicament prix : prixMedicaments) { %>
                                                                            <tr>
                                                                                <td><%= prix.getPrixVenteUnitaire() %> Ar</td>
                                                                                <td><%= prix.getUnite().getNom() %></td>
                                                                            </tr>
                                                                        <% } %>
                                                                    </tbody>
                                                                </table>
                                                            <% } else { %>
                                                                <p>Aucun prix disponible pour ce médicament.</p>
                                                            <% } %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <input type="number" name="quantite_<%= indice %>" class="form-control quantite" min="0" value="0" onchange="calculerTotal()"/>
                                        </td>
                                        <td class="text-center">
                                            <% if (prixMedicaments != null && prixMedicaments.length > 0) { %>
                                              <select name="unite_<%= indice %>" class="form-select" required>
                                                <% for (PrixMedicament prix : prixMedicaments) { %>
                                                  <option value="<%= prix.getUnite().getIdUnite() %>" data-prix="<%= prix.getPrixVenteUnitaire() %>">
                                                    <%= prix.getUnite().getNom() %>
                                                  </option>
                                                <% } %>
                                              </select>                                              
                                            <% } else { %>
                                                <p>Aucune unité disponible.</p>
                                            <% } %>
                                        </td>
                                        <td class="text-center">
                                            <span class="ligne-total">0</span> 
                                        </td>
                                    </tr>
      
                            <% indice+=1 ; }  } %>
                            <input type="hidden" name="nombreLignes" value="<%= nombre_ligne %>">
                            <% } else { %>
                            <tr>
                                <td class="text-center" colspan="5">Aucun médicament.</td>
                            </tr>
                            <% } %>
                            <tr>
                                <td colspan="4" class="text-end fw-bold">Total Général:</td>
                                <td class="text-center"><span id="total-general" class="fw-bold">0</span> </td>
                            </tr>
                        </tbody>
                        
                      </table> 
                </div>
              </div>
              <div class="card-action">
                <div class="row align-items-center">
                  <div class="col-md-4">
                      <div class="form-group">
                          <label for="date-commande">Date de Vente</label>
                          <input type="date" class="form-control" id="date-commande" name="date_commande" required>
                      </div>
                  </div>
                  <div class="col-md-8 text-end">
                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalConfirmation">
                      Valider
                    </button>
                  </div>
              </div>
              </div>
            </div>
             <!-- Modal simple -->
             <div class="modal fade" id="modalConfirmation" tabindex="-1">
              <div class="modal-dialog">
                  <div class="modal-content">
                      <div class="modal-header">
                          <h5 class="modal-title">Confirmation</h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                      </div>
                      <div class="modal-body">
                          <p>Avez-vous bien vérifié la commande ?</p>
                      </div>
                      <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Non</button>
                          <button type="submit" class="btn btn-success">OUI, je confirme</button>
                      </div>
                  </div>
              </div>
          </div>
            </form>
            
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