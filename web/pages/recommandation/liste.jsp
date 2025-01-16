<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.recommandation.Recommandation" %>
<%@page import="model.medicament.Medicament"%>
<%
    Medicament[] medicaments = (Medicament[]) request.getAttribute("medicaments");
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
            <h3 class="fw-bold mb-3"> Recommandation</h3>
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
            <div class="offset-md-2 col-md-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Liste Recommandation </h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                    <form method="post" action="" class="row g-3">
                      <div class="col-3">
                        <div class="form-group">
                          <label for="nom">date </label>
                          <input
                            type="date"
                            class="form-control"
                            name="date"
                          />
                        </div>
                      </div>
                      <div class="col-3">
                        <div class="form-group">
                          <label for="medicament">Médicament</label>
                          <select class="form-select" id="medicament" name="medicament">
                              <option value="">Veuillez choisir un Médicament</option>
                              <% 
                              if (medicaments != null) {
                                  for (Medicament medicament : medicaments) { 
                              %>
                              <option value="<%= medicament.getIdMedicament() %>">
                                  <%= medicament.getNom() %>
                              </option>
                              <% } } %>
                          </select>
                      </div>

                      </div>
                      <div class="col-md-2">
                          <button type="submit" class="btn btn-success">Valider</button>
                      </div>
                  </form>
                  
                  </div>
                  <table class="table table-bordered table-head-bg-success  mt-3">
                    <tr>
                      <th>medicament</th>
                      <th>date debut</th>
                      <th>date fin</th>
                    </tr>
                                    <% 
                            // Récupérer la liste des recommandations depuis l'attribut de requête
                            Recommandation[] recommandations = (Recommandation[]) request.getAttribute("recommandations");
                            if (recommandations != null && recommandations.length>0) {
                                for (Recommandation recommandation : recommandations) {
                        %>
                      
                        <tr>
                            <td class="text-center"><%= recommandation.getMedicament().getNom() %></td>
                            
                            <!-- Afficher la date de début -->
                            <td class="text-center">
                                <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(recommandation.getDateDebut()) %>
                            </td>
                            
                            <!-- Afficher la date de fin -->
                            <td class="text-center">
                                <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(recommandation.getDateFin()) %>
                            </td>
                        </tr>
                        <% 
                                }
                            } else { 
                        %>
                        <tr>
                            <td class="text-center" colspan="3">Aucune recommandation trouvée.</td>
                        </tr>
                        <% 
                            } 
                        %>
                  </table>

                </div>
              </div>
            
              
            </div>
            
          </div>

         



        </div>

       









      </div>
<%@ include file="../elements/footer.jsp" %>