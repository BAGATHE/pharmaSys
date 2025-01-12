<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>PharmaSys</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="<%= request.getContextPath() %>/assets/img/store-pharmacy.svg"
      type="image/x-icon"
    />

    <!-- Fonts and icons -->
    <script src="<%= request.getContextPath() %>/assets/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["<%= request.getContextPath() %>/assets/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/kaiadmin.min.css" />

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

  

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/demo.css" />
    <link href="https://cdn.jsdelivr.net/npm/tom-select@2.4.1/dist/css/tom-select.default.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/tomselect.css" />
    <script src="<%= request.getContextPath() %>/assets/js/tom-select.complete.js"></script>
   <style>
    body {
    font-family: 'Montserrat', sans-serif;
  }
  
   </style>
  </head>
  <body>
    <div class="wrapper">