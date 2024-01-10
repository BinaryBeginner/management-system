<!DOCTYPE html>
<html>
<head>
  <title>Áreas de Trabajo</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
    
    <h2>Crear nueva área de trabajo</h2>
    
    <form>
      <div class="mb-3">
        <label for="nombre" class="form-label">Nombre:</label>
        <input type="text" class="form-control" id="nombre" name="nombre" required>
      </div>
      
      <div class="mb-3">
        <label for="descripcion" class="form-label">Descripción:</label>
        <input type="text" class="form-control" id="descripcion" name="descripcion" required>
      </div>
      
      <div class="mb-3">
        <label for="responsable" class="form-label">Responsable:</label>
        <input type="text" class="form-control" id="responsable" name="responsable" required>
      </div>
      
      <button type="submit" class="btn btn-primary">Crear</button>
    </form>
  </div>
  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min