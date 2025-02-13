<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.medicament.Laboratoire" %>
<%
Laboratoire laboratoire = (Laboratoire) request.getAttribute("laboratoire");
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
            <h3 class="fw-bold mb-3">Laboratoires</h3>
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
            <div class="offset-2 col-8">
              <!--debut formulaire-->
              <form action="" method="post">
                <input type="hidden" name="id_laboratoire" value="<%= laboratoire.getIdLaboratoire() %>">
                <div class="card">
                    <div class="card-header" style="background-color: #1b1d38;">
                        <a href="<%= request.getContextPath() %>/laboratoire/list"><button type="button" class="btn btn-info">retour</button></a>
                        <div class="card-title"><h2 class="text-center" style="color: white;">Mise a jour Laboratoire</h2></div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="offset-1 col-10">
                                <div class="row">
                                    <div class="col-10 offset-1">
                                        <div class="form-group">
                                            <label for="nom">Nom</label>
                                            <input
                                                type="text"
                                                name="nom"
                                                class="form-control"
                                                placeholder="Entrer Laboratoire"
                                                value="<%= laboratoire.getNom() %>"
                                                required
                                            />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-10 offset-1">
                                        <div class="form-group">
                                            <label for="contact">contact email</label>
                                            <input
                                                type="email"
                                                name="contact"
                                                class="form-control"
                                                placeholder="exemple@gmail.com"
                                                value="<%= laboratoire.getContact() %>"
                                                required
                                            />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-10 offset-1">
                                        <div class="form-group">
                                            <label for="adresse">Adresse</label>
                                            <textarea 
                                                name="adresse" 
                                                class="form-control" 
                                                rows="5"
                                            ><%= laboratoire.getAdresse() %></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-action">
                        <button type="submit" class="btn btn-success">Valider</button>
                    </div>
                </div>
            </form>
              <!--fin formulaire-->
            </div>
          </div>
        </div>

       


      </div>

     
<%@ include file="../elements/footer.jsp" %>