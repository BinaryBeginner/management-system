<?php

require_once '../models/Colaborador.php';

if (isset($_POST['operacion'])){

  $colaborador = new Colaboradores();


  // OBTENIENDO LOS DATOS DEL COLABORADOR
  if ($_POST['operacion'] == 'obtenerColaborador'){
    $colaboradores = $colaborador->getColaborador($_POST['numerodocumento']);
    echo json_encode($colaboradores);
  }

  if ($_POST['operacion'] == 'obtenerHistorial'){
    $historial = $colaborador->obtenerHistorial();
    echo json_encode($historial);
  }

  if ($_POST['operacion'] == 'registrarEntrada'){
    $colaboradores = $colaborador->registrarHoraEntrada($_POST['numerodocumento']);
    echo json_encode($colaboradores);
  } elseif ($_POST['operacion'] == 'registrarHoraEntrada'){
    $colaboradores = $colaborador->registrarHoraEntrada($_POST['numerodocumento']);
    echo json_encode($colaboradores);
  }
  
  if ($_POST['operacion'] == 'registrarSalida'){
    $colaboradores = $colaborador->registrarHoraSalida($_POST['numerodocumento']);
    echo json_encode($colaboradores);
  } elseif ($_POST['operacion'] == 'registrarHoraEntrada'){
    $colaboradores = $colaborador->registrarHoraEntrada($_POST['numerodocumento']);
    echo json_encode($colaboradores);
  }

  if ($_POST['operacion'] == 'registrar'){

    // PASO1: Recolectar todos los valores enviados por la vista y almacenarlo en un array asociativo
    $datosGuardar = [
      "apellidos"           => $_POST['apellidos'],
      "nombres"             => $_POST['nombres'],
      "tipodocumento"       => $_POST['tipodocumento'],
      "numerodocumento"     => $_POST['numerodocumento'],
      "email"               => $_POST['email'],
      "direccion"           => $_POST['direccion'],
      "rol"                 => $_POST['rol'],
      "telefono"            => $_POST['telefono'],
      "foto"                => ''
    ];

    // Vamos a verificar si la vista nos envío una FOTOGRAFÍA
    if (isset($_FILES['foto'])){

      $rutaDestino = '../views/img/fotografias/';
      $fechaActual = date('c'); // C = Complete, devuelve el AÑO/MES/DIA/HORA/MINUTO/SEGUNDO
      $nombreArchivo = sha1($fechaActual) . ".jpg";
      $rutaDestino .= $nombreArchivo;

      // GUARDAMOS LA FOTOGRAfÍA EN EL SERVIDOR
      // move_uploaded_file: Mover un archivo subido, permite copiar el archivo que viene desde la vista hacia un lugar para el servidor
      if (move_uploaded_file($_FILES['foto']['tmp_name'], $rutaDestino)){
        $datosGuardar['foto'] = $nombreArchivo; 
      }

    }

    // PASO 2: Enviar el array al método registrar
    $colaborador->registrarColaborador($datosGuardar);
  }
  
  if($_POST['operacion'] == 'listar'){
    
    $data = $colaborador->listarColaborador();

    if ($data){
      $numeroFila = 1;
      $datosColaborador = '';
      // $botonFoto hace que si el usuario no tiene foto aparezca en el ícono no tiene foto
      $botonNulo = "<a href='#' class='btn btn-sm btn-warning' title='No tiene fotografía'><i class='fa-solid fa-eye-slash'></i></a>";
      
      foreach ($data as $registro){
        // $datosColaborador: Hace que se viualice el nombre del usuario dentro del lightblox
        $datosColaborador = $registro['apellidos'] . ' ' . $registro['nombres'];

        
        // La primera parte a RENDERIZAR, es lo standar (Siempre se mostrará)
        echo "
          <tr>
            <td>{$numeroFila}</td>
            <td>{$registro['apellidos']}</td>
            <td>{$registro['nombres']}</td>
            <td>{$registro['tipodocumento']}</td>
            <td>{$registro['numerodocumento']}</td>
            <td>{$registro['email']}</td>
            <td>{$registro['direccion']}</td>
            <td>{$registro['rol']}</td>
            <td>{$registro['telefono']}</td>
            <td>
              <a href='#' data-idcolaborador='{$registro['idcolaborador']}' class='btn btn-danger btn-sm eliminar'><i class='fa-solid fa-trash-can'></i></a>
              <a href='#' data-idcolaborador='{$registro['idcolaborador']}' class='btn btn-info btn-sm editar'><i class='fa-solid fa-pencil'></i></a>";
        
        // La segunda parte a RENDERIZAR, es el botón VER FOTOGRAFÍA
        if ($registro['foto'] == ''){
          echo $botonNulo;
        }else{
          // De lo contrario se va a RENDERIZAR
          echo "<a href='../views/img/fotografias/{$registro['foto']}' data-lightbox='{$registro['idcolaborador']}' data-title='{$datosColaborador}'' class='btn btn-sm btn-warning' target='_blank'><i class='fa-solid fa-eye'></i></a>";
        }

        // La tercera parte a RENDERIZAR, cierre de la fila
        echo "
          </td>
        </tr>
        "; 

        $numeroFila++;
      }
    }
  }

  if($_POST['operacion'] == 'obtener_fotografia'){
    $idcolaborador = $_POST['idcolaborador'];

    $archivoFoto = $colaborador->obtenerColaborador($idcolaborador);

    echo $archivoFoto;
  }


  if($_POST['operacion'] == 'eliminar'){
    $idcolaborador = $_POST['idcolaborador'];

    $registro = $colaborador->obtenerColaborador($idcolaborador);

    $colaborador->eliminarColaborador($idcolaborador);

    if($registro['foto']){
      $rutaArchivo = '../views/img/fotografias/' . $registro['foto'];

      if(file_exists($rutaArchivo)){
        unlink($rutaArchivo);
      }
    }
  }

  if($_POST['operacion'] == 'obtener'){
    $registro = $colaborador->recuperarColaborador($_POST['idcolaborador']);
    echo json_encode($registro);
  }

  if ($_POST['operacion'] == 'actualizar') {

    $datosForm = [
        'idcolaborador'     => $_POST['idcolaborador'],
        'apellidos'         => $_POST['apellidos'],
        'nombres'           => $_POST['nombres'],
        'tipodocumento'     => $_POST['tipodocumento'],
        'numerodocumento'   => $_POST['numerodocumento'],
        'email'             => $_POST['email'],
        'direccion'         => $_POST['direccion'],
        'rol'               => $_POST['rol'],
        'telefono'          => $_POST['telefono'],
        'foto'              => ''
    ];

    // Verificar si se ha enviado una nueva foto
    if (isset($_FILES['foto'])) {
        $rutaDestino = '../views/img/fotografias/';
        $fechaActual = date('c');
        $nombreArchivo = sha1($fechaActual) . ".jpg";
        $rutaDestino .= $nombreArchivo;

        try {
            if (move_uploaded_file($_FILES['foto']['tmp_name'], $rutaDestino)) {
                $datosForm['foto'] = $nombreArchivo;
            } else {
                // Error al mover la foto
                echo "Error al subir la foto.";
            }
        } catch (Exception $e) {
            // Error en la subida de la foto
            echo "Error al subir la foto: " . $e->getMessage();
        }
    }

    $colaborador->modificarColaborador($datosForm);

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