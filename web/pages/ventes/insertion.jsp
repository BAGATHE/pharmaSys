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
            <h3 class="fw-bold mb-3">Vente</h3>
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
                <a href="#">Insertion</a>
              </li>
            </ul>
          </div>
        
                
          
          <!--bouton retour-->
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;"> Vente Medicament </h2></div>
                </div>
                <div class="card-body">
                    <div class="card-sub">
                        <div class="row">
                            <table class="table table-bordered table-head-bg-success  mt-3">
                                <thead>
                                  <tr>
                                    <th class="text-center" scope="col">#</th>
                                    <th class="text-center" scope="col">medicament</th>
                                    <th class="text-center" scope="col">quantité par boite</th>
                                    <th class="text-center" scope="col">Prix de vente Boite</th>
                                    <th class="text-center" scope="col">Prix de vente a l'unité</th>
                                    <th class="text-center" scope="col">quantité</th>
                                    <th class="text-center" scope="col">unité</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <tr>
                                    <td class="text-center">1</td>
                                    <td class="text-center">Paracetamol</td>
                                    <td class="text-center"> 3 plaquette </td>
                                    <td class="text-center">
                                        <span class="fw-bold">750,000 Ar</span>
                                    </td>
                                    <td class="text-center">
                                        <span class="fw-bold">50,000 Ar</span>
                                    </td>
                                    <td class="text-center">
                                        <input type="number" class="form-control" min="0" value="0"/>
                                    </td>
                                    <td class="text-center">
                                        <select class="form-select form-control-sm">
                                            <option>1</option>
                                            <option>2</option>
                                        </select>
                                    </td>           
                                  </tr>
                                </tbody>
                              </table>
                        </div>
                </div>
              </div>
              <div class="card-action">
                <button class="btn btn-success">Valider</button>
              </div>
            
              
            </div>
            
          </div>

         



        </div>

       









      </div>
<%@ include file="../elements/footer.jsp" %>