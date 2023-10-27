<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/css/bootstrap.min.css">
  <title>Crear Contrato</title>
</head>
<body>
<?php
// Incluir el archivo de conexión a la base de datos
require ('../conexiones/conexion_be.php');

// Obtener los datos del formulario
if(isset($_POST['guardar'])){
$fecha_contrato = $_POST['fecha_contrato'];
$fecha_inicio = $_POST['fecha_inicio'];
$fecha_fin = $_POST['fecha_fin'];
$tipo_contrato = $_POST['tipo_contrato'];
$area_empresa = $_POST['area_empresa'];
$sueldo_basico = $_POST['sueldo_basico'];
$administrador_id = $_POST['administrador_id_administrador'];

$ejecutarInsertar = ("INSERT INTO contrato (fecha_contrato, fecha_inicio, fecha_fin, tipo_contrato, area_empresa, sueldo_basico, administrador_id_administrador) VALUES ('{$fecha_contrato}', '{$fecha_inicio}', '{$fecha_fin}', '{$tipo_contrato}', '{$area_empresa}', '{$sueldo_basico}', '{$administrador_id}')");

$ejecutarInsertar = mysqli_query($conexion, $ejecutarInsertar);

if (!$ejecutarInsertar) {
  echo 'Error carajo :D';
} else {
  echo 'Dato grabado :D';
}



}
?>
  <div class="container">
    <h1>Crear Contrato</h1>
    
    <form action="" method="post" enctype="multipart/form-data" name="form1">
    
      <div class="mb-3">
        <label for="fecha_contrato" class="form-label">Fecha Contrato:</label>
        <input type="date" class="form-control" id="fecha_contrato" name="fecha_contrato" required>
      </div>
      
      <div class="mb-3">
        <label for="fecha_inicio" class="form-label">Fecha Inicio:</label>
        <input type="date" class="form-control" id="fecha_inicio" name="fecha_inicio" required>
      </div>
      
      <div class="mb-3">
        <label for="fecha_fin" class="form-label">Fecha Fin:</label>
        <input type="date" class="form-control" id="fecha_fin" name="fecha_fin" required>
      </div>

      <div class="mb-3">
        <label for="tipo_contrato" class="form-label">Tipo Contrato:</label>
        <input type="text" class="form-control" id="tipo_contrato" name="tipo_contrato" required>
      </div>

      <div class="mb-3">
        <label for="area_empresa" class="form-label">Área de la Empresa:</label>
        <input type="text" class="form-control" id="area_empresa" name="area_empresa" required>
      </div>

      <div class="mb-3">
        <label for="sueldo_basico" class="form-label">Sueldo Básico:</label>
        <input type="text" class="form-control" id="sueldo_basico" name="sueldo_basico" required>
      </div>

      <div class="mb-3">
        <label for="administrador_id_administrador" class="form-label">ID Administrador:</label>
        <input type="text" class="form-control" id="administrador_id_administrador" name="administrador_id_administrador" required>
      </div>

      <button type="submit" name="guardar" class="btn btn-primary">Guardar</button>
    </form>
  </div>
  <div class="container, pt-5">
    
    <div class="mx-auto" style="width: 200px;  padding-bottom:20px; font-size: 30px;">Mis Contratos</div>
  
  <div class="row align-items-start">
    <div class="col">ID Contrato</div>
    <div class="col">Fecha Contrato</div>
    <div class="col">Fecha Inicio</div>
    <div class="col">Fecha Fin</div>
    <div class="col">Tipo Contrato</div>
    <div class="col">Area de la Empresa</div>
    <div class="col">Sueldo Basico</div>
    <div class="col">ID Administrador</div>
  </div> 

<?php
$resultados = mysqli_query($conexion , "select * from contrato order by id_contrato");
while($rs=mysqli_fetch_array($resultados)) {
?>
<div class="row align-items-start">
    <div class="col"><?php echo $rs['id_contrato'];?></div>
    <div class="col"><?php echo $rs['fecha_contrato'];?></div>
    <div class="col"><?php echo $rs['fecha_inicio'];?></div>
    <div class="col"><?php echo $rs['fecha_fin'];?></div>
    <div class="col"><?php echo $rs['tipo_contrato'];?></div>
    <div class="col"><?php echo $rs['area_empresa'];?></div>
    <div class="col"><?php echo $rs['sueldo_basico'];?></div>
    <div class="col"><?php echo $rs['administrador_id_administrador'];?></div>
</div> 
<?php
}
?>

  <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
