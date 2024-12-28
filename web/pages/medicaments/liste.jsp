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
                <a href="#">Liste</a>
              </li>
            </ul>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Liste Médicament </h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                    <form method="GET" action="/your-filter-endpoint" class="row g-3">
                        <div class="col-3">
                          <input type="text" class="form-control" name="medicament" placeholder="Filtrer par nom">
                        </div>
                        <div class="col-3">
                          <input type="number" class="form-control" name="prix_vente_min" placeholder="prix minimum"  >
                        </div>
                        <div class="col-3">
                         <input type="number" class="form-control" name="prix_vente_max" placeholder="prix maximum"  >
                        </div>
                        <div class="col-md-2">
                          <button type="submit" class="btn btn-success">Valider</button>
                        </div>
                      </form>
                  </div>
                  <table class="table table-bordered table-head-bg-success  mt-3">
                    <thead>
                      <tr>
                        <th class="text-center" scope="col">#</th>
                        <th class="text-center" scope="col">médicament</th>
                        <th class="text-center" scope="col">déscription</th>
                        <th class="text-center" scope="col">Prix vente</th>
                        <th class="text-center" scope="col">Laboratoire Fournisseur</th>
                        <th class="text-center" scope="col">action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td class="text-center">1</td>
                        <td class="text-center">Paracetamol</td>
                        <td class="text-center">xxxx</td>
                        <td class="text-center">
                          <table class="">
                              <tr>
                                <th class="text-center" scope="col">boite plaquette :</th>
                                <th class="text-center" scope="col"><span class="fw-bold"> 50,000 Ar</span></th>
                              </tr>
                              <tr>
                                <th class="text-center" scope="col">plaquette :</th>
                                <th class="text-center" scope="col"><span class="fw-bold"> 8,000 Ar</span></th>
                              </tr>
                            </table>
                        </td>
                        <td class="text-center">
                            <a href="<%= request.getContextPath() %>/pages/medicaments/liste_fournisseur_medicament.jsp"> 
                                <button type="button" class="btn btn-info btn-sm">
                                    <i class="fas fa-eye"></i> Consulter
                                </button>
                            </a>
                        </td>
                        <td class="text-center">
                            <a href="<%= request.getContextPath() %>/pages/medicaments/update.jsp">
                            <button type="button" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> Modifier
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