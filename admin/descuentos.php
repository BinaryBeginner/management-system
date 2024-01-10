<!DOCTYPE html>
<html>
<head>
  <title>Descuentos de Trabajadores</title>
  <!-- Incluye los estilos de Bootstrap -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
    <h1>Descuentos de Trabajadores</h1>
    <form>
      <div class="form-group">
        <label for="nombre">Nombre del Trabajador:</label>
        <input type="text" class="form-control" id="nombre" placeholder="Ingresa el nombre del trabajador">
      </div>
      <div class="form-group">
        <label for="salario">Salario:</label>
        <input type="number" class="form-control" id="salario" placeholder="Ingresa el salario del trabajador">
      </div>
      <div class="form-group">
        <label for="descuento">Descuento:</label>
        <input type="number" class="form-control" id="descuento" placeholder="Ingresa el monto del descuento">
      </div>
      <button type="button" class="btn btn-primary" onclick="aplicarDescuento()">Aplicar Descuento</button>
    </form>
    <div id="resultado" style="display: none;">
      <h2>Resultado:</h2>
      <p id="nombreResultado"></p>
      <p id="salarioResultado"></p>
      <p id="descuentoResultado"></p>
      <p id="nuevoSalarioResultado"></p>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

  <script>
    function aplicarDescuento() {
      var nombre = document.getElementById("nombre").value;
      var salario = parseFloat(document.getElementById("salario").value);
      var descuento = parseFloat(document.getElementById("descuento").value);

      var nuevoSalario = salario - descuento;

      document.getElementById("nombreResultado").innerHTML = "Nombre: " + nombre;
      document.getElementById("salarioResultado").innerHTML = "Salario: $" + salario;
      document.getElementById("descuentoResultado").innerHTML = "Descuento: $" + descuento;
      document.getElementById("nuevoSalarioResultado").innerHTML = "Nuevo Salario: $" + nuevoSalario;

      document.getElementById("resultado").style.display = "block";
    }
  </script>
</body>
</html>
