<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/css/bootstrap.min.css">
  <title>Agregar Trabajador</title>
</head>
<style>
    .container{
        margin-top:50px;
    }
</style>
<body>

  <div class="container">
    <h1>Agregar Trabajador</h1>
    
    <form action="funciones/agregar_trabajador.php" method="POST" id="trabajadorForm">
      <div class="mb-3">
        <label for="dni" class="form-label">DNI:</label>
        <input type="text" class="form-control" id="dni" name="dni" required>
      </div>

      <div class="mb-3">
        <label for="nombre" class="form-label">Nombre:</label>
        <input type="text" class="form-control" id="nombre" name="nombre" required>
      </div>
      
      <div class="mb-3">
        <label for="apellido" class="form-label">Apellido:</label>
        <input type="text" class="form-control" id="apellido" name="apellido" required>
      </div>
      
      <div class="mb-3">
        <label for="direccion" class="form-label">Dirección:</label>
        <input type="text" class="form-control" id="direccion" name="direccion" required>
      </div>

      <div class="mb-3">
        <label for="nacionalidad" class="form-label">Nacionalidad:</label>
        <input type="text" class="form-control" id="nacionalidad" name="nacionalidad" required>
      </div>

      <button type="submit" name="guardar" class="btn btn-primary">Guardar</button>
    </form>
  </div>

  <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
