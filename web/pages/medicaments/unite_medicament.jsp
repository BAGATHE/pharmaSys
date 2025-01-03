<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.medicament.Medicament"%>
<%@page import="model.configuration.Unite"%>
<%@page import="model.configuration.Conversion"%>


<%
    Conversion[] medicament_unites = (Conversion[]) request.getAttribute("medicament_unites");
    Unite[] unites = (Unite[]) request.getAttribute("unites");
    String id_medicament = (String) request.getAttribute("id_medicament");
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
          <div class="page-header">
            <h3 class="fw-bold mb-3">Médicament</h3>
            <ul class="breadcrumbs mb-3">
              <li class="nav-home">
                <a href="#">
                  <i class="icon-home"></i>
                </a>
              </li>
              <li class="separator">
                <i class="icon-arrow-right"></i>
              </li>
              <li class="nav-item">
                <a href="#">Unité</a>
              </li>
            </ul>
          </div>
         
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <a href="<%= request.getContextPath() %>/medicament/list">
                    <button type="button" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left" style="font-size: 1.5em;"></i> Retour
                    </button>
                </a>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                    <form method="Post" action="" class="row g-3 align-items-center">
                      <input type="hidden" name="id_medicament" value="<%=id_medicament %>" />
                        <div class="col-3">
                                <select class="form-select" id="type_unite" name="unite_mere" required>
                                  <option value="">Veuillez choisir l'Unité Mère</option>
                                  <% 
                                  if (unites != null) {
                                    for (Unite unite : unites) { %>
                                      <option value="<%= unite.getIdUnite() %>">
                                        <%= unite.getNom() %>
                                      </option>
                                      <% } } %>
                                </select>
                        </div>
                        <div class="col-auto">
                          <span class="form-text fs-2 fw-bold">Contient</span>
                        </div>
                        <div class="col-3">
                          <div class="input-group">
                            <input type="number" class="form-control" name="quantite" placeholder="quantite"  >
                            <span class="input-group-text">unité</span>
                          </div>
                        </div>
                        <div class="col-auto">
                          <button type="submit" class="btn btn-success">Ajouter</button>
                        </div>
                      </form>
                  </div>
                  <table class="table table-bordered table-head-bg-success mt-3">
                    <thead>
                        <tr>
                            <th class="text-center" scope="col">Médicament</th>
                            <th class="text-center" scope="col">Unité Mère</th>
                            <th class="text-center" scope="col">Quantité par Boîte</th>
                            <th class="text-center" scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if (medicament_unites != null && medicament_unites.length > 0) { 
                                for (Conversion conversion : medicament_unites) {
                                    Medicament medicament = conversion.getMedicament();
                                    Unite unite_mere = conversion.getUniteMere();
                                    Unite unite_fille = conversion.getUniteFille();
                                    double quantite = conversion.getQuantite();
                                    String idMedicament = medicament.getIdMedicament();  // Récupérer l'ID du médicament
                                    String idUniteMere = unite_mere.getIdUnite();  // Récupérer l'ID de l'unité mère
                                    String idUniteFille = unite_fille.getIdUnite();  // Récupérer l'ID de l'unité fille
                        %>
                            <tr>
                                <td class="text-center"><%= medicament.getNom()  %></td>
                                <td class="text-center"><%= unite_mere.getNom() %></td>
                                <td class="text-center">
                                  <span class="fw-bold  me-3"><%= quantite %>  <%= unite_fille.getNom() %> </span>
                                </td>
                                <td class="text-center">
                                    <!-- Bouton pour supprimer avec modal -->
                                    <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal<%= idMedicament %>_<%= idUniteMere %>_<%= idUniteFille %>">
                                        <i class="fas fa-trash-alt"></i> Supprimer
                                    </button>
                
                                    <!-- Modal de confirmation pour la suppression -->
                                    <div class="modal fade" id="deleteModal<%= idMedicament %>_<%= idUniteMere %>_<%= idUniteFille %>" tabindex="-1" aria-labelledby="deleteModalLabel<%= idMedicament %>_<%= idUniteMere %>_<%= idUniteFille %>" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="deleteModalLabel<%= idMedicament %>_<%= idUniteMere %>_<%= idUniteFille %>">Confirmer la suppression</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    Cette action est irréversible. Voulez-vous vraiment supprimer ?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                    <a href="<%= request.getContextPath() %>/medicament/unite/delete?id_medicament=<%=medicament.getIdMedicament()%>&id_unite=<%= idUniteMere  %>">
                                                        <button type="button" class="btn btn-danger">Supprimer</button>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        <% 
                                } 
                            } else { 
                        %>
                            <tr>
                                <td colspan="5" class="text-center">Aucun médicament trouvé</td>
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
<%@ include file="../elements/footer.jsp" %>