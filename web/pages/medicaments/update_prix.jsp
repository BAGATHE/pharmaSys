<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.medicament.PrixMedicament" %>
<%
    PrixMedicament prix_medicament = (PrixMedicament)request.getAttribute("prix_medicament");
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
                <a href="#">Formulaire mise a jour</a>
              </li>
            </ul>
          </div>
          <div class="row">
            <div class="offset-2 col-8">
              <!--debut form-->
              <form action="" method="post">
                <input type="hidden" name="id_prix_medicament" value="<%=prix_medicament.getIdPrixMedicament() %>" />
                <input type="hidden" name="id_unite" value="<%=prix_medicament.getUnite().getIdUnite() %>" />
                <input type="hidden" name="id_medicament" value="<%=prix_medicament.getMedicament().getIdMedicament() %>" />
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                    <a href="<%= request.getContextPath() %>/medicament/prix?id_medicament=<%=prix_medicament.getMedicament().getIdMedicament()  %>"><button type="button"  class="btn btn-info">retour</button></a>
                  <div class="card-title"><h2 class="text-center" style="color: white;">mise a jour Prix</h2></div>
                </div>
                <div class="card-body">
                  <div class="row">
                    <div class="offset-1 col-10">

                        <div class="row">
                            <div class="col-10 offset-1">
                              <div class="form-group">
                                <label for="nom">Unite</label>
                                <input readonly type="text" class="form-control"value="<%=prix_medicament.getUnite().getNom() %>"/>
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-10 offset-1">
                                <div class="form-group">
                                    <label for="nom">Prix De Vente</label>
                                    <input type="Number" name="prix_vente" class="form-control"value="<%=prix_medicament.getPrixVenteUnitaire() %>"/>
                                  </div>
                            </div>
                          </div>         
                    </div>
                  </div>
                </div>
                <div class="card-action">
                  <button class="btn btn-success">Valider</button>
                </div>
              </div>
            </form>
            <!--Fin formulaire-->
            </div>
          </div>
        </div>

       


      </div>

     
<%@ include file="../elements/footer.jsp" %>