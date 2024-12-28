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
                <a href="#">Symtomes et traitements</a>
              </li>
            </ul>
          </div>
          <!--bouton retour-->
          <div class="row mb-3">
            <div class="col-3">
                <a href="<%= request.getContextPath() %>/pages/maladies/liste.jsp">
                    <button type="button" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left" style="font-size: 1.5em;"></i> Retour
                    </button>
                </a>
            </div>
          </div>
          <!--bouton retour-->
          <div class="row mb-3">
            <div class="col-6 offset-3">
                <ul class="list-group">
                    <li class="list-group-item">Maladie : </li>
                    <li class="list-group-item">description : </li>
                  </ul>
            </div>
          </div>
          <div class="row">
            <div class="col-4">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Symptomes </h2></div>
                </div>
                <div class="card-body">
                    <ul class="list-group">
                      <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span>Douleur intense</span>
                        <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal1">
                          <i class="fas fa-trash-alt"></i> Supprimer
                        </button>
                        <div class="modal fade" id="deleteModal1" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="deleteModalLabel">Confirmer la suppression</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                              </div>
                              <div class="modal-body">
                                cette action est irreversible.
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                <a href=""><button type="button" class="btn btn-danger">Supprimer</button></a>
                              </div>
                            </div>
                          </div>
                      </div>
                      </li>
                      </ul>
                </div>
                <div class="card-action">
                  <a href="<%= request.getContextPath() %>/pages/maladies/ajout_symptome.jsp">
                    <button type="button" class="btn btn-outline-primary">
                         Ajouter
                    </button>
                  </a>
                </div>
              </div>
            </div>
            
            <div class="col-8">
                <div class="card">
                  <div class="card-header" style="background-color: #1b1d38;">
                    <div class="card-title" ><h2 class="text-center" style="color: white;">Traitements </h2></div>
                  </div>
                  <div class="card-body">
                    <table class="table table-bordered table-head-bg-success  mt-3">
                        <thead>
                          <tr>
                            <th scope="col">Médicament</th>
                            <th scope="col">Efficacité</th>
                            <th scope="col">Action</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>Paracétamol</td>
                            <td>80%</td>
                            <td>
                              <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal2">
                                <i class="fas fa-trash-alt"></i> Supprimer
                            </button>
                            <div class="modal fade" id="deleteModal2" tabindex="-1" aria-labelledby="deleteModalLabel-2" aria-hidden="true">
                                <div class="modal-dialog">
                                  <div class="modal-content">
                                    <div class="modal-header">
                                      <h5 class="modal-title" id="deleteModalLabel-2">Confirmer la suppression</h5>
                                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                      cette action est irreversible.
                                    </div>
                                    <div class="modal-footer">
                                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                      <a href=""><button type="button" class="btn btn-danger">Supprimer</button></a>
                                    </div>
                                  </div>
                                </div>
                            </div>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                  </div>
                  <div class="card-action">
                    <a href="<%= request.getContextPath() %>/pages/maladies/ajout_traitement.jsp">
                      <button type="button" class="btn btn-outline-primary">
                           Ajouter
                      </button>
                    </a>
                </div>
                </div>
              </div>
            
          </div>

         



        </div>

       









      </div>
<%@ include file="../elements/footer.jsp" %>