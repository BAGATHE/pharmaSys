<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
<%@page import="model.client.Client"%>

<%
    Client[] clients = (Client[]) request.getAttribute("clients");
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
            <h3 class="fw-bold mb-3">client</h3>
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
            <div class="col-12">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">Liste clients </h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                    <form method="POST" action="" class="row g-3">
                      <div class="col-3">
                        <select name="" id="" class="form-select">
                            <option value="">-- Toutes les XXX --</option>
                        </select>
                      </div>
                      <div class="col-3">
                        <select name="" id="" class="form-select">
                            <option value="">-- Toutes les XXX --</option>
                        </select>
                      </div>
                      <div class="col-2">
                        <button type="submit" class="btn btn-success">Valider</button>
                    </div>
                    </form>
                  </div>
                  <table class="table table-bordered table-head-bg-success  mt-3">
                    <thead>
                      <tr>
                        <th class="text-center" scope="col">client</th>
                        <th  class="text-center" scope="col">Identifiant</th>
                        <th  class="text-center" scope="col">Type</th>
                        <th  class="text-center" scope="col" colspan="2">action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <%
                      if(clients!=null || clients.length > 0){
                        for(Client client : clients){ %>
                          <tr>
                            <td class="text-center"><%=client.getNom() %></td>
                            <td class="text-center"><%=client.getIdentifiant() %></td> 
                            <td class="text-center"><%=client.getTypeClient() %></td>     
                            <td>
                                <a href="<%= request.getContextPath() %>/client/vente/list?id_client=<%=client.getIdClient() %>"> 
                                    <button type="button" class="btn btn-info btn-sm">
                                        <i class="fas fa-eye"></i> Consulter liste vente
                                    </button>
                                </a>
                            </td>
                         
                            <td>
                                <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal<%=client.getIdClient() %>">
                                    <i class="fas fa-trash-alt"></i> Supprimer
                                </button>
                                <div class="modal fade" id="deleteModal<%=client.getIdClient() %>" tabindex="-1" aria-labelledby="deleteModalLabel<%=client.getIdClient() %>" aria-hidden="true">
                                    <div class="modal-dialog">
                                      <div class="modal-content">
                                        <div class="modal-header">
                                          <h5 class="modal-title" id="deleteModalLabel">Confirmer la suppression</h5>
                                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                          cette action est irreversible.
                                        </div>
                                        <div class="modal-footer">
                                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                          <a href=""><button type="button" class="btn btn-danger">Supprimer</button></a>
                                        </div>
                                      </div>
                                    </div>
                                </div>
                            </td>
                          </tr>
                     <%} } else{ %>
                      <tr>
                        <td colspan="6" class="text-center">Aucun client trouvé</td>
                    </tr>
                      <%} %> 
                      
                    </tbody>
                  </table>


                </div>
              </div>
            
              
            </div>
            
          </div>

         



        </div>

       









      </div>
<%@ include file="../elements/footer.jsp" %>