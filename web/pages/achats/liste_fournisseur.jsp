<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
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
            <h3 class="fw-bold mb-3">Approvisionnement</h3>
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
                <a href="#">Liste fournisseur</a>
              </li>
            </ul>
          </div>
          <!--bouton retour-->
          <div class="row">
            <div class="col-6 offset-3">
                <h2 class="text-center">Veuillez choisir un Laboratoire fournisseur</h2>
            </div>
          </div>
          <!--bouton retour-->
          <div class="row mb-3">
            <div class="col-6 offset-3">
                <ul class="list-group">
                    <li class="list-group-item bg-transparent d-flex justify-content-center align-items-center gap-3" >
                      <a href="<%= request.getContextPath() %>/pages/achats/insertion.jsp">Lab 1</a> 
                    </li>
                    <li class="list-group-item bg-transparent d-flex justify-content-center align-items-center gap-3"><a href="">Lab 2</a>  </li>
                    <li class="list-group-item bg-transparent d-flex justify-content-center align-items-center gap-3"><a href="">Lab 3</a> </li>
                  </ul>
            </div>
          </div>
      </div>
<%@ include file="../elements/footer.jsp" %>