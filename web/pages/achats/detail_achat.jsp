<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@ page import="model.achat.AchatDetail" %>
<%@ page import="model.medicament.Medicament" %>
<%@ page import="model.configuration.Unite" %>
<%
    AchatDetail[] achatDetails = (AchatDetail[]) request.getAttribute("achat_details");
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
            <h3 class="fw-bold mb-3">Achat</h3>
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
          



        </div>

        <div class="row">
            <div class="offset-md-2 col-md-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                    <a href="<%= request.getContextPath() %>/achat/laboratoire/list"><button type="submit" class="btn btn-info">retour</button></a>
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Detail Achat </h2></div>
                </div>
                <div class="card-body">
                  <table class="table table-hover mt-3">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th class="text-center" scope="col">Médicament</th>
                            <th class="text-center" scope="col">Quantité</th>
                            <th class="text-center" scope="col">Unité</th>
                            <th class="text-center" scope="col">Prix unitaire</th>
                            <th class="text-center" scope="col">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        if (achatDetails != null && achatDetails.length > 0) {
                            int index = 1;
                            for (AchatDetail detail : achatDetails) { 
                        %>
                        <tr>
                            <td class="text-center"><%= index++ %></td>
                            <td class="text-center"><%= detail.getMedicament().getNom() %></td> 
                            <td class="text-center"><%= detail.getQuantite() %></td>
                            <td class="text-center"><%= detail.getUnite().getNom() %></td>
                            <td class="text-center"><%= String.format("%,.2f", detail.getPrixAchat()) %> Ar</td> 
                            <td class="text-center"><%= String.format("%,.2f", detail.getQuantite() * detail.getPrixAchat()) %> Ar</td> 
                        </tr>
                        <% 
                            }
                        } else { 
                        %>
                        <tr>
                            <td colspan="6" class="text-center">Aucun détail trouvé pour cet achat</td>
                        </tr>
                        <% } %>
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