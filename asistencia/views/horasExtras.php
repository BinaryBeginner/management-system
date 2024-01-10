<?php
session_start();

if (!isset($_SESSION['login']) || $_SESSION['login'] == false) {
  header('Location: ../views/index.php');
  exit(); // Agrega la función exit() después de redireccionar para detener la ejecución del código.
}

$nombreusuario = "";
if (isset($_SESSION['nombreusuario'])) {
  $nombreusuario = $_SESSION['nombreusuario'];
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <title>Horas Extras</title>
  <link href="../css/styles.css" rel="stylesheet" />
  <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
  <link rel="shortcut icon" href="../images/Logo.svg">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

  <!-- ÍCONOS FONTAWESOME -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />


  <!-- Lightbox CSS 
        <link rel="stylesheet" href="../dist/lightbox2/src/css/lightbox.css"> -->
</head>

<body class="sb-nav-fixed">
  <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <!-- Navbar Brand-->
    <a class="navbar-brand ps-3" href="../views/administracion.php">Otro Espacio</a>
    <!-- Sidebar Toggle-->
    <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
        class="fas fa-bars"></i></button>
    <!-- Navbar Search-->
    <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
      <div class="input-group">
        <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..."
          aria-describedby="btnNavbarSearch" />
        <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
      </div>
    </form>
    <!-- Navbar-->
    <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
      <li class="nav-item"></span></li>
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown"
       aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
<li><a class="dropdown-item" href="#">Perfil</a></li>
<li><a class="dropdown-item" href="#">Configuración</a></li>
<li>
<hr class="dropdown-divider" />
</li>
<li><a class="dropdown-item" href="../actions/logout.php">Cerrar sesión</a></li>
</ul>
</li>
</ul>
  </nav>
  <div id="layoutSidenav">
    <div id="layoutSidenav_nav">
      <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
          <div class="nav">
            <div class="sb-sidenav-menu-heading">Principal</div>
            <a class="nav-link" href="../views/administracion.php">
              <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
              Panel de control
            </a>
            <div class="sb-sidenav-menu-heading">Gestión de horarios</div>
            <a class="nav-link" href="../views/horas-extras.php">
              <div class="sb-nav-link-icon"><i class="fas fa-clock"></i></div>
              Horas Extras
            </a>
            <a class="nav-link" href="../views/horarios.php">
              <div class="sb-nav-link-icon"><i class="fas fa-calendar-alt"></i></div>
              Horarios
            </a>
            <a class="nav-link" href="../views/calendario.php">
              <div class="sb-nav-link-icon"><i class="fas fa-calendar"></i></div>
              Calendario
            </a>
          </div>
        </div>
        <div class="sb-sidenav-footer">
          <div class="small">Conectado como:</div>
          <?php echo $nombreusuario; ?>
        </div>
      </nav>
    </div>
    <div id="layoutSidenav_content">
      <main>
        <div class="container-fluid px-4">
          <h1 class="mt-4">Horas Extras</h1>
          <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="../views/administracion.php">Panel de control</a></li>
            <li class="breadcrumb-item active">Horas Extras</li>
          </ol>
          <div class="row">
            <div class="col-xl-12 col-md-12">
              <!-- Contenido de la página -->
            </div>
          </div>
        </div>
      </main>
      <footer class="py-4 bg-light mt-auto">
        <div class="container-fluid px-4">
          <div class="d-flex align-items-center justify-content-between small">
            <div class="text-muted">2023 &copy; Tu empresa</div>
            <div>
              <a href="#">Política de privacidad</a>
              &middot;
              <a href="#">Términos y condiciones</a>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </div>
  <!-- Bootstrap Bundle with Popper JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.5.0+1/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-pzjms/i6naW2mfsfGQGgOG/QHFDQViuV5ibxRWxZP6qUWOx10f35f9Z79LHe9Zdt"
    crossorigin="anonymous"></script>
  <!-- Core theme JS-->
  <script src="../js/scripts.js"></script>
</body>
</html>
