<?php
session_start();


if (!isset($_SESSION['login']) || $_SESSION['login'] == false){
  header('Location: ../views/index.php');
}


$nombreusuario="";
if (isset($_SESSION['nombreusuario'])){
    $nombreusuario = $_SESSION['nombreusuario'];
}
?>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Registro de Usuario</title>
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link rel="shortcut icon" href="../images/Logo.svg">
        
        
        <!-- Bootstrap CSS v5.2.1 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

        <!-- ÍCONOS FONTAWESOME -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  

        <!-- Lightbox CSS 
        <link rel="stylesheet" href="../dist/lightbox2/src/css/lightbox.css"> -->
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="../views/administracion.php">Otro Espacio</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
            <li class="nav-item"><span class="nav-link">Bienvenido(a), <?php echo $nombreusuario; ?></span></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="../controllers/usuario.controller.php?operacion=finalizar">Cerrar Sesión</a></li>

                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                    <div class="nav">
                            <div class="sb-sidenav-menu-heading">Panel de Control</div>
                            <a class="nav-link" href="../views/administracion.php">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                ADMINISTRADOR
                            </a>
                            <div class="sb-sidenav-menu-heading">Interfaz</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Registros
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="../views/formulario_colaboradores.php">Formulario Colaboradores</a>
                                    <a class="nav-link" href="../views/registro_usuario.php">Registro Usuarios</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                Reportes
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link" href="../views/horasExtras.php">Horas Extras</a>
                                    <a class="nav-link" href="../views/ausencias.php">Ausencias</a>
                                </nav>
                            </div>

                            <div class="sb-sidenav-menu-heading">Addons</div>
                            <a class="nav-link" href="../views/charts.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                Charts
                            </a>
                            <a class="nav-link" href="../views/tables.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Tables
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Start Bootstrap
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Registro de Usuarios</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="../views/administracion.php">Administración</a></li>
                            <li class="breadcrumb-item active">Registro de Usuarios</li>
                        </ol>
                        <div class="container mt-3">
                            <div class="card">
                                <div class="card-header bg-info text-light">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <strong>LISTADO DE USUARIOS</strong>
                                        </div>
                                        <div class="col-md-6 text-end">
                                            <button class="btn btn-success btn-sm" id="abrir-modal-usuario" data-bs-toggle="modal" data-bs-target="#modal-registro-usuarios"><i class="fa-solid fa-folder-plus"></i> Registrar Usuario</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-sm table-striped" id="tabla-usuarios">
                                            <colgroup> <!-- colgroup: Permite ordenar las tablas -->
                                                <col width = "3%">
                                                <col width = "19%">
                                                <col width = "19%">
                                                <col width = "19%">
                                                <col width = "19%">
                                                <col width = "19%">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Usuario</th>
                                                    <th>Apellidos</th>
                                                    <th>Nombres</th>
                                                    <th>Fecha Registro</th>
                                                    <th>Eliminar/Editar</th>
                                                </tr>
                                            </thead>
                                            <!-- DATOS DE PRUEBA -->
                                            <tbody>
                                            </tbody> <!-- FIN DE DATOS PRUEBA-->
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- FIN DEL CONTAINER -->

                        <div class="modal fade" id="modal-registro-usuarios" tabindex="-1" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header bg-secondary text-light">
                                        <h5 class="modal-title" id="modal-titulo">Registrar Usuarios</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="" id="formulario-registro" autocomplete="off">
                                            <div class="mb-3">
                                                <label for="nombreusuario" class="form-label">Nombre Usuario</label>
                                                <input type="text" class="form-control form-control-sm" id="nombreusuario">
                                            </div>
                                            <div class="mb-3">
                                                <label for="claveacceso" class="form-label">Contraseña</label>
                                                <input type="password" class="form-control form-control-sm" id="claveacceso">
                                            </div>
                                            <div class="mb-3">
                                                <label for="nombres" class="form-label">Nombres</label>
                                                <input type="text" class="form-control form-control-sm" id="nombres">
                                            </div>
                                            <div class="mb-3">
                                                <label for="apellidos" class="form-label">Apellidos</label>
                                                <input type="text" class="form-control form-control-sm" id="apellidos">
                                            </div>
            
                                            <!--<div class="mb-3">
                                                <label for="fecharegistro" class="form-label">Fecha de registro:</label>
                                                <input type="datetime-local" class="form-control form-control-sm" id="fecharegistro">
                                            </div>-->
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cerrar</button>
                                        <button type="button" class="btn btn-primary btn-sm" id="guardar-usuario">Guardar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>

        </script>
        <!-- Bootstrap JavaScript Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous">
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
        integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous">
        </script>

        <!-- jQuery-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <!-- SweetAlert -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <!--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>-->
        <script src="../js/scripts.js"></script>

        <script>
            $(document).ready(function (){

                // Variables de ámbito general (accesibles)
                let datosNuevos           = true;
                let idusuarioactualizar     = -1; // Valor improbable (NO TIENE DATOS)

                function mostrarUsuarios(){
                    $.ajax({
                    url: '../controllers/usuario.controller.php',
                    type: 'POST',
                    data: {operacion: 'listar'},
                    dataType: 'text',
                    success: function(result){
                        $("#tabla-usuarios tbody").html(result);
                    }
                    });
                }

                // Registrar un curso
                function registrarUsuario(){
                    // Pendiente validación de los cursos
                    if(confirm("¿Está seguro de salvar los datos?")){

                    // Crear un objeto conteniendo los datos a guardar
                    let datos = {
                        operacion     : 'registrar',
                        idusuario       : idusuarioactualizar,
                        nombreusuario   : $("#nombreusuario").val(),
                        claveacceso   : $("#claveacceso").val(),
                        apellidos  : $("#apellidos").val(),
                        nombres   : $("#nombres").val()
                    };

                    if (!datosNuevos){
                        datos["operacion"] = "actualizar";
                    }

                    $.ajax({
                        url: '../controllers/usuario.controller.php',
                        type: 'POST',
                        data: datos,
                        success: function(result){
                        if (result == ""){
                            // Reiniciar el formulario
                            $("#formulario-registro")[0].reset();
                            
                            // Actualizar la tabla
                            mostrarUsuarios();

                            // Cerrar el modal
                            $("#modal-registro-usuarios").modal('hide');
                        }
                        }
                    });
                    }
                }

                function abrirModal(){
                    datosNuevos = true; // Variable tipo BANDERA
                    $("#modal-titulo").html("Registro de Usuarios");
                    $("#formulario-registro")[0].reset();
                }


                //Evento
                $("#guardar-usuario").click(registrarUsuario);
                $("#abrir-modal-usuario").click(abrirModal);  

                // Al pulsar click sobre el botón ROJO, se elimine el registro
                    $("#tabla-usuarios tbody").on("click", ".eliminar", function(){
                        const idusuarioEliminar = $(this).data("idusuario");
                        if (confirm("¿Está seguro de proceder?")){
                            $.ajax({
                                url: '../controllers/usuario.controller.php',
                                type: 'POST',
                                data: {
                                    operacion: 'eliminar',
                                    idusuario: idusuarioEliminar // Corregir el nombre de la variable aquí
                                },
                                success: function(result){
                                    if(result == ""){
                                        mostrarUsuarios();
                                    }
                                }
                            });
                        }
                    });


    
                    // DETECTAR clic en EDITAR (asíncrono)
                    $("#tabla-usuarios tbody").on("click", ".editar", function(){
                        const idusuarioeditar = $(this).data("idusuario");
                        $.ajax({
                            url: '../controllers/usuario.controller.php',
                            type: 'POST',
                            data: {
                                operacion : 'obtenerusuario',
                                idusuario   : idusuarioeditar
                            },
                            dataType: 'JSON',
                            success: function(result){
                                console.log(result);

                                // Configurar BANDERA
                                datosNuevos = false;
                    
                                //Retornamos los valores a los controles de FORM
                                idusuarioactualizar = result["idusuario"];
                                $("#nombreusuario").val(result["nombreusuario"]);
                                $("#claveacceso").val(result["claveacceso"]);
                                $("#apellidos").val(result["apellidos"]);
                                $("#nombres").val(result["nombres"]);

                                // CAMBIAR TÍTULO DE MODAL
                                $("#modal-titulo").html("Actualizar datos de Usuario");

                                // Ponemos al modal en pantalla
                                $("#modal-registro-usuarios").modal("show");
                            }
                        });
                    });
                    mostrarUsuarios();

            });
        </script>
    </body>
</html>
