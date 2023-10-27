<?php

require_once "Conexion.php";

class Hora extends Conexion{
  private $accesoBD;
  public function __CONSTRUCT(){
    $this->accesoBD= parent::getConexion();
  }

  
  public function horasExtrasDiarias($fechaConsulta)
  {
    try {
      $consulta = $this->accesoBD->prepare("CALL generar_reporte_horas_extras_diarias(?)");
      $consulta->execute(array($fechaConsulta));
      
      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function horasExtrasSemanal($fechaInicio, $fechaFin)
  {
    try {
        $consulta = $this->accesoBD->prepare("CALL generar_reporte_horas_extras_semanales(?,?)");
        $consulta->execute(array($fechaInicio, $fechaFin));
        return $consulta->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
        die($e->getMessage());
    }
  }

  public function horasExtrasMensual($yearConsulta, $monthConsulta)
  {
    try {
      $consulta = $this->accesoBD->prepare("CALL generar_reporte_horas_extras_mensuales(?,?)");
      $consulta->execute(array($yearConsulta, $monthConsulta));
      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

}