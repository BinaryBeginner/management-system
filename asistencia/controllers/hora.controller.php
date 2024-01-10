<?php
require_once '../models/Hora.php';

if (isset($_POST['operacion'])){

  $hora = new Hora();

  if ($_POST['operacion'] == 'reporteDiario') {
    $fechaConsulta = $_POST['fecha_consulta'];
    $horasDiarias = $hora->horasExtrasDiarias($fechaConsulta);
    

    // Generar tabla HTML
    $tabla = '<table>';
    $tabla .= '<tr><th>Nombre Colaborador</th><th>Horas Extras</th><th>Total Horas Trabajadas</th></tr>';

    foreach ($horasDiarias as $fila) {
      $tabla .= '<tr>';
      $tabla .= '<td>' . $fila['nombre_colaborador'] . '</td>';
      $tabla .= '<td>' . $fila['horas_extras'] . '</td>';
      $tabla .= '<td>' . $fila['total_horas_trabajadas'] . '</td>';
      $tabla .= '</tr>';
    }

    $tabla .= '</table>';

    echo $tabla;
  }


  if ($_POST['operacion'] == 'reporteSemanal') {
    $fechaInicio = $_POST['fecha_inicio'];
    $fechaFin = $_POST['fecha_fin'];
    $horasSemanales = $hora->horasExtrasSemanal($fechaInicio, $fechaFin);

    if (!empty($horasSemanales)) {
      // Generar tabla HTML
      $tabla = '<table>';
      $tabla .= '<tr><th>Nombre Colaborador</th><th>Horas Extras</th><th>Total Horas Trabajadas</th></tr>';

      foreach ($horasSemanales as $fila) {
        $tabla .= '<tr>';
        $tabla .= '<td>' . $fila['nombre_colaborador'] . '</td>';
        $tabla .= '<td>' . $fila['horas_extras'] . '</td>';
        $tabla .= '<td>' . $fila['total_horas_trabajadas'] . '</td>';
        $tabla .= '</tr>';
      }

      $tabla .= '</table>';

      echo $tabla;
    } else {
      echo 'No se encontraron resultados para el rango de fechas seleccionado.';
    }
  }


  if ($_POST['operacion'] == 'reporteMensual') {
    $yearConsulta = $_POST['year_consulta'];
    $monthConsulta = $_POST['month_consulta'];
    $horasMensuales = $hora->horasExtrasMensual($yearConsulta, $monthConsulta);

    if (!empty($horasMensuales)) {
      // Generar tabla HTML
      $tabla = '<table>';
      $tabla .= '<tr><th>Nombre Colaborador</th><th>Fecha</th><th>Horas Extras</th><th>Total Horas Trabajadas</th></tr>';

      foreach ($horasMensuales as $fila) {
          $tabla .= '<tr>';
          $tabla .= '<td>' . $fila['nombre_colaborador'] . '</td>';
          $tabla .= '<td>' . $fila['fecha'] . '</td>';
          $tabla .= '<td>' . $fila['horas_extras'] . '</td>';
          $tabla .= '<td>' . $fila['total_horas_trabajadas'] . '</td>';
          $tabla .= '</tr>';
      }

      $tabla .= '</table>';

      echo $tabla;
  } else {
      echo 'No se encontraron resultados para el año y mes seleccionados.';
  }
}

  
  
}

// Intercertar valores que llegan por la URL
if (isset($_GET['operacion'])){

  if($_GET['operacion'] == 'finalizar'){
    session_destroy();
    session_unset(); // Libera cualquier cosa o accion que el servidor haya creado.
    header('Location: ../index.html');
  }
}
