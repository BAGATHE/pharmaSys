<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@ page import="model.Vendeur" %>
<%@ page import="model.vente.Vente" %>

<%
Vendeur[] vendeurs = (Vendeur[]) request.getAttribute("vendeurs");
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
            <h3 class="fw-bold mb-3">Vendeur</h3>
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
                <a href="#">commission</a>
              </li>
            </ul>
          </div>
          



        </div>

        <div class="row">
            <div class="offset-1 col-10">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">historique </h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                    <form  method="POST" action=""class="row g-3">
                      <div class="col-3">
                        <div class="form-group">
                          <label for="nom">date min </label>
                          <input
                            type="date"
                            class="form-control"
                            name="date_debut"
                          />
                        </div>
                      </div>
                      <div class="col-3">
                        <div class="form-group">
                          <label for="nom">date max</label>
                          <input
                            type="date"
                            class="form-control"
                            name="date_fin"
                          />
                        </div>
                      </div>
                      <div class="col-md-2">
                        <button type="submit" class="btn btn-success">Valider</button>
                    </div>
                      </form>
                  </div>
                  <table class="table table-hover mt-3">
                    <thead>
                        <tr>
                            <th scope="col">Nom Vendeur</th>
                            <th scope="col">Total Commission</th>
                            <th scope="col">Détail</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (vendeurs != null && vendeurs.length > 0) { 
                            for (int i = 0; i < vendeurs.length; i++) {
                                Vendeur vendeur = vendeurs[i];
                        %>
                        <tr>
                            <td><%= vendeur.getNomComplet() %></td>
                            <td><span class="fw-bold"><%= String.format("%,.2f", vendeur.getTotalCommission()) %> Ar</span></td>
                            <td>
                    
                                  <!-- Bouton pour afficher le modal -->
                                  <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalPrix_<%=i %>">
                                    Voir
                                </button>
                
                                <!-- Modal inclus dans le <td> -->
                                <div class="modal fade" id="#modalPrix_<%=i %>" tabindex="-1" role="dialog" aria-labelledby="modalLabel<%= i %>" aria-hidden="true">
                                    <div class="modal-dialog modal-lg" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="modalLabel<%= i %>">Détails des ventes de <%= vendeur.getNomComplet() %></h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <% 
                                                Vente[] ventes = vendeur.getVentes();
                                                if (ventes != null && ventes.length > 0) {
                                                %>
                                                <table class="table table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <th>ID Vente</th>
                                                            <th>Date Vente</th>
                                                            <th>Client</th>
                                                            <th>total vente</th>
                                                            <th>Commission</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for (Vente vente : ventes) { %>
                                                        <tr>
                                                            <td><%= vente.getIdVente() %></td>
                                                            <td><%= vente.getDateVente() %></td>
                                                            <td><%= vente.getClient().getNom() %></td>
                                                            <td><%= String.format("%,.2f", vente.getTotal()) %> Ar</td>
                                                            <td><%= String.format("%,.2f", vente.getCommissionVendeur()) %> Ar</td>
                                                        </tr>
                                                        <% } %>
                                                    </tbody>
                                                </table>
                                                <% } else { %>
                                                <p>Aucune vente trouvée pour ce vendeur.</p>
                                                <% } %>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <% 
                            }
                        } else { 
                        %>
                        <tr>
                            <td colspan="3" class="text-center">Aucun vendeur trouvé</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                </div>
              </div>
            
              
            </div>
            
          </div>










      </div>
<%@ include file="../elements/footer.jsp" %>