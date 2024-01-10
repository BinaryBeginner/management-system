<?php
require_once('conexion_be.php');

// Obtener los datos del formulario de inicio de sesión
$usuario = $_POST['usuario'];
$contrasena = $_POST['contraseña'];

// Consulta SQL para verificar las credenciales
$sql = "SELECT * FROM administrador WHERE usuario = '$usuario' AND contraseña = '$contrasena'";
$resultado = mysqli_query($conexion, $sql);

// Verificar si se encontró un resultado
if (mysqli_num_rows($resultado) == 1) {
    // Las credenciales son válidas, el inicio de sesión es exitoso
    echo "Inicio de sesión exitoso";
    header("location: ../bienvenidos.php");
} else {
    // Las credenciales son inválidas, redirigir al index.php con el parámetro de error
    header("location: ../index.php?error=invalid_credentials");

}
?>
