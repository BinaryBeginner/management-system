<!DOCTYPE html>
<html>
<head>
  <title>Formulario de Inicio de Sesión</title>
  <!-- Incluir los estilos de Bootstrap -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <link rel="stylesheet" href="CSS/login.css">
</head>
<body>
<?php
  if (isset($_GET['error'])) {
    $error = $_GET['error'];
    if ($error == 'invalid_credentials') {
      echo '<div style="width:500px; text-align:center; margin-left:auto; margin-right:auto; margin-top: 20px;" class="alert alert-danger" role="alert">Credenciales inválidas. Inténtelo de nuevo.</div>';
    }
  }
  ?>
  <div class="container login-container">
    <div class="row">
      <div class="col-md-6 login-form-1">
        <h3>ADMINISTRADOR</h3>
        <form action="conexiones\login_usuario_be.php" method="POST">
          <div class="form-group">
            <input type="text" name="usuario" class="form-control" placeholder="Tu correo *" value="" />
          </div>
          <div class="form-group">
            <input type="password" name="contraseña" class="form-control" placeholder="Tu contraseña *" value="" />
          </div>
          <div class="form-group">
            <input type="submit" class="btnSubmit" value="INGRESAR" />
          </div>
          <div class="form-group">
            <a href="#" class="ForgetPwd">¿Olvido su contraseña?</a>
          </div>
        </form>
      </div>
      <div class="col-md-6 login-form-2">
        <h3>EMPLEADO</h3>
        <form action="conexiones\login_trabajador_be.php" method="POST">
          <div class="form-group">
            <input type="text" name="correo" class="form-control" placeholder="Tu correo *" value="" />
          </div>
          <div class="form-group">
            <input type="password" name="password" class="form-control" placeholder="Tu contraseña *" value="" />
          </div>
          <div class="form-group">
            <input type="submit" class="btnSubmit" value="INGRESAR" />
          </div>
          <div class="form-group">
            <a href="#" class="ForgetPwd" value="Login">¿Olvido su contraseña?</a>
          </div>
        </form>
      </div>
    </div>
  </div>

  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
  <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

  
  ?>
</body>
</html>
