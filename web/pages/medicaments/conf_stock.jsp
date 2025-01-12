<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.status.Status"%>
<%@page import="model.status.MedicamentStatusStock"%>
<%@page import="model.medicament.Medicament"%>

<%
    Status[] statusconfs = (Status[]) request.getAttribute("status");
    Medicament medicament = (Medicament) request.getAttribute("medicament");
    MedicamentStatusStock[] medicamentStatusArray = (MedicamentStatusStock[]) request.getAttribute("medicament_status");
    String message = (String) request.getAttribute("message");
    if (message != null && !message.trim().isEmpty()) {
%>
    <script src="<%= request.getContextPath() %>/assets/js/plugin/sweetalert/sweetalert.min.js"></script>
    <script>
        swal({ title: "Notification",text: "<%= message %>",icon: "info", button: "OK"});
    </script>
<%
        request.setAttribute("message", "");
    }
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
    </div>

    <div class="container">
        <div class="page-inner">
          <div class="page-header">
            <h3 class="fw-bold mb-3">Seuille Stock</h3>
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
                <a href="#">Medicament</a>
              </li>
            </ul>
          </div>
           <!--bouton retour-->
           <div class="row">
            <div class="col-3">
                <a href="<%= request.getContextPath() %>/medicament/list">
                    <button type="button" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left" style="font-size: 1.5em;"></i> Retour
                    </button>
                </a>
            </div>
          </div>
          <!--bouton retour-->
          <div class="row">
            <div class="offset-2 col-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title"><h2 class="text-center" style="color: white;">Insertion configuration stock</h2></div>
                </div>
                <!--Debut formulaire-->
                <form action="<%= request.getContextPath() %>/medicament/confstock" method="post">
                <div class="card-body">
                  <div class="row">
                    <div class="offset-1 col-10">

                        <div class="row">
                            <div class="col-10 offset-1">
                              <div class="form-group">
                                <label for="nom">Medicament</label>
                                <input type="text" class="form-control" value="<%= medicament.getNom() %>" readonly/>
                                <input type="hidden"  value="<%= medicament.getIdMedicament() %>" name="id_medicament"/>
                              </div>
                            </div>
                          </div> 
                          <div class="row">
                          <div class="col-10 offset-1">
                            <div class="form-group">
                              <label for="categorie" class="form-label">status</label>
                              <select name="status" id="status" class="form-select">
                                  <option value="">-- Toutes les status --</option>
                                  <%
                                      if (statusconfs != null) {
                                          for (Status status : statusconfs) {
                                  %>
                                              <option value="<%= status.getIdStatus() %>"><%= status.getNom() %></option>
                                  <%
                                          }
                                      }
                                  %>
                              </select>
                            </div>
                          </div>
                          </div>

                          <div class="row">
                            <div class="col-3 offset-1">
                                <div class="form-group d-flex align-items-center">
                                    <label for="min" class="mr-2">Min:</label>
                                    <input id="min" class="form-control" type="number" name="min">
                                </div>
                            </div>
                        
                            <div class="col-3 offset-1">
                                <div class="form-group d-flex align-items-center">
                                    <label for="max" class="mr-2">Max:</label>
                                    <input id="max" class="form-control" type="number" name="max">
                                </div>
                            </div>
                        </div>

                         
                    </div>
                  </div>
                </div>
                <div class="card-action">
                  <button class="btn btn-success" type="submit">Valider</button>
                </div>
              </form>
               <!--fin formulaire-->
              </div>
            </div>
          </div>
        </div>

        <div class="row">
            <div class="offset-md-2 col-md-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">List Entiter</h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                  </div>
                  <table class="table table-hover mt-3">
                    <thead>
                        <tr>
                            <th scope="col">Status</th>
                            <th scope="col">Minimum</th>
                            <th scope="col">Maximum</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if (medicamentStatusArray != null && medicamentStatusArray.length > 0) {
                                for (MedicamentStatusStock medicamentStatus : medicamentStatusArray) {
                        %>
                        <tr>
                          <td><%= medicamentStatus.getStatus().getNom() %></td>
                          <td><%= medicamentStatus.getMinimum() %></td>
                          <td><%= medicamentStatus.getMaximum() %></td>
                          <td>
                              
                            <a href="<%= request.getContextPath() %>/medicament/confstock/delete?id_medicament=<%= medicamentStatus.getIdMedicament() %>&id_status=<%= medicamentStatus.getStatus().getIdStatus() %>" class="btn btn-danger btn-sm">
                              Supprimer
                            </a>
                          </td>
                      </tr>
                        <% 
                                }
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