<?php

// Tabla
//$claveusuario = "Agencia123#";
$claveusuario = "Yorghet123#";

/*$claveMD5 = md5($claveusuario);
$claveSHA = sha1($claveusuario);*/
$claveHAS = password_hash($claveusuario, PASSWORD_BCRYPT);

// Clave acceso (LOGIN)
$claveAcceso =  "Yorghet123#";

//var_dump($claveHAS);

// Validar la clave HASH
if (password_verify($claveAcceso, $claveHAS)){
  echo $claveHAS;
}