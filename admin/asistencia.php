<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Asistencia de Trabajadores</title>
  <!-- Agrega los enlaces a los archivos de Bootstrap -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
    <h1 class="mt-5 mb-4">Asistencia de Trabajadores</h1>

    <!-- Filtro -->
    <div class="mb-3">
      <label for="filtroRol" class="form-label">Filtrar por Rol:</label>
      <select class="form-select" id="filtroRol">
        <option value="">Todos</option>
        <option value="Gerente">Gerente</option>
        <option value="Supervisor">Supervisor</option>
        <option value="Operario">Operario</option>
        <!-- Agrega más opciones de filtro aquí -->
      </select>
    </div>

    <!-- Tabla de Asistencia -->
    <table class="table">
      <thead>
        <tr>
          <th scope="col">DNI</th>
          <th scope="col">Apellidos</th>
          <th scope="col">Nombres</th>
          <th scope="col">Rol</th>
          <th scope="col">Hora de Ingreso</th>
          <th scope="col">Hora de Salida</th>
          <th scope="col">Acciones</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>12345678</td>
          <td>Doe</td>
          <td>John</td>
          <td>Gerente</td>
          <td>08:00 AM</td>
          <td>05:00 PM</td>
          <td>
            <button class="btn btn-primary btn-sm">Editar</button>
            <!-- Agrega más botones de acción aquí -->
          </td>
        </tr>
        <tr>
          <td>87654321</td>
          <td>Smith</td>
          <td>Jane</td>
          <td>Supervisor</td>
          <td>09:30 AM</td>
          <td>06:30 PM</td>
          <td>
            <button class="btn btn-primary btn-sm">Editar</button>
            <!-- Agrega más botones de acción aquí -->
          </td>
        </tr>
        <tr>
          <td>65432198</td>
          <td>González</td>
          <td>María</td>
          <td>Operario</td>
          <td>07:45 AM</td>
          <td>04:45 PM</td>
          <td>
            <button class="btn btn-primary btn-sm">Editar</button>
            <!-- Agrega más botones de acción aquí -->
          </td>
        </tr>
        <!-- Agrega más registros aquí -->
        <tr>
          <td>54321678</td>
          <td>López</td>
          <td>Carlos</td>
          <td>Analista</td>
          <td>08:15 AM</td>
          <td>05:15 PM</td>
          <td>
            <button class="btn btn-primary btn-sm">Editar</button>
            <!-- Agrega más botones de acción aquí -->
          </td>
        </tr>
        <tr>
          <td>98765432</td>
          <td>Wang</td>
          <td>Ling</td>
          <td>Desarrollador</td>
          <td>09:00 AM</td>
          <td>06:00 PM</td>
          <td>
            <button class="btn btn-primary btn-sm">Editar</button>
            <!-- Agrega más botones de acción aquí -->
          </td>
        </tr>
      </tbody>
    </table>
  </div>

  <!-- Agrega el enlace al archivo de script de Bootstrap -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>