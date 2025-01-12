<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.medicament.Medicament"%>
<%@page import="model.maladie.Maladie"%>
<%@page import="model.categorie.Categorie"%>
<%@page import="model.medicament.PrixMedicament"%>

<%@page import="model.configuration.Unite"%>
<%
    Medicament[] medicaments = (Medicament[]) request.getAttribute("medicaments");
    Categorie[] categories = (Categorie[]) request.getAttribute("categorie");
    Maladie[] maladies = (Maladie[]) request.getAttribute("maladies");

    String message = (String) request.getAttribute("message");
    if (message != null && !message.trim().isEmpty()) {
%>
    <script src="<%= request.getContextPath() %>/assets/js/plugin/sweetalert/sweetalert.min.js"></script>
    <script>
        swal({ title: "Notification", text: "<%= message %>", icon: "info", button: "OK" });
    </script>
<%
        request.setAttribute("message", "");
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
                <a href="#">Liste</a>
              </li>
            </ul>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Liste Médicament </h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                    <form method="POST" action="" class="row g-3">
                      <!-- Liste déroulante pour les catégories -->
                      <div class="col-3">
                          <label for="categorie" class="form-label">Catégorie</label>
                          <select name="categorie" id="categorie" class="form-select">
                              <option value="">-- Toutes les catégories --</option>
                              <%
                                  if (categories != null) {
                                      for (Categorie cat : categories) {
                              %>
                                          <option value="<%= cat.getIdCategorie() %>"><%= cat.getCategorie() %></option>
                              <%
                                      }
                                  }
                              %>
                          </select>
                      </div>
              
                      <!-- Liste déroulante pour les maladies -->
                      <div class="col-3">
                          <label for="maladie" class="form-label">Maladie</label>
                          <select name="maladie" id="maladie" class="form-select">
                              <option value="">-- Toutes les maladies --</option>
                              <%
                                  if (maladies != null) {
                                      for (Maladie mal : maladies) {
                              %>
                                          <option value="<%= mal.getIdMaladie() %>"><%= mal.getNom() %></option>
                              <%
                                      }
                                  }
                              %>
                          </select>
                      </div>
                      <!-- Bouton de soumission -->
                      <div class="col-md-2">
                          <button type="submit" class="btn btn-success">Valider</button>
                      </div>
                  </form>
                  </div>
                  <table class="table table-bordered table-head-bg-success  mt-3">
                    <thead>
                      <tr>
                        <th class="text-center" scope="col">médicament</th>
                        <th class="text-center" scope="col">déscription</th>
                        <th class="text-center" scope="col">Prix de vente</th>
                        <th class="text-center" scope="col">Type d'Unité</th>
                        <th class="text-center" scope="col">Laboratoire Fournisseur</th>
                        <th class="text-center" scope="col">action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <% if (medicaments != null && medicaments.length > 0) {
                          for (Medicament medicament : medicaments) {
                              String idMedicament = medicament.getIdMedicament();
                              PrixMedicament[] prix_medicaments = medicament.getPrixMedicament();
                      %>
                          <tr>
                              <td class="text-center">
                                <a href="<%= request.getContextPath() %>/medicament/confstock?id_medicament=<%= idMedicament %>">
                                  <%= medicament.getNom() %>
                                </a>
                              </td>
                              <td class="text-center"><%= medicament.getDescription() %></td>
                              <td class="text-center">
                                <a href="<%= request.getContextPath() %>/medicament/prix?id_medicament=<%= idMedicament %>">
                                  <button type="button" class="btn btn-info btn-sm">
                                      <i class="fas fa-eye"></i> Consulter
                                  </button>
                              </a>  
                              </td>
                              <td class="text-center">
                                <a href="<%= request.getContextPath() %>/medicament/unite?id_medicament=<%= idMedicament %>">
                                  <button type="button" class="btn btn-info btn-sm">
                                      <i class="fas fa-eye"></i> Consulter
                                  </button>
                              </a>  
                              </td>
                              <td class="text-center">
                                  <a href="<%= request.getContextPath() %>/medicament-laboratoire/list?id_medicament=<%= idMedicament %>">
                                      <button type="button" class="btn btn-info btn-sm">
                                          <i class="fas fa-eye"></i> Consulter
                                      </button>
                                  </a>
                              </td>
                              <td >
                                  <a href="<%= request.getContextPath() %>/medicament/update?id_medicament=<%= idMedicament %>">
                                      <button type="button" class="btn btn-warning btn-sm">
                                          <i class="fas fa-edit"></i> Modifier
                                      </button>
                                  </a>
                                  <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal<%= idMedicament %>">
                                      <i class="fas fa-trash-alt"></i> Supprimer
                                  </button>
                                  <!-- Modal -->
                                  <div class="modal fade" id="deleteModal<%= idMedicament %>" tabindex="-1" aria-labelledby="deleteModalLabel<%= idMedicament %>" aria-hidden="true">
                                      <div class="modal-dialog">
                                          <div class="modal-content">
                                              <div class="modal-header">
                                                  <h5 class="modal-title" id="deleteModalLabel<%= idMedicament %>">Confirmer la suppression</h5>
                                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                              </div>
                                              <div class="modal-body">
                                                  Cette action est irréversible. Voulez-vous vraiment supprimer ce médicament ?
                                              </div>
                                              <div class="modal-footer">
                                                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                  <a href="/medicament/delete?id_medicament=<%= idMedicament %>">
                                                      <button type="button" class="btn btn-danger">Supprimer</button>
                                                  </a>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                              </td>
                          </tr>
                      <%   }
                         } else { %>
                          <tr>
                              <td colspan="6" class="text-center">Aucun médicament trouvé</td>
                          </tr>
                      <% } %>
                    </tbody>                    
                  </table>

      
                </div>
              </div>
            
              
            </div>
            
          </div>

         



        </div>

       









      </div>
<%@ include file="../elements/footer.jsp" %>