<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
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
                <a href="#">Formulaire mise a jour prix medicament</a>
              </li>
            </ul>
          </div>
           <!--bouton retour-->
           <div class="row">
            <div class="col-3">
                <a href="<%= request.getContextPath() %>/pages/laboratoires/detail_laboratoire.jsp">
                    <button type="button" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left" style="font-size: 1.5em;"></i> Retour
                    </button>
                </a>
            </div>
          </div>
          <!--bouton retour-->
          <div class="row">
            <div class="offset-2 col-8">
                <!--debut formulaire-->
              <form action="" method="post">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title"><h2 class="text-center" style="color: white;">mise a jour prix Médicament Laboratoire</h2></div>
                </div>
                <div class="card-body">
                  <div class="row">
                    <div class="offset-1 col-10">

                        <div class="row">
                            <div class="col-10 offset-1">
                                <div class="form-group">
                                    <label for="medicament">médicament</label>
                                    <input class="form-control" name="medicament" value="test" readonly >
                                  </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-10 offset-1">
                              <div class="form-group">
                                <label for="prixAchat">Prix Boite</label>
                                <input
                                  type="number"
                                  class="form-control"
                                  min="0"
                                  required
                                />
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="col-10 offset-1">
                              <div class="form-group">
                                <label for="minimuAchat">Minimum ahat</label>
                                <input
                                  type="number"
                                  class="form-control"
                                  min="0"
                                  required
                                />
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