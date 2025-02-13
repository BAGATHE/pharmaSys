<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.stock.MouvementStock"%>
<%
MouvementStock[] mouvements = (MouvementStock[]) request.getAttribute("mouvements");
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
                        <th scope="col">Reference</th>
                        <th class="text-center" scope="col">Date</th>
                        <th class="text-center" scope="col">Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td></td>
                        <td class="text-center"></td>
                        <td class="text-center"></td>
                      </tr>
                      <tbody>
                        <% 
                          if (mouvements != null && mouvements.length > 0) {
                            for (int i = 0; i < mouvements.length; i++) {
                              MouvementStock mvt = mouvements[i];
                        %>
                        <tr>
                          <td class="text-center"><%= mvt.getIdMouvementStock() %></td> 
                          <td class="text-center"><%= mvt.getDateMouvementStock() %></td>
                          <td class="text-center">
                          <a href="<%= request.getContextPath() %>/mouvementdetail/medicament?id_medicament=<%=mvt.getIdMouvementStock()  %>" class="btn btn-info btn-sm">
                            detail
                          </a>
                         </td>
                        </tr>
                        <% 
                            }
                          } else { 
                        %>
                        <tr>
                          <td class="text-center" colspan="6">Aucun Mouvement disponible</td>
                        </tr>
                        <% 
                          }
                        %>
                      </tbody>
                    </tbody>
                  </table>


                </div>
              </div>
            
              
            </div>
            
          </div>










      </div>
<%@ include file="../elements/footer.jsp" %>