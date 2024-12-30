<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>

<%@page import="dto.UniteDTO"%>
<%@page import="model.Unite"%>

<%
    UniteDTO[] unites = (UniteDTO[]) request.getAttribute("unites");
    String message = (String) request.getAttribute("message");
    if (message != null && !message.trim().isEmpty()) {
%>
    <script src="<%= request.getContextPath() %>/assets/js/plugin/sweetalert/sweetalert.min.js"></script>
    <script>
        swal({ title: "Notification",text: "<%= message %>",icon: "info", button: "OK"});
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
            <h3 class="fw-bold mb-3">Unité</h3>
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
            <div class="offset-md-2 col-md-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Liste Unité </h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                    <form method="GET" action="/your-filter-endpoint" class="row g-3">
                        <div class="col-md-5">
                          <input type="text" class="form-control" name="filterFirst" placeholder="Filtrer par nom">
                        </div>
                        <div class="col-md-2">
                          <button type="submit" class="btn btn-success">Valider</button>
                        </div>
                      </form>
                  </div>
                  <table class="table table-bordered table-head-bg-success mt-3">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th class="text-center" scope="col">Unité </th>
                            <th class="text-center" scope="col">Unité Mere</th>
                            <th class="text-center" scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if (unites != null && unites.length > 0) {
                                int index = 1; // Compteur pour l'index des unités
                                for (UniteDTO dto : unites) { 
                                    Unite uniteEnfant = dto.getUniteEnfant();
                                    Unite uniteParent = dto.getUniteParent();
                        %>
                        <tr>
                            <td class="text-center"><%= index++ %></td>
                            <td class="text-center"><%= uniteEnfant != null ? uniteEnfant.getNom() : "N/A" %></td>
                            <td class="text-center"><%= uniteParent != null ? uniteParent.getNom() : "" %></td>
                            <td class="text-center">
                                <!-- Bouton Modifier -->
                                <a href="<%= request.getContextPath() %>/unite/update?id_unite=<%= uniteEnfant.getIdUnite() %>" 
                                   class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                
                                <!-- Bouton Supprimer -->
                                <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" 
                                        data-bs-target="#deleteModal<%= uniteEnfant.getIdUnite() %>">
                                    <i class="fas fa-trash-alt"></i> Supprimer
                                </button>
                                
                                <!-- Modal -->
                                <div class="modal fade" id="deleteModal<%= uniteEnfant.getIdUnite() %>" tabindex="-1" 
                                     aria-labelledby="deleteModalLabel<%= uniteEnfant.getIdUnite() %>" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="deleteModalLabel<%= uniteEnfant.getIdUnite() %>">
                                                    Confirmer la suppression
                                                </h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                Êtes-vous sûr de vouloir supprimer l'unité "<%= uniteEnfant.getNom() %>" ?
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                <a href="<%= request.getContextPath() %>/unite/delete?id_unite=<%= uniteEnfant.getIdUnite() %>">
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
                            <td colspan="4" class="text-center">Aucune unité trouvée.</td>
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