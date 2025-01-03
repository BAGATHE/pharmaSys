<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.medicament.MedicamentLaboratoire"%>
<% 
   MedicamentLaboratoire[] medicament_laboratoires = (MedicamentLaboratoire[]) request.getAttribute("medicament_laboratoires");
   String id_laboratoire = (String) request.getAttribute("id_laboratoire");
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
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <a href="<%= request.getContextPath() %>/laboratoire/list">
                    <button type="button" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left" style="font-size: 1.5em;"></i> Retour
                    </button>
                </a>
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
                                <a href="<%= request.getContextPath() %>/laboratoire-medicament/insert?id_laboratoire=<%= id_laboratoire %>" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Ajouter un médicament
                                </a>
                                <a href="<%= request.getContextPath() %>/achat/laboratoire/insert?id_laboratoire=<%=id_laboratoire%>" class="btn btn-primary">
                                  <i class="fas fa-shopping-cart"></i> Passez commande
                              </a>
                            </div>
                        </div>
                        <table class="table table-bordered table-head-bg-success mt-3">
                          <thead>
                              <tr>
                                  <th class="text-center" scope="col">Médicament</th>
                                  <th class="text-center" scope="col">Unité</th>
                                  <th class="text-center" scope="col">Prix Achat</th>
                                  <th class="text-center" scope="col">Minimum Achat</th>
                                  <th class="text-center" scope="col">Action</th>
                              </tr>
                          </thead>
                          <tbody>
                              <% if (medicament_laboratoires != null && medicament_laboratoires.length > 0) { 
                                  for (int i = 0; i < medicament_laboratoires.length; i++) { 
                                      MedicamentLaboratoire medLab = medicament_laboratoires[i];
                              %>
                              <tr>
                                  <td class="text-center"><%= medLab.getMedicament().getNom() %></td>
                                  <td class="text-center"><%= medLab.getUnite().getNom() %></td>
                                  <td class="text-center"><span class="fw-bold"><%=String.format("%,.2f", medLab.getPrixAchat()) %> Ar</span></td>
                                  <td class="text-center"><%= medLab.getMinimumAchat() %></td>
                                  <td class="text-center">
                                      <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal<%= i %>">
                                          <i class="fas fa-trash-alt"></i> Supprimer
                                      </button>
                      
                                      <!-- Modal de confirmation -->
                                      <div class="modal fade" id="deleteModal<%= i %>" tabindex="-1" aria-labelledby="deleteModalLabel<%= i %>" aria-hidden="true">
                                          <div class="modal-dialog">
                                              <div class="modal-content">
                                                  <div class="modal-header">
                                                      <h5 class="modal-title" id="deleteModalLabel<%= i %>">Confirmer la suppression</h5>
                                                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                  </div>
                                                  <div class="modal-body">
                                                      Voulez-vous vraiment supprimer le médicament "<%= medLab.getMedicament().getNom() %>" ?
                                                      Cette action est irréversible.
                                                  </div>
                                                  <div class="modal-footer">
                                                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                      <a href="<%= request.getContextPath() %>/laboratoire-medicament/delete?id_medicament=<%= medLab.getMedicament().getIdMedicament() %>&id_unite=<%= medLab.getUnite().getIdUnite() %>&id_laboratoire=<%=id_laboratoire%>">
                                                          <button type="button" class="btn btn-danger">Supprimer</button>
                                                      </a>
                                                  </div>
                                              </div>
                                          </div>
                                      </div>
                                  </td>
                              </tr>
                              <%  } // Fin du for 
                                } else { %>
                              <tr>
                                  <td class="text-center" colspan="5">Aucun médicament trouvé pour ce laboratoire.</td>
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