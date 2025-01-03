<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.configuration.Unite"%>

<%
    Unite unite = (Unite) request.getAttribute("unite");
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
                <a href="#">Formulaire Mise a jour</a>
              </li>
            </ul>
          </div>
          <div class="row">
            <div class="offset-md-2 col-md-8">
                <!--debut formulaire-->
              <form method="post" action="" accept-charset="UTF-8">
                <input type="hidden" name="id_unite" value="<%=unite.getIdUnite() %>" />
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <a href="<%= request.getContextPath() %>/unite/list"><button type="button" class="btn btn-info">retour</button></a>
                  <div class="card-title"><h2 class="text-center" style="color: white;">Mise a jour Unité</h2></div>
                </div>
                <div class="card-body">
                  <div class="row">
                    <div class="offset-md-3 col-md-6 offset-lg-2 col-lg-8">

                        <div class="row">
                            <div class="col-6 offset-3">
                              <div class="form-group">
                                <label for="nom">unité </label>
                                <input
                                  type="text"
                                  class="form-control"
                                  id="nom"
                                  name="nom"
                                  required
                                  value="<%=unite.getNom() %>"
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