<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.maladie.Maladie"%>
<%@page import="model.Symptome"%>

<% 
  Maladie maladie = (Maladie) request.getAttribute("maladie"); 
  Symptome[] symptomes = (Symptome[]) request.getAttribute("symptomes");
%>

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
            <h3 class="fw-bold mb-3">Maladies</h3>
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
                <a href="#">Symptomes</a>
              </li>
            </ul>
          </div>
            <!--bouton retour-->
            <div class="row">
                <div class="col-3">
                    <a href="<%= request.getContextPath() %>/pages/maladies/symptome_traitement_liste.jsp">
                        <button type="button" class="btn btn-outline-primary">
                            <i class="fas fa-arrow-left" style="font-size: 1.5em;"></i> Retour
                        </button>
                    </a>
                </div>
              </div>
              <!--bouton retour-->
          <div class="row">
            <div class="offset-2 col-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title"><h2 class="text-center" style="color: white;">ajout de symptomes</h2></div>
                </div>
                <!--Debut formulaire-->
                <form action="<%= request.getContextPath() %>/maladies/symptome_traitement_liste" method="post">
                <div class="card-body">
                  <div class="row">
                    <div class="offset-1 col-10">

                        <div class="row">
                            <div class="col-10 offset-1">
                              <div class="form-group">
                                <label for="nom">Maladie</label>
                                <input type="text" class="form-control" value="<%= maladie.getNom() %>" readonly/>
                                <input type="hidden"  value="<%= maladie.getIdMaladie() %>" name="idMaladie"/>
                                <input type="hidden"  value="symptome" name="action"/>
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-10 offset-1">
                                <div class="form-group">
                                    <label for="">Symptomes</label>
                                    <select id="symptomes" name="symptomes[]" multiple placeholder="Select items...">
                                        <% for(int i = 0; i < symptomes.length; i++) { %>
                                            <option value="<%= symptomes[i].getIdSymptome() %>"><%= symptomes[i].getNom() %></option>
                                        <% } %>
                                    </select>
                                  </div>
                            </div>
                          </div>
                    </div>
                  </div>
                </div>
                <div class="card-action">
                  <button class="btn btn-success">Valider</button>
                </div>
              </form>
               <!--fin formulaire-->
              </div>
            </div>
          </div>
        </div>
      </div>

      <script>
        // Initialiser TomSelect avec plusieurs options
        new TomSelect('#symptomes', {
          placeholder: 'Selection multipe symptôme',
          plugins: ['remove_button'],   // Ajouter le bouton pour supprimer les tags
          maxItems: null,                  // Limiter la sélection à 3 éléments maximum
          create: false,                // Désactiver la création d'éléments personnalisés
          searchField: 'text',          // Rechercher dans le texte des options
        });
      </script>
<%@ include file="../elements/footer.jsp" %>