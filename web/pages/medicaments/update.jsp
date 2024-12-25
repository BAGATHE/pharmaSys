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
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                    <a href="<%= request.getContextPath() %>/pages/medicaments/liste.jsp"><button type="button"  class="btn btn-info">retour</button></a>
                  <div class="card-title"><h2 class="text-center" style="color: white;">mise a jour information  Médicament</h2></div>
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
                                  class="form-control"
                                  placeholder="nom"
                                  required
                                />
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-10 offset-1">
                                <div class="form-group">
                                    <label for="description">Desription</label>
                                    <textarea class="form-control"  rows="5">
                                    </textarea>
                                </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-10 offset-1">
                              <div class="form-group">
                                <label for="qtt">quantité par boite</label>
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
                                <label for="vente">Prix vente Boite</label>
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
                                <label for="seuil">seuil minimum en stock</label>
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