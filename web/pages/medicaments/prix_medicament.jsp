<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.Medicament"%>
<%@page import="model.Unite"%>
<%@page import="model.PrixMedicament"%>


<%
    PrixMedicament[] prix_medicaments = (PrixMedicament[]) request.getAttribute("prix_medicaments");
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
                <a href="#">Prix</a>
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
                        <select class="form-select" id="type_unite" name="unite" required>
                          <option value="">Veuillez choisir l'Unité</option>
                          <% if (unites != null) {
                              for (Unite unite : unites) { %>
                                <option value="<%= unite.getIdUnite() %>">
                                  <%= unite.getNom() %>
                                </option>
                          <% } } %>
                        </select>
                      </div>
                  
                      <div class="col-auto">
                        <span class="form-text fs-2 fw-bold">Coûte</span>
                      </div>
                  
                      <div class="col-3">
                        <div class="input-group">
                          <input type="number" class="form-control" name="prix_vente" placeholder="Prix de vente">
                          <span class="input-group-text">Ar</span>
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
                            <th class="text-center" scope="col">Unité</th>
                            <th class="text-center" scope="col">Prix Unitaire</th>
                            <th class="text-center" scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if (prix_medicaments != null && prix_medicaments.length > 0) {
                                for (PrixMedicament pm : prix_medicaments) { 
                        %>
                        <tr>
                            <td class="text-center"><%= pm.getMedicament().getNom() %></td>
                            <td class="text-center"><%= pm.getUnite().getNom() %></td>
                            <td class="text-center">
                              <span class="fw-bold  me-3"><%= pm.getPrixVenteUnitaire() %> Ar</span>
                              <a href="<%= request.getContextPath() %>/medicament/prix/update?id_prix_medicament=<%= pm.getIdPrixMedicament() %>" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> Modifier
                              </a>
                            </td>

                            <td class="text-center">
                                <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal<%= pm.getIdPrixMedicament() %>">
                                    <i class="fas fa-trash-alt"></i> Supprimer
                                </button>
                                <!-- Modal -->
                                <div class="modal fade" id="deleteModal<%= pm.getIdPrixMedicament() %>" tabindex="-1" aria-labelledby="deleteModalLabel<%= pm.getIdPrixMedicament() %>" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="deleteModalLabel<%= pm.getIdPrixMedicament() %>">Confirmer la suppression</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                Êtes-vous sûr de vouloir supprimer ce prix de médicament ?
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                <a href="<%= request.getContextPath() %>/medicament/prix/delete?id_prix_medicament=<%= pm.getIdPrixMedicament() %>&id_medicament=<%= pm.getMedicament().getIdMedicament()%>">
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
                            <td colspan="7" class="text-center">Aucun prix de médicament trouvé.</td>
                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>

                    <!-- Pagination -->
        <nav>
            <ul class="pagination justify-content-center">
              <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1">Previous</a>
              </li>
              <li class="page-item active">
                <a class="page-link" href="#">1</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">2</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">3</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">Next</a>
              </li>
            </ul>
          </nav>
                </div>
              </div>
            
              
            </div>
            
          </div>

         



        </div>

       









      </div>
<%@ include file="../elements/footer.jsp" %>