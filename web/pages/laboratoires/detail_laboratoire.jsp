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
            <h3 class="fw-bold mb-3">Laboratoire</h3>
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
                <a href="#">Detail</a>
              </li>
            </ul>
          </div>
          <!--bouton retour-->
          <div class="row">
            <div class="col-3">
                <a href="<%= request.getContextPath() %>/pages/laboratoires/liste.jsp">
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
                    <li class="list-group-item">Laboratoire : </li>
                    <li class="list-group-item">Contact : </li>
                    <li class="list-group-item">Adresse : </li>
                  </ul>
            </div>
          </div>

          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Liste medicament proposé </h2></div>
                </div>
                <div class="card-body">
                    <div class="card-sub">
                        <div class="row mb-3">
                            <!--zone de recherche-->
                            <div class="col">
                                <form method="GET" action="/your-filter-endpoint" class="row g-3">
                                    <div class="col-3">
                                        <input type="text" class="form-control" name="maladie" placeholder="Filtrer par maladie">
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-success">Valider</button>
                                    </div>
                                </form>
                            </div>
                            <!-- fin zone de recherche-->
                            <div class="col-auto">
                                <a href="<%= request.getContextPath() %>/pages/laboratoires/ajout_medicament.jsp" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Ajouter un médicament
                                </a>
                            </div>
                        </div>
                  <table class="table table-bordered table-head-bg-success  mt-3">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">medicament</th>
                        <th scope="col">description</th>
                        <th scope="col">quantité par boite</th>
                        <th scope="col">Prix Achat Boite</th>
                        <th scope="col">action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td class="text-center">1</td>
                        <td class="text-center">Paracetamol</td>
                        <td class="text-center">medicament ----</td>
                        <td class="text-center"> 3 plaquette </td>

                        <td class="text-center">
                            <span class="fw-bold">750,000 Ar</span>
                            <a href="<%= request.getContextPath() %>/pages/laboratoires/update_prix.jsp" class="btn btn-warning btn-sm ms-3 d-inline-flex align-items-center">
                                <i class="fas fa-edit me-2"></i> Modifier
                            </a>
                        </td>
                        
                     
                        <td>
                            <a href="<%= request.getContextPath() %>/pages/achats/insertion.jsp">
                            <button type="button" class="btn btn-primary btn-sm">
                                <i class="fas fa-shopping-cart"></i> passez commande
                            </button>
                            </a>
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
                        </td>
                      </tr>
                    </tbody>
                  </table>

                    <!-- Pagination -->
        <nav>
            <ul class="pagination justify-content-center">
              <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1">Previous</a>
              </li>
              <li class="page-item active">
                <a class="page-link" href="#">1</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">2</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">3</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">Next</a>
              </li>
            </ul>
          </nav>
                </div>
              </div>
            
              
            </div>
            
          </div>

         



        </div>

       









      </div>
<%@ include file="../elements/footer.jsp" %>