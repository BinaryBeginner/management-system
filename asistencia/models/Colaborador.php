<?php

require_once "Conexion.php";

class Colaboradores extends Conexion{
  private $accesoBD;

  public function __CONSTRUCT(){
    $this->accesoBD= parent::getConexion();
  }

  public function getColaborador($numerodocumento){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_obtener_datos_colaborador(?)");
      $consulta->execute(array($numerodocumento));
      //Retornar el registro encontrado
      return $consulta->fetch(PDO::FETCH_ASSOC);
    } 
    catch (Exception $e) {
      die($e->getMessage());  
    }
   }

   public function obtenerHistorial(){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_obtener_historial()");
      $consulta->execute();

      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    } 
    catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function registrarHoraEntrada($numerodocumento){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_registrar_hora_entrada(?)");
      $consulta->execute(array($numerodocumento));
      // Retornar el registro encontrado
      return $consulta->fetch(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function registrarHoraSalida($numerodocumento){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_registrar_salida(?)");
      $consulta->execute(array($numerodocumento));
      // Retornar el registro encontrado
      return $consulta->fetch(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function registrarColaborador($datos = []){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_insertar_colaboradores(?,?,?,?,?,?,?,?,?)");
      $consulta->execute(
        array(
          $datos['apellidos'],
          $datos['nombres'],
          $datos['tipodocumento'],
          $datos['numerodocumento'],
          $datos['email'],
          $datos['direccion'],
          $datos['rol'],
          $datos['telefono'],
          $datos['foto']
        )
      );
    } 
    catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function listarColaborador(){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_listar_colaboradores()");
      $consulta->execute();

      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    } 
    catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerColaborador($idcolaborador = 0){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_obtener_foto(?)");
      $consulta->execute(array($idcolaborador));
      $registro = $consulta->fetch();

      return $registro;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function eliminarColaborador($idcolaborador = 0){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_eliminar_colaborador(?)");
      $consulta->execute(array($idcolaborador));

      return true;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function recuperarColaborador($idcolaborador = 0){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_colaboradores_recuperar_id(?)");
      $consulta->execute(array($idcolaborador));
      //Retornar el registro encontrado
      return $consulta->fetch(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());  
    }
   }
   

   public function modificarColaborador($datos = []){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_modificar_colaboradores(?,?,?,?,?,?,?,?,?,?)");
      
      $consulta->execute(
        array(
          $datos['idcolaborador'],
          $datos['apellidos'],
          $datos['nombres'],
          $datos['tipodocumento'],
          $datos['numerodocumento'],
          $datos['email'],
          $datos['direccion'],
          $datos['rol'],
          $datos['telefono'],
          $datos['foto']
        )
      );
    } catch (Exception $e) {
      die($e->getMessage());
    }
   }
  
  
}