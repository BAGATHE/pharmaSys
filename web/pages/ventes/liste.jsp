<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@ page import="model.vente.Vente" %>
<%@page import="model.categorie.Categorie"%>
<%@page import="model.medicament.TypeMedicament"%>
<%
TypeMedicament[] type_medicaments = (TypeMedicament[]) request.getAttribute("types");
Categorie[] categories = (Categorie[]) request.getAttribute("categorie");
Vente[] ventes = (Vente[]) request.getAttribute("ventes");
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
                <a href="#">Historique</a>
              </li>
            </ul>
          </div>
          



        </div>

        <div class="row">
            <div class="offset-1 col-10">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">historique Vente </h2></div>
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
                        <div class="col-3">
                              <div class="form-group">
                                <label for="nom">Type</label>
                                <select name="type" id="categorie" class="form-select">
                                    <option value="">-- Toutes les Type  --</option>
                                    <%
                                        if (type_medicaments != null) {
                                            for (TypeMedicament typeMedicament : type_medicaments) {
                                    %>
                                        <option value="<%= typeMedicament.getIdType()%>"><%= typeMedicament.getTypeMedicament()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                              </div>
                         
                        </div>
                        <div class="col-3">
                          <label for="nom">Categorie</label>
                          <select name="categorie" id="categorie" class="form-select">
                              <option value="">-- Toutes les catégories --</option>
                              <%
                                  if (categories != null) {
                                      for (Categorie cat : categories) {
                              %>
                                          <option value="<%= cat.getIdCategorie() %>"><%= cat.getCategorie() %></option>
                              <%
                                      }
                                  }
                              %>
                          </select>
                      </div>
                      <div class="col-md-2">
                        <button type="submit" class="btn btn-success">Valider</button>
                    </div>
                      </form>
                  </div>
                  <table class="table table-hover mt-3">
                    <thead>
                        <tr>
                            <th scope="col">Date</th>
                            <th scope="col">Total</th>
                            <th scope="col">Détail</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (ventes != null && ventes.length > 0) { 
                            for (Vente vente : ventes) { %>
                                <tr>
                                    <td><%= vente.getDateVente() %></td>
                                    <td><span class="fw-bold"><%= String.format("%,.2f", vente.getTotal()) %> Ar</span></td>
                                    <td>
                                        <a href="<%= request.getContextPath() %>/vente/detail?id_vente=<%= vente.getIdVente() %>" class="btn btn-primary btn-sm">
                                            Voir détail
                                        </a>
                                    </td>
                                </tr>
                            <% }
                        } else { %>
                            <tr>
                                <td colspan="4" class="text-center">Aucun vente trouvé</td>
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