<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.stock.StockMedicament"%>
<%
StockMedicament[] stocks = (StockMedicament[]) request.getAttribute("stocks");
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
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Etat Stock </h2></div>
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
                        <th class="text-center" scope="col">Médicament</th>
                        <th class="text-center" scope="col">Type</th>
                        <th class="text-center" scope="col">Quantité en stock</th>
                        <th class="text-center" scope="col">Unité</th>
                        <th class="text-center" scope="col">Status</th>
                      </tr>
                    </thead>
                    <tbody>
                      <% 
                        if (stocks != null && stocks.length > 0) {
                          for (int i = 0; i < stocks.length; i++) {
                            StockMedicament stock = stocks[i];
                      %>
                      <tr>
                        <td class="text-center"><%= stock.getMedicament().getNom() %></td> 
                        <td class="text-center"><%= stock.getMedicament().getTypeMedicament().getTypeMedicament() %></td>
                        <td class="text-center"><%= stock.getQuantiteBoite() %></td>
                        <td class="text-center"><%= stock.getUnite().getNom() %></td> 
                        <td class="text-center status-cell" data-status="<%= stock.getStatus().getNom() %>">
                          <%= stock.getStatus().getNom() %>
                        </td>
                          
                      
                      </tr>
                      <% 
                          }
                        } else { 
                      %>
                      <tr>
                        <td class="text-center" colspan="6">Aucun stock disponible</td>
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
      <script>
        document.addEventListener("DOMContentLoaded", function () {
            const statusCells = document.querySelectorAll(".status-cell");
        
            statusCells.forEach(cell => {
                const status = cell.getAttribute("data-status").toLowerCase(); 
        
                if (status.includes("suffisant")) {
                    cell.style.backgroundColor = "#d4edda"; // Vert clair
                    cell.style.color = "#155724";          // Texte vert foncé
                } else if (status.includes("critique")) {
                    cell.style.backgroundColor = "#ffeeba"; // Orange clair
                    cell.style.color = "#856404";           // Texte orange foncé
                } else if (status.includes("rupture")) {
                    cell.style.backgroundColor = "crimson"; // Rouge
                    cell.style.color = "white";            // Texte blanc
                }
            });
        });
    </script>
    
    
    
<%@ include file="../elements/footer.jsp" %>