<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.MedicamentLaboratoire"%>
<% 
   MedicamentLaboratoire[] medicament_laboratoires = (MedicamentLaboratoire[]) request.getAttribute("medicament_laboratoires");
   String id_laboratoire = (String) request.getAttribute("id_laboratoire");
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
                <input type="hidden" name="id_laboratoire" value="<%=id_laboratoire%>"/>
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <a href="<%= request.getContextPath() %>/achat/laboratoire">
                    <button type="button" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left" style="font-size: 1.5em;"></i> Retour
                    </button>
                </a>
                </div>
                <div class="card-body">
                    <div class="card-sub">
                        <div class="row mb-3">
                        </div>
                        <table class="table table-bordered table-head-bg-success mt-3">
                          <thead>
                              <tr>
                                  <th class="text-center" scope="col">Médicament</th>
                                  <th class="text-center" scope="col">Unité</th>
                                  <th class="text-center" scope="col">Prix Achat</th>
                                  <th class="text-center" scope="col">Minimum Achat</th>
                                  <th class="text-center" scope="col">quantité</th>
                                  <th class="text-center" scope="col">Date Péremption</th>
                                  <th class="text-center" scope="col">Total</th>
                              </tr>
                          </thead>
                          <tbody>
                              <% if (medicament_laboratoires != null && medicament_laboratoires.length > 0) { 
                                  for (int i = 0; i < medicament_laboratoires.length; i++) { 
                                      MedicamentLaboratoire medLab = medicament_laboratoires[i];
                              %>
                              <tr>
                                  <td class="text-center">
                                    <%= medLab.getMedicament().getNom() %>
                                    <input type="hidden" name="idMedicament_<%= i %>" value="<%= medLab.getMedicament().getIdMedicament() %>">
                                  </td>
                                  <td class="text-center">
                                    <%= medLab.getUnite().getNom() %>
                                    <input type="hidden" name="idUnite_<%= i %>" value="<%= medLab.getUnite().getIdUnite() %>">
                                  </td>
                                  <td class="text-center">
                                      <span class="fw-bold prix-achat"><%= medLab.getPrixAchat() %></span> Ar
                                      <input type="hidden" name="prixAchat_<%= i %>" value="<%= medLab.getPrixAchat() %>">
                                  </td>
                                  <td class="text-center">
                                    <%= medLab.getMinimumAchat() %>
                                    <input type="hidden" name="minimumAchat_<%= i %>" value="<%= medLab.getMinimumAchat() %>">
                                  </td>
                                  <td class="text-center">
                                    <input type="number" name="quantite_<%= i %>" class="form-control quantite" min="0" value="0" onchange="calculerTotal()"/>
                                  </td>
                                  <td class="text-center">
                                    <input type="date" class="form-control" name="date_peremption_<%= i %>" required>
                                  </td>
                                  <td class="text-center">
                                      <span class="ligne-total">0</span> Ar
                                  </td>
                              </tr>
                              <%  }  %>
                              <input type="hidden" name="nombreLignes" value="<%= medicament_laboratoires.length %>">
                              <% } else { %>
                              <tr>
                                  <td class="text-center" colspan="6">Aucun médicament trouvé pour ce laboratoire.</td>
                              </tr>
                              <% }  %>
                              <tr>
                                  <td colspan="5" class="text-end fw-bold">Total Général:</td>
                                  <td class="text-center"><span id="total-general" class="fw-bold">0</span> Ar</td>
                              </tr>
                          </tbody>
                      </table> 
                </div>
              </div>
              <div class="card-action">
                <div class="row align-items-center">
                  <div class="col-md-4">
                      <div class="form-group">
                          <label for="date-commande">Date de commande</label>
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
        function calculerTotal() {
            let totalGeneral = 0;
            
            // Sélectionner toutes les lignes sauf la dernière (total général)
            const lignes = document.querySelectorAll('tbody tr:not(:last-child)');
            
            lignes.forEach(ligne => {
                const prixAchat = parseFloat(ligne.querySelector('.prix-achat')?.textContent || 0);
                const quantite = parseFloat(ligne.querySelector('.quantite')?.value || 0);
                
                const totalLigne = prixAchat * quantite;
                ligne.querySelector('.ligne-total').textContent = totalLigne.toLocaleString();
                totalGeneral += totalLigne;
            });
            
            // Mettre à jour le total général
            document.getElementById('total-general').textContent = totalGeneral.toLocaleString();
        }
        
        // Initialiser les totaux au chargement de la page
        document.addEventListener('DOMContentLoaded', calculerTotal);
        </script>
<%@ include file="../elements/footer.jsp" %>