<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Pages / Login </title>
  <meta content="" name="description">
  <meta content="" name="keywords">



  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="<%= request.getContextPath()%>/assets/css/bootstrap.min.css" rel="stylesheet">
 
  <!-- Template Main CSS File -->
  <link href="<%= request.getContextPath()%>/assets/css/index.css" rel="stylesheet">

</head>

<body>

  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="index.html" class="logo d-flex align-items-center w-auto">
                  <img src="<%= request.getContextPath() %>/assets/img/kaiadmin/logo_dark.svg" alt="">
                  <span class="d-none d-lg-block"></span>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2 d-flex justify-content-center">
                    <img src="<%= request.getContextPath() %>/assets/img/store-pharmacy.svg" alt="icone pharmacie" height="54 px"/>
                  </div>

                  <form class="row g-3 " method="post" action="login">

                    <div class="col-12">
                      <label for="email" class="form-label">Email <span style="color: crimson;"> *</span></label>
                      <div class="input-group has-validation">
                        <span class="input-group-text" id="inputGroupPrepend">@</span>
                        <input type="email" name="email" class="form-control"  value="admin@email.com" required>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="motDePasse" class="form-label">Mot de Passe <span style="color: crimson;"> *</span></label>
                      <input type="password" name="password" class="form-control"  value="admin" required>
                    </div>
                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">Login</button>
                    </div>
                  </form>
                </div>
              </div>

            </div>
          </div>
        </div>

      </section>

    </div>
  </main><!-- End #main -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

</body>

</html>