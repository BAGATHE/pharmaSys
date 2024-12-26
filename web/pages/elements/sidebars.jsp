<!-- Sidebar -->
<div class="sidebar" data-background-color="dark">
    <div class="sidebar-logo">
      <!-- Logo Header -->
      <div class="logo-header" data-background-color="dark">
        <a href="index.html" class="logo">
          <img
            src="<%= request.getContextPath() %>/assets/img/store-pharmacy.svg"
            alt="navbar brand"
            class="navbar-brand"
            height="40"
          />
          <span style="color: white; font-weight: bold; margin-left: 8px; font-size: larger;">PharmaSys</span>
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
    <div class="sidebar-wrapper scrollbar scrollbar-inner">
      <div class="sidebar-content">
        <ul class="nav nav-secondary">
          <li class="nav-item active">
            <a href="<%= request.getContextPath() %>/pages/dashboard.jsp">
              <i class="far fa-chart-bar"></i>
              <p>Tableau de bord</p>
              <span class="caret"></span>
            </a>
          </li>
          <li class="nav-section">
            <span class="sidebar-mini-icon">
              <i class="fa fa-ellipsis-h"></i>
            </span>
            <h4 class="text-section">Module</h4>
          </li>

          <!--siderBar symptomes debut-->
          <li class="nav-item" accept-charset="UTF-8">
            <a data-bs-toggle="collapse" href="#symptomesSider">
              <i class="fas fa-thermometer-half"></i>
              <p>Symptomes</p>
              <span class="caret"></span>
            </a>
            <div class="collapse" id="symptomesSider">
              <ul class="nav nav-collapse">
                <li>
                  <a class="nav-link" href="<%= request.getContextPath() %>/symptomes/insert">
                    <span class="sub-item">Insertion</span>
                  </a>
                </li>
                <li>
                  <a href="<%= request.getContextPath() %>/symptomes/liste">
                    <span class="sub-item">Liste</span>
                  </a>
                </li>
              </ul>
            </div>
          </li>
          <!--siderBar symptomes fin-->

          <!--siderBar Maladie debut-->
          <li class="nav-item">
            <a data-bs-toggle="collapse" href="#maladieSider">
              <i class="fas fa-heartbeat"></i>
              <p>Maladie</p>
              <span class="caret"></span>
            </a>
            <div class="collapse" id="maladieSider">
              <ul class="nav nav-collapse">
                <li>
                  <a class="nav-link" href="<%= request.getContextPath() %>/pages/maladies/insertion.jsp">
                    <span class="sub-item">Insertion</span>
                  </a>
                </li>
                <li>
                  <a href="<%= request.getContextPath() %>/pages/maladies/liste.jsp">
                    <span class="sub-item">Liste</span>
                  </a>
                </li>
              </ul>
            </div>
          </li>
          <!--siderBar maladie fin-->

          <!--siderBar medicament debut-->
          <li class="nav-item">
            <a data-bs-toggle="collapse" href="#medicamentSider">
              <i class="fas fa-medkit"></i>
              <p>Medicament</p>
              <span class="caret"></span>
            </a>
            <div class="collapse" id="medicamentSider">
              <ul class="nav nav-collapse">
                <li>
                  <a class="nav-link" href="<%= request.getContextPath() %>/pages/medicaments/insertion.jsp">
                    <span class="sub-item">Insertion</span>
                  </a>
                </li>
                <li>
                  <a href="<%= request.getContextPath() %>/pages/medicaments/liste.jsp">
                    <span class="sub-item">Liste</span>
                  </a>
                </li>
              </ul>
            </div>
          </li>
          <!--siderBar medicament fin-->

          <!--siderBar laboratoire debut-->
          <li class="nav-item">
            <a data-bs-toggle="collapse" href="#labSider">
              <i class="fas fa-flask"></i>
              <p>Laboratoire</p>
              <span class="caret"></span>
            </a>
            <div class="collapse" id="labSider">
              <ul class="nav nav-collapse">
                <li>
                  <a class="nav-link" href="<%= request.getContextPath() %>/pages/laboratoires/insertion.jsp">
                    <span class="sub-item">Insertion</span>
                  </a>
                </li>
                <li>
                  <a href="<%= request.getContextPath() %>/pages/laboratoires/liste.jsp">
                    <span class="sub-item">Liste</span>
                  </a>
                </li>
              </ul>
            </div>
          </li>
          <!--siderBar laboratoire fin-->

          <!--siderBar achat debut-->
          <li class="nav-item">
            <a data-bs-toggle="collapse" href="#achatSider">
              <i class="fas fa-shopping-cart"></i>
              <p>Approvisionnement</p>
              <span class="caret"></span>
            </a>
            <div class="collapse" id="achatSider">
              <ul class="nav nav-collapse">
                <li>
                  <a class="nav-link" href="<%= request.getContextPath() %>/pages/achats/liste_fournisseur.jsp">
                    <span class="sub-item">faire une commande</span>
                  </a>
                </li>
                <li>
                  <a href="<%= request.getContextPath() %>/pages/achats/liste.jsp">
                    <span class="sub-item">Historique Commandes</span>
                  </a>
                </li>
              </ul>
            </div>
          </li>
           <!--siderBar achat fin-->

            <!--siderBar vente debut-->
          <li class="nav-item">
            <a data-bs-toggle="collapse" href="#venteSider">
              <i class="fas fa-tags"></i>
              <p>Vente</p>
              <span class="caret"></span>
            </a>
            <div class="collapse" id="venteSider">
              <ul class="nav nav-collapse">
                <li>
                  <a class="nav-link" href="<%= request.getContextPath() %>/pages/ventes/insertion.jsp">
                    <span class="sub-item">Insertion</span>
                  </a>
                </li>
                <li>
                  <a href="<%= request.getContextPath() %>/pages/ventes/liste.jsp">
                    <span class="sub-item">Liste</span>
                  </a>
                </li>
              </ul>
            </div>
          </li>
           <!--siderBar vente fin-->
          
           <!--siderBar stock debut-->
          <li class="nav-item">
            <a data-bs-toggle="collapse" href="#tables">
              <i class="fas fa-table"></i>
              <p>Stock</p>
              <span class="caret"></span>
            </a>
            <div class="collapse" id="tables">
              <ul class="nav nav-collapse">
                <li>
                  <a href="<%= request.getContextPath() %>/pages/stock/etat_stock.jsp">
                    <span class="sub-item">Etat Stock produit</span>
                  </a>
                </li>
              </ul>
            </div>
          </li>
          <!--siderBar stock fin-->

          <!--siderBar configuration debut-->
          <li class="nav-item">
            <a data-bs-toggle="collapse" href="#conf">
              <i class="fas fa-bars"></i>
              <p>Configuration</p>
              <span class="caret"></span>
            </a>
            <div class="collapse" id="conf">
              <ul class="nav nav-collapse">
                <li>
                  <a data-bs-toggle="collapse" href="#reduction">
                    <span class="sub-item">Reduction Produit</span>
                    <span class="caret"></span>
                  </a>
                  <div class="collapse" id="reduction">
                    <ul class="nav nav-collapse subnav">
                      <li>
                        <a href="<%= request.getContextPath() %>/pages/reductions/insertion.jsp">
                          <span class="sub-item">Insertion</span>
                        </a>
                      </li>
                      <li>
                        <a href="<%= request.getContextPath() %>/pages/reductions/liste.jsp">
                          <span class="sub-item">Liste</span>
                        </a>
                      </li>
                    </ul>
                  </div>
                </li>
                <li>
                  <a data-bs-toggle="collapse" href="#unite">
                    <span class="sub-item">Unite</span>
                    <span class="caret"></span>
                  </a>
                  <div class="collapse" id="unite">
                    <ul class="nav nav-collapse subnav">
                      <li>
                        <a href="<%= request.getContextPath() %>/unite/insert">
                          <span class="sub-item">Insertion</span>
                        </a>
                      </li>
                      <li>
                        <a href="<%= request.getContextPath() %>/unite/list">
                          <span class="sub-item">Liste</span>
                        </a>
                      </li>
                    </ul>
                  </div>
                </li>
              </ul>
            </div>
          </li>
          <!--siderBar configuration fin-->
          
          <!--siderBar deconnection debut-->
          <li class="nav-item">
            <a href="">
              <i class="fas fa-sign-out-alt"></i>
              <p style="color: crimson;">Deconnection</p>
            </a>
          </li>
          <!--siderBar deconnection fin-->
        
        </ul>
      </div>
    </div>
  </div>
  <!-- End Sidebar -->