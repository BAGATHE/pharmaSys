<%@ include file="elements/header.jsp" %>
<%@ include file="elements/sidebars.jsp" %>
<%@page import="model.poketra.Poketra"%>

<%
Poketra[] poketras = (Poketra[]) request.getAttribute("poketras");
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
       

        <div class="row">
            <div class="offset-md-2 col-md-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">List Entiter</h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                    <!--<form method="GET" action="${pageContext.request.contextPath}/poketra_list" class="row g-3">
                    <div class="col-3">
                        <input type="text" class="form-control" name="nom_poketra" placeholder="Name">
                    </div>
                    <div class="col-3">
                        <select name="type_poketra" class="form-control" >
                            <option value="">choisir type poketra</option>
                            <option value="TP-1">type 1</option>
                            <option value="TP-2">type 2</option>
                            <option value="TP-3">type 3</option>
                        </select>
                    </div>
                    <div class="col-3">
                        <select name="look_poketra" class="form-control">
                            <option value="">choisir look poketra</option>
                            <option value="LP-1">look 1</option>
                            <option value="LP-2">look 2</option>
                            <option value="LP-3">look 3</option>
                        </select>
                    </div>
                    <div class="col-3">
                        <input type="submit" class="btn btn-success" value="Vaalidez"> 
                    </div>
                    </form>
                -->
                       
                        
                       
                       
                    
                  </div>
                  <table class="table table-hover mt-3">
                    <thead>
                    <form method="GET" action="${pageContext.request.contextPath}/poketra_list" class="row g-3">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">
                                <div class="col-12">
                                    <input type="text" class="form-control" name="nom_poketra" placeholder="Name">
                                </div>
                            </th>
                            <th scope="col">
                                <div class="col-12">
                                    <select name="type_poketra" class="form-control" >
                                        <option value="">choisir type poketra</option>
                                        <option value="TP-1">type 1</option>
                                        <option value="TP-2">type 2</option>
                                        <option value="TP-3">type 3</option>
                                    </select>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="col-12">
                                    <select name="look_poketra" class="form-control">
                                        <option value="">choisir look poketra</option>
                                        <option value="LP-1">look 1</option>
                                        <option value="LP-2">look 2</option>
                                        <option value="LP-3">look 3</option>
                                    </select>
                                </div>
                            </th>
                                <th>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-success">Valider</button>
                                      </div>
                                </th>
                        </tr>
                    </form>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">name</th>
                        <th scope="col">type</th>
                        <th scope="col">look</th>
                        <th scope="col"></th>
                      </tr>
                    </thead>
                    <tbody>
                        <%
                        if (poketras != null) {
                            int index = 1; // Pour numéroter les lignes
                            for (Poketra poketra : poketras) {
                                %>
          <tr>
            <td><%= index++ %></td>
            <td><%= poketra.getNomPoketra() %></td>
            <td><%= poketra.getTypePoketra().getTypePoketra() %></td>
            <td><%= poketra.getLookPoketra().getLook() %></td>
            <td></td>  
        </tr>
          <%
                  }
              } else {
          %>
          <tr>
            <td colspan="4">Aucun Poketra trouvé.</td>
          </tr>
          <%
              }
          %>
                    </tbody>
                  </table>

                    <!-- Pagination -->
            <%
                    int totalRecords = (int) request.getAttribute("totalRecords");
                    int currentPage = (int) request.getAttribute("currentPage");
                    int pageSize = (int) request.getAttribute("pageSize");
                    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
            %>
            <nav>
                <ul class="pagination justify-content-center">
                    <%
                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) {
                    %>
                            <li class="page-item active"><span class="page-link"><%= i %></span></li>
                    <%
                        } else {
                    %>
                            <li class="page-item">
                                <a class="page-link" href="poketra?page=<%= i %>&nom_poketra=<%= request.getParameter("nom_poketra") %>&type_poketra=<%= request.getParameter("type_poketra") %>&look_poketra=<%= request.getParameter("look_poketra") %>">
                                    <%= i %>
                                </a>
                            </li>
                    <%
                        }
                    }
                    %>
                </ul>
            </nav>
            
                </div>
              </div>
            
              
            </div>
            
          </div>










      </div>
<%@ include file="elements/footer.jsp" %>