<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.MedicamentLaboratoire"%>
<% 
   MedicamentLaboratoire[] medicament_laboratoires = (MedicamentLaboratoire[]) request.getAttribute("medicament_laboratoires");
   String id_medicament = (String) request.getAttribute("id_medicament");
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
                <a href="#">Fournisseur</a>
              </li>
            </ul>
          </div>
       
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" >
                    <a href="<%= request.getContextPath() %>/medicament/list">
                      <button type="button" class="btn btn-outline-primary">
                          <i class="fas fa-arrow-left" style="font-size: 1.5em;"></i> Retour
                      </button>
                    </a>
                    <h2 class="text-center" style="color: white;">Liste proposition Fournisseur </h2>
                  </div>
                </div>
                <div class="card-body">
                    <div class="card-sub">
                        <div class="row mb-3">
                            <!--zone de recherche-->
                            <div class="col">
                                <form method="GET" action="/your-filter-endpoint" class="row g-3">
                                    <div class="col-3">
                                        <input type="number" class="form-control" name="prix_achat_min" placeholder="prix achat minimum" min="0">
                                    </div>
                                    <div class="col-3">
                                      <input type="number" class="form-control" name="prix_achat_max" placeholder="prix achat maximum" min="0">
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-success">Valider</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                  <table class="table table-bordered table-head-bg-success  mt-3">
                    <thead>
                      <tr>
                        <th class="text-center" scope="col">Laboratoire</th>
                        <th class="text-center" scope="col">Unité</th>
                        <th class="text-center" scope="col">Prix achat</th>
                        <th class="text-center" scope="col">Minimum Achat</th>
                        <th class="text-center" scope="col">action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <% if (medicament_laboratoires != null && medicament_laboratoires.length > 0) { 
                          for (int i = 0; i < medicament_laboratoires.length; i++) { 
                              MedicamentLaboratoire medLab = medicament_laboratoires[i];
                      %>
                      <tr>
                          <td class="text-center"><%= medLab.getLaboratoire().getNom() %></td>
                          <td class="text-center"><%= medLab.getUnite().getNom() %></td>
                          <td class="text-center"><span class="fw-bold"><%= medLab.getPrixAchat() %> Ar</span></td>
                          <td class="text-center"><%= medLab.getMinimumAchat() %></td>
                          <td class="text-center">
                            <a href="<%= request.getContextPath() %>/pages/achats/insertion.jsp">
                            <button type="button" class="btn btn-primary btn-sm">
                                <i class="fas fa-shopping-cart"></i> passez commande
                            </button>
                            </a>
                          </td>
                      </tr>
                      <%  } // Fin du for 
                        } else { %>
                      <tr>
                          <td class="text-center" colspan="5">Aucun Laboratoire trouvé pour ce Medicament</td>
                      </tr>
                      <% } // Fin du if %>
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