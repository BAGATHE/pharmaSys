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
          <div class="row">
            <div class="offset-2 col-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title"><h2 class="text-center" style="color: white;">Insertion Maladie</h2></div>
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
                                <input
                                  type="text"
                                  class="form-control"
                                  placeholder="Entrer maladie"
                                  required
                                />
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-10 offset-1">
                                <div class="form-group">
                                    <label for="description">description</label>
                                    <textarea class="form-control"  rows="5">
                                    </textarea>
                                </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="col-10 offset-1">
                                <div class="form-group">
                                    <label for="">Symptomes</label>
                                    <select id="symptomes" multiple placeholder="Select items...">
                                        <option value="apple">symp 1</option>
                                        <option value="banana">symp 2</option>
                                        <option value="orange">symp 3</option>
                                        <option value="grape">symp 4</option>
                                        <option value="watermelon">symp 5</option>
                                    </select>
                                  </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="col-10 offset-1">
                                <div class="form-group">
                                    <label for="">traitement</label>
                                    <select id="traitement" multiple placeholder="Select items...">
                                        <option selected value="apple">traitement 1</option>
                                        <option value="banana">traitement 2</option>
                                        <option value="orange">traitement 3</option>
                                        <option selected value="grape">traitement 4</option>
                                        <option value="watermelon">traitement 5</option>
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
        // Initialiser TomSelect avec plusieurs options
        new TomSelect('#symptomes', {
          placeholder: 'Selection multipe symptôme',
          plugins: ['remove_button'],   // Ajouter le bouton pour supprimer les tags
          maxItems: null,                  // Limiter la sélection à 3 éléments maximum
          create: false,                // Désactiver la création d'éléments personnalisés
          searchField: 'text',          // Rechercher dans le texte des options
        });
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