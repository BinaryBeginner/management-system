<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "gestion_trabajadores";

// Establecer la conexión
$conexion = mysqli_connect($servername, $username, $password, $dbname);

if (!$conexion) {
    die("Error al conectar a la base de datos: " . mysqli_connect_error());
}

?>



