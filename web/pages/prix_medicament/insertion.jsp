<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.configuration.Unite"%>
<%@page import="model.medicament.Medicament"%>
<%
 
    Unite[] unites = (Unite[]) request.getAttribute("unites");
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

     <!-- debut container -->
    <div class="container">
        <div class="page-inner">
          <div class="page-header">
            <h3 class="fw-bold mb-3">Configuration Prix</h3>
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
                <a href="#">Formulaire Insertion</a>
              </li>
            </ul>
          </div>
          <div class="row">
            <div class="offset-md-2 col-md-8">
                <!--debut formulaire-->
              <form method="post" action="" accept-charset="UTF-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title"><h2 class="text-center" style="color: white;">Configuration</h2></div>
                </div>
                <div class="card-body">
                  <div class="row">
                    <div class="offset-md-3 col-md-6 offset-lg-2 col-lg-8">

                        <div class="row">
                            <div class="col-6 offset-3">
                                <div class="form-group">
                                    <label for="medicament">Médicament</label>
                                    <select class="form-select" id="medicament" name="id_medicament">
                                        <option value="">Veuillez choisir un Médicament</option>
                                        <% 
                                        if (medicaments != null) {
                                            for (Medicament medicament : medicaments) { 
                                        %>
                                        <option value="<%= medicament.getIdMedicament() %>">
                                            <%= medicament.getNom() %>
                                        </option>
                                        <% } } %>
                                    </select>
                                </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-6 offset-3 mt-3">
                                <div class="form-group">
                                    <label for="unite">Unité</label>
                                    <select class="form-select" id="unite" name="unite">
                                        <option value="">Veuillez choisir une Unité</option>
                                        <% 
                                        if (unites != null) {
                                            for (Unite unite : unites) { 
                                        %>
                                        <option value="<%= unite.getIdUnite() %>">
                                            <%= unite.getNom() %>
                                        </option>
                                        <% } } %>
                                    </select>
                                </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-6 offset-3">
                              <div class="form-group">
                                <label for="nom">Prix Boite </label>
                                <input
                                  type="number"
                                  class="form-control"
                                  name="prix_vente"
                                  required
                                />
                              </div>
                            </div>
                          </div>
                    </div>
                  </div>
                </div>
                <div class="card-action" style="background-color: #1b1d38;">
                  <button class="btn btn-success" type="submit">Valider</button>
                </div>
              </div>
              </form>
              
              <!--fin formulaire-->

            </div>
          </div>
        </div>
      </div>
      <!-- fin container -->

<%@ include file="../elements/footer.jsp" %>