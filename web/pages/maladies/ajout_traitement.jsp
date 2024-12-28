<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../elements/header.jsp" %>
<%@ include file="../elements/sidebars.jsp" %>
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
            <h3 class="fw-bold mb-3">Maladies</h3>
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
                <a href="#">Formulaire insertion</a>
              </li>
            </ul>
          </div>
           <!--bouton retour-->
           <div class="row">
            <div class="col-3">
                <a href="<%= request.getContextPath() %>/pages/maladies/symptome_traitement_liste.jsp">
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
                  <div class="card-title"><h2 class="text-center" style="color: white;">Insertion Traitement</h2></div>
                </div>
                <!--Debut formulaire-->
                <form action="" method="post">
                <div class="card-body">
                  <div class="row">
                    <div class="offset-1 col-10">

                        <div class="row">
                            <div class="col-10 offset-1">
                              <div class="form-group">
                                <label for="nom">maladie</label>
                                <input type="text" class="form-control" value="maladie" readonly/>
                                <input type="hidden"  value="id_maladie" name="maladie"/>
                              </div>
                            </div>
                          </div> 

                          <div class="row">
                            <div class="col-10 offset-1">
                                <div class="form-group">
                                    <label for="">Medicament</label>
                                    <select id="traitement" multiple placeholder="Select items...">
                                        <option value="apple">Medicament 1</option>
                                        <option value="banana">Medicament 2</option>
                                        <option value="orange">Medicament 3</option>
                                    </select>
                                  </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="col-10 offset-1">
                                <div class="form-group">
                                    <label for="">Efficacité</label>
                                    <select id="efficacite" multiple placeholder="Select items...">
                                        
                                    </select>
                                  </div>
                            </div>
                          </div>
                    </div>
                  </div>
                </div>
                <div class="card-action">
                  <button class="btn btn-success">Valider</button>
                </div>
              </form>
               <!--fin formulaire-->
              </div>
            </div>
          </div>
        </div>

       


      </div>

      <script>
      
        new TomSelect('#traitement', {
          placeholder: 'Selection multiple traitement',
          plugins: ['remove_button'],   // Ajouter le bouton pour supprimer les tags
          maxItems: null,                  // Limiter la sélection à 3 éléments maximum
          create: false,                // Désactiver la création d'éléments personnalisés
          searchField: 'text',          // Rechercher dans le texte des options
        });

          // Créer dynamiquement les options pour le sélecteur de nombres de 1 à 100
  const numberSelect = document.getElementById('efficacite');
  for (let i = 1; i <= 100; i++) {
    const option = document.createElement('option');
    option.value = i;
    option.textContent = i;
    numberSelect.appendChild(option);
  }

  // Initialiser TomSelect pour le sélecteur de nombres
  new TomSelect('#efficacite', {
    placeholder: 'selectionne degre efficacite',
    plugins: ['remove_button'],
    create: false,
    searchField: 'text',
    dropdownDirection: 'up'
  });
      </script>
<%@ include file="../elements/footer.jsp" %>