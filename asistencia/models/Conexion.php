<?php
// Esta clase permitirá a los modelos acceder y consumir los datos.
class Conexion{

  //Atributos
  private $host       = "localhost";        // Servidor
  private $port       = "3306";            // Puerto de comunicación BD
  private $database   = "SistemaAsistencia";  // Nombre BD
  private $charset    = "UTF8";          // Codificación (idioma)
  private $user       = "root";         // Usuario (raíz)
  private $password   = "";            // Contraseña

  // Atributo (instancia PDO) que almacena la conexión
  private $pdo;

  // Método 1: Acceder a la BD
  private function conectarServidor(){
    // Constructor:
    // new PDO("CADENA_CONEXION", "USER", "PASSWORD");
    $conexion = new PDO("mysql:host={$this->host};port={$this->port};dbname={$this->database};charset={$this->charset}",$this->user,$this->password);

    return $conexion;
  }

  // Método 2: Retorna el acceso
  public function getConexion(){
    try {
      // Pasaremos la conexión al atributo/objeto $pdo
      $this->pdo = $this->conectarServidor();

      // Controlar los errores (será controlado por los TRY-CATCH)
      $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO:: ERRMODE_EXCEPTION);

      // Retornamos la conexión al modelo que lo necesite
      return $this->pdo;
    } 
    catch (Exception $e) {
      die($e->getMessage());
    }
  }
  

}
