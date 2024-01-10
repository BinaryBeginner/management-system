<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Formulario de Bonificación</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    body {
      background-color: #f8f9fa; 
    }
  </style>
</head>
<body>
  <div class="container">
    <h1 class="mt-5 mb-4">Formulario de Bonificación</h1>

    <form>
      <div class="mb-3">
        <label for="trabajador" class="form-label">Trabajador</label>
        <select class="form-select" id="trabajador" required>
          <option value="">Seleccione un trabajador</option>
          <option value="1">John Doe</option>
          <option value="2">Jane Smith</option>
          <option value="3">María González</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="monto" class="form-label">Monto de Bonificación</label>
        <input type="number" class="form-control" id="monto" name="monto" required>
      </div>
      <div class="mb-3">
        <label for="motivo" class="form-label">Motivo de Bonificación</label>
        <textarea class="form-control" id="motivo" name="motivo" rows="3" required></textarea>
      </div>
      <button type="submit" class="btn btn-primary">Enviar Bonificación</button>
    </form>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>