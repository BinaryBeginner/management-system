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
        <title>Registro Colaboradores - Otro Espacio</title>
        <link href="../css/styles.css" rel="stylesheet" />
        <!-- <link href="../css/formulario.css" rel="stylesheet" /> -->
        <!-- Para colocar ícono a la pestaña de página web -->
        <link rel="shortcut icon" href="../images/Logo.svg">
        <!-- <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script> -->
        
        <!-- Bootstrap CSS v5.2.1 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

        <!-- ÍCONOS FONTAWESOME -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  

        <!-- Lightbox CSS -->
        <link rel="stylesheet" href="../dist/lightbox2/src/css/lightbox.css">

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
                        <h1 class="mt-4">Registro Colaboradores</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="../views/administracion.php">Administración</a></li>
                            <li class="breadcrumb-item active">Formulario Registro Colaboradores</li>
                        </ol>
                        <div class="container mt-3">
                            <div class="card">
                                <div class="card-header bg-primary text-light">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <strong>LISTA DE COLABORADORES</strong>
                                        </div>
                                        <div class="col-md-6 text-end">
                                            <button class="btn btn-success btn-sm" id="abrir-modal" data-bs-toggle="modal" data-bs-target="#modal-colaborador"><i class="fa-solid fa-folder-plus"></i> FORMULARIO COLABORADOR</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-sm table-striped" id="tabla-colaborador">
                                            <colgroup>
                                                <col width="10%">
                                                <col width="10%">
                                                <col width="10%">
                                                <col width="10%">
                                                <col width="10%">
                                                <col width="10%">
                                                <col width="10%">
                                                <col width="10%">
                                                <col width="10%">
                                                <col width="10%">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Apellidos</th>
                                                    <th>Nombres</th>
                                                    <th>Tipo</th>
                                                    <th>Documento</th>
                                                    <th>Correo</th>
                                                    <th>Dirección</th>
                                                    <th>Rol</th>
                                                    <th>Télefono</th>
                                                    <th>Operaciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal Body -->
                            <!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
                            <div class="modal fade" id="modal-colaborador" tabindex="-1" role="dialog" aria-labelledby="modalTitleId"       aria-hidden="false">
                                <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header bg-secondary text-light">
                                            <h5 class="modal-title" id="modal-titulo">COLABORADORES</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <!-- Da capacidad de recibir binarios al formulario: enctype="multipart/form-data"-->
                                            <form action="" id="formulario-colaboradores" autocomplete="off" enctype="multipart/form-data">
                                                <div class="row">
                                                    <!-- CAMPO APELLIDOS -->
                                                    <div class="mb-3 col-md-6">
                                                        <label for="apellidos" class="form-label">Apellidos</label>
                                                        <input type="text" class="form-control form-control-sm" id="apellidos">
                                                    </div>
                                                    <!-- CAMPO NOMBRES -->
                                                    <div class="mb-3 col-md-6">
                                                        <label for="nombres" class="form-label">Nombres</label>
                                                        <input type="text" class="form-control form-control-sm" id="nombres">
                                                    </div>
                                                </div>
                                                <!-- CAMPO TIPO DOCUMENTO -->
                                                <div class="row">
                                                    <div class="mb-3 col-md-6">
                                                        <label for="tipodocumento" class="form-label">Tipo Documento</label>
                                                        <select class="form-select form-select-sm" id="tipodocumento">
                                                            <option value="">Seleccione</option>
                                                            <option value="DNI">DNI</option>
                                                            <option value="Carnet de Extranjería">Carnet de Extranjería</option>
                                                            <option value="Pasaporte">Pasaporte</option>
                                                        </select>
                                                    </div>
                                                    <!-- CAMPO NÚMERO DOCUMENTO-->
                                                    <div class="mb-3 col-md-6">
                                                        <label for="numerodocumento" class="form-label">Número Documento</label>
                                                        <input type="text" class="form-control form-control-sm" id="numerodocumento">
                                                    </div>
                                                </div>
                                                <!-- CAMPO EMAIL -->
                                                <div class="row">
                                                    <div class="mb-3 col-md-6">
                                                        <label for="email" class="form-label">Email</label>
                                                        <input type="email" class="form-control form-control-sm" id="email">
                                                    </div>
                                                    <!-- CAMPO DIRECCION -->
                                                    <div class="mb-3 col-md-6">
                                                        <label for="direccion" class="form-label">Dirección</label>
                                                        <input type="text" class="form-control form-control-sm" id="direccion">
                                                    </div>
                                                </div>
                                                <!-- CAMPO ROL -->
                                                <div class="row">
                                                    <div class="mb-3 col-md-6">
                                                        <label for="rol" class="form-label">Rol</label>
                                                        <select class="form-select form-select-sm" id="rol">
                                                            <option value="">Seleccione</option>
                                                            <option value="Diseñadores">Diseñadores</option>
                                                            <option value="Desarrolladores de Software">Desarrolladores de Software</option>
                                                            <option value="Edición de Video y Fotografía">Edición de Video y Fotografía</option>
                                                        </select>
                                                    </div>
                                                    <!-- CAMPO TELEFONO -->
                                                    <div class="mb-3 col-md-6">
                                                        <label for="telefono" class="form-label">Télefono</label>
                                                        <input type="tel" class="form-control form-control-sm" id="telefono">
                                                    </div>
                                                </div>
                                                <!-- CAMPO FOTO -->
                                                <div class="mb-3">
                                                    <label for="foto" class="form-label">Fotografía</label>
                                                    <!-- Atributo que impida enviar cualquier otro archivo que no sea .jpg = accept -->
                                                    <input type="file" accept=".jpg" class="form-control form-control-md" id="foto">
                                                </div>

                                            </form>
                                        </div> <!-- FIN DE LA ZONA MODAL (DATOS E INPUT FORMULARIOS) -->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-outline-danger btn-sm" data-bs-dismiss="modal"><i class="fa-solid fa-circle-xmark"></i> Cerrar</button>
                                            <button type="button" class="btn btn-outline-success btn-sm" id="guardar-colaborador"><i class="fa-solid fa-floppy-disk"></i> Guardar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- FIN DE LA ZONA CONTAINER -->
                    </div> <!-- FIN DE LA ZONA CONTAINER FLUID -->
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

        <!-- Lightbox JS -->
        <script src="../dist/lightbox2/src/js/lightbox.js"></script>

        
        <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
        <script src="../js/scripts.js"></script>

        <script>
            $(document).ready(function(){
                 // Variables de ámbito general (accesibles)
                let datosNuevos           = true;
                let idcolaboradoractualizar     = -1; // Valor improbable (NO TIENE DATOS)

                // LISTAR Colaboradores
                function mostrarColaboradores(){
                    $.ajax({
                        url: '../controllers/colaborador.controller.php',
                        type: 'POST',
                        data: { operacion: 'listar'},
                        dataType: 'text',
                        success: function(result){
                            $("#tabla-colaborador tbody").html(result);
                        }
                    });
                }
                mostrarColaboradores();
                
                function registrarColaborador(){

                    // Enviaremos los datos dentro de un objeto 
                    var formData = new FormData();
                    // .val() cuando se trabjaa con input
                    formData.append("operacion", "registrar");
                    formData.append("apellidos", $("#apellidos").val());
                    formData.append("nombres", $("#nombres").val());
                    formData.append("tipodocumento", $("#tipodocumento").val());
                    formData.append("numerodocumento", $("#numerodocumento").val());
                    formData.append("email", $("#email").val());
                    formData.append("direccion", $("#direccion").val());
                    formData.append("rol", $("#rol").val());
                    formData.append("telefono", $("#telefono").val());
                    formData.append("foto", $("#foto")[0].files[0]);

                    $.ajax({
                        url: '../controllers/colaborador.controller.php',
                        type: 'POST',
                        data: formData,
                        contentType: false, // Porque se desactiva estos procesos!?, eso sucede cuando se usa un array
                        processData: false,
                        // Memoria temporal
                        cache: false,
                        success: function(){
                            $("#formulario-colaboradores")[0].reset();
                            $("#modal-colaborador").modal("hide");
                            //alert("Guardado correctamente");
                            mostrarColaboradores();
                        }
                    });
                }

                function abrirModal(){
                    /* Variables tipo bandera: Son útiles para controlar el flujo del programa y para tomar decisiones basadas en el estado de una 
                    condición o evento.*/
                    datosNuevos = true; // Variable tipo BANDERA
                    $("#modal-titulo").html("Registro de Colaboradores");
                    $("#formulario-colaboradores")[0].reset();
                }
                //Evento
                $("#guardar-colaborador").click(preguntarRegistro);
                $("#abrir-modal").click(abrirModal);

                function preguntarRegistro(){
                    Swal.fire({
                        icon: 'question',
                        title: 'Matrículas',
                        text: '¿Está seguro de registrar al colaborador?',
                        confirmButtonText: 'Aceptar',
                        confirmButtonColor: '#66C744',
                        showCancelButton: true,
                        cancelButtonText: 'Cancelar',
                        cancelButtonColor: '#EA4947'
                    }).then((result) => {
                        // Identificando la acción del usuario
                        if (result.isConfirmed){
                            //console.log("Guardando datos...");
                            registrarColaborador();
                        }
                    });
                }

                $("#guardar-colaborador").click(preguntarRegistro);

                // Botón Eliminar
                $("#tabla-colaborador tbody").on("click",".eliminar", function(){
                    const idcolaboradorEliminar = $(this).data("idcolaborador");
                    Swal.fire({
                        title: "¿Está seguro de proceder?",
                        text: "Eliminará de forma permanente al colaborador...",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#3085de",
                        cancelButtonColor: "#d33",
                        confirmButtonText: "Eliminar"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $.ajax({
                                url: '../controllers/colaborador.controller.php',
                                type: 'POST',
                                data: {
                                    operacion : 'eliminar',
                                    idcolaborador: idcolaboradorEliminar
                                },
                                success: function(result){
                                    if(result == ""){
                                        mostrarColaboradores();
                                    }
                                }
                            });
                        }
                    });
                });

                $("#tabla-colaborador tbody").on("click", ".editar", function(){
                    const idcolaboradorEditar = $(this).data('idcolaborador');
                    $.ajax({
                        url: '../controllers/colaborador.controller.php',
                        type: 'POST',
                        data: {
                        operacion : 'obtener',
                        idcolaborador : idcolaboradorEditar
                        },
                        dataType: 'JSON',
                        success: function(result){
                            console.log(result);
                            // Configurar BANDERA
                            datosNuevos = false;
                            // Aquí se establecen los valores de los campos del formulario con los datos obtenidos del colaborador
                            $("#apellidos").val(result['apellidos']);
                            $("#nombres").val(result['nombres']);
                            $("#tipodocumento").val(result['tipodocumento']);
                            $("#numerodocumento").val(result['numerodocumento']);
                            $("#email").val(result['email']);
                            $("#direccion").val(result['direccion']);
                            $("#rol").val(result['rol']);
                            $("#telefono").val(result['telefono']);
                            $("foto").val(result['foto']);
                            
                            $("#modal-titulo").html("Actualizar datos de colaborador");

                            // Ponemos al modal en pantalla
                            $("#modal-colaborador").modal("show");
                        }
                    });
                });


                

            });
        </script>
    </body>
</html>