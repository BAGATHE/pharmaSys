<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.maladie.Maladie"%>

<%
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
            <h3 class="fw-bold mb-3">Maladie</h3>
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
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Liste Maladies </h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                      <form method="GET" action="" class="row g-3">
                        <div class="col-3">
                          <input type="text" class="form-control" name="maladie" placeholder="Filtrer par maladie" value="<%= request.getParameter("maladie") != null ? request.getParameter("maladie") : "" %>">
                        </div>
                        <div class="col-3">
                          <input type="text" class="form-control" name="symptome" placeholder="Filtrer par symptome" value="<%= request.getParameter("symptome") != null ? request.getParameter("symptome") : "" %>">
                        </div>
                        <div class="col-3">
                          <input type="text" class="form-control" name="medicament" placeholder="Filtrer par medicament" value="<%= request.getParameter("medicament") != null ? request.getParameter("medicament") : "" %>">
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
                        <th class="text-center" scope="col">Maladie</th>
                        <th class="text-center" scope="col">Description</th>
                        <th class="text-center" scope="col">Symptômes & Traitement</th>
                        <th class="text-center" scope="col">Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <% 
                        Maladie[] maladies = (Maladie[]) request.getAttribute("maladies");
                        for (int i = 0; i < maladies.length; i++) {
                          Maladie maladie = maladies[i];
                      %>
                        <tr>
                          <td><%= maladie.getIdMaladie() %></td>
                          <td class="text-center"><%= maladie.getNom() %></td>
                          <td class="text-center"><%= maladie.getDescription() %></td>
                          <td class="text-center">
                            <a href="<%= request.getContextPath() %>/maladies/symptome_traitement_liste?idMaladie=<%= maladie.getIdMaladie() %>"> 
                              <button type="button" class="btn btn-info btn-sm">
                                  <i class="fas fa-eye"></i> Consulter
                              </button>
                            </a>
                          </td>
                          <td class="text-center">
                            <a href="<%= request.getContextPath() %>/maladies/update?idMaladie=<%= maladie.getIdMaladie() %>">
                              <button type="button" class="btn btn-warning btn-sm">
                                  <i class="fas fa-edit"></i> Modifier
                              </button>
                            </a>
                            <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal<%= maladie.getIdMaladie() %>">
                                <i class="fas fa-trash-alt"></i> Supprimer
                            </button>
                            <div class="modal fade" id="deleteModal<%= maladie.getIdMaladie() %>" tabindex="-1" aria-labelledby="deleteModalLabel<%= maladie.getIdMaladie() %>" aria-hidden="true">
                                <div class="modal-dialog">
                                  <div class="modal-content">
                                    <div class="modal-header">
                                      <h5 class="modal-title" id="deleteModalLabel<%= maladie.getIdMaladie() %>">Confirmer la suppression</h5>
                                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                      Êtes-vous sûr de vouloir supprimer cette Maladie ?
                                    </div>
                                    <div class="modal-footer">
                                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                      <a href="<%= request.getContextPath() %>/maladies/delete?idMaladie=<%= maladie.getIdMaladie() %>">
                                        <button type="button" class="btn btn-danger">Supprimer</button>
                                      </a>
                                    </div>
                                  </div>
                                </div>
                            </div>
                          </td>
                        </tr>
                      <% } %>
                    </tbody>
                  </table>

                  <!-- Pagination -->
                  <nav>
                    <ul class="pagination justify-content-center">
                      <% if ((int) request.getAttribute("currentPage") > 1) { %>
                        <li class="page-item">
                          <a class="page-link" href="<%= request.getContextPath() %>/maladies/liste?page=<%= (int) request.getAttribute("currentPage") - 1 %>">Précédent</a>
                        </li>
                      <% } %>
                      <% for (int i = 1; i <= (int) request.getAttribute("totalPages"); i++) { %>
                        <li class="page-item <%= (i == (int) request.getAttribute("currentPage")) ? "active" : "" %>">
                          <a class="page-link" href="<%= request.getContextPath() %>/maladies/liste?page=<%= i %>"><%= i %></a>
                        </li>
                      <% } %>
                      <% if ((int) request.getAttribute("currentPage") < (int) request.getAttribute("totalPages")) { %>
                        <li class="page-item">
                          <a class="page-link" href="<%= request.getContextPath() %>/maladies/liste?page=<%= (int) request.getAttribute("currentPage") + 1 %>">Suivant</a>
                        </li>
                      <% } %>
                    </ul>
                  </nav>

                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
<%@ include file="../elements/footer.jsp" %>
