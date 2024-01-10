<?php
require('conexion_be.php');

// Procesamiento del formulario
if(isset($_POST['guardar'])) {
    $dni = $_POST['dni'];
    $nombre = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $direccion = $_POST['direccion'];
    $nacionalidad = $_POST['nacionalidad'];

    // Preparar la consulta SQL para insertar los datos en la base de datos
    $sql = "INSERT INTO trabajador (dni, nombre, apellido, direccion, nacionalidad) 
            VALUES (:dni, :nombre, :apellido, :direccion, :nacionalidad)";
    $stmt = $conn->prepare($sql);

    // Asignar los valores a los parámetros de la consulta
    $stmt->bindParam(':dni', $dni);
    $stmt->bindParam(':nombre', $nombre);
    $stmt->bindParam(':apellido', $apellido);
    $stmt->bindParam(':direccion', $direccion);
    $stmt->bindParam(':nacionalidad', $nacionalidad);

    // Ejecutar la consulta
    try {
        $stmt->execute();
        echo "Trabajador agregado correctamente.";
    } catch(PDOException $e) {
        echo "Error al agregar el trabajador: " . $e->getMessage();
    }
}
?>
