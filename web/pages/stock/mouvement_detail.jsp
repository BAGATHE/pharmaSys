<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.stock.MouvementStockDetail"%>
<%
MouvementStockDetail[] mvtDetails = (MouvementStockDetail[]) request.getAttribute("mvtDetails");
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
                <a href="#">Etat</a>
              </li>
              <li class="separator">
                <i class="icon-arrow-right"></i>
              </li>
              <li class="nav-item">
                <a href="#">Stock</a>
              </li>
            </ul>
          </div>
          



        </div>

        <div class="row">
            <div class="col-10 offset-1">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <a href="<%= request.getContextPath() %>/mouvement/medicament"><button type="button" class="btn btn-info">retour</button></a>
                  <div class="card-title" ><h2 class="text-center" style="color: white;">details </h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                  </div>
                  <table class="table table-hover mt-3">
                    <thead>
                      <tr>
                        <th class="text-center" scope="col">Médicament</th>
                        <th class="text-center" scope="col">Type</th>
                        <th class="text-center" scope="col">Unité</th>
                        <th class="text-center" scope="col">Prix unitaire</th>
                        <th class="text-center" scope="col">Entréé</th>
                        <th class="text-center" scope="col">Sortie</th>
                      </tr>
                    </thead>
                    <tbody>
                      <% 
                        if (mvtDetails != null && mvtDetails.length > 0) {
                          for (int i = 0; i < mvtDetails.length; i++) {
                            MouvementStockDetail mvtDetail = mvtDetails[i];
                      %>
                      <tr>
                        <td class="text-center"><%= mvtDetail.getMedicament().getNom() %></td> 
                        <td class="text-center"><%= mvtDetail.getMedicament().getTypeMedicament().getTypeMedicament() %></td>
                        <td class="text-center"><%= mvtDetail.getUnite().getNom() %></td> 
                        <td class="text-center"><%= mvtDetail.getPrixUnitaire() %></td>
                        <td class="text-center"><%= mvtDetail.getEntree() %></td>
                        <td class="text-center"><%= mvtDetail.getSortie() %></td> 
                          
                      
                      </tr>
                      <% 
                          }
                        } else { 
                      %>
                      <tr>
                        <td class="text-center" colspan="6">Aucun details disponible</td>
                      </tr>
                      <% 
                        }
                      %>
                    </tbody>
                  </table>

                </div>
              </div>
            
              
            </div>
            
          </div>










      </div>   
<%@ include file="../elements/footer.jsp" %>