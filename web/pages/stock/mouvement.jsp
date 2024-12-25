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
           
            <li class="nav-item topbar-user dropdown hidden-caret">
              <a
                class="dropdown-toggle profile-pic"
                data-bs-toggle="dropdown"
                href="#"
                aria-expanded="false"
              >
                <div class="avatar-sm">
                  <img
                    src="<%= request.getContextPath() %>assets/img/profile.jpg"
                    alt="..."
                    class="avatar-img rounded-circle"
                  />
                </div>
                <span class="profile-username">
                  <span class="op-7" style="color: white;">Hi,</span>
                  <span class="fw-bold" style="color: white;">Hizrian</span>
                </span>
              </a>
              
            </li>
          </ul>
        </div>
      </nav>
      <!-- End Navbar -->
    </div>

    <div class="container">
        <div class="page-inner">
          <div class="page-header">
            <h3 class="fw-bold mb-3">Stock</h3>
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
                <a href="#">Mouvement</a>
              </li>
            </ul>
          </div>
          



        </div>

        <div class="row">
            <div class="offset-md-2 col-md-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                    <a href="<%= request.getContextPath() %>/pages/stock/etat_stock.jsp"><button type="submit" class="btn btn-info">retour</button></a>
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Mouvement Stock </h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                    <form method="GET" action="/your-filter-endpoint" class="row g-3">
                        <div class="col-md-5">
                          <input type="text" class="form-control" name="filterFirst" placeholder="Filter by First Name">
                        </div>
                        <div class="col-md-5">
                          <input type="text" class="form-control" name="filterLast" placeholder="Filter by Last Name">
                        </div>
                        <div class="col-md-2">
                          <button type="submit" class="btn btn-success">Valider</button>
                        </div>
                      </form>
                  </div>
                  <table class="table table-hover mt-3">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th class="text-center" scope="col">Médicament</th>
                        <th class="text-center" scope="col">entrée</th>
                        <th class="text-center" scope="col">Sortie</th>
                        <th class="text-center" scope="col">prix unitaire boite</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td></td>
                        <td class="text-center">Paracetamol</td>
                        <td class="text-center">10</td>
                        <td class="text-center">0</td>
                        <td class="text-center">7000</td>
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
<%@ include file="../elements/footer.jsp" %>