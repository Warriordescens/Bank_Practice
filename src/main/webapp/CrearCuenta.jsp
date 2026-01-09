<%-- 
    Document   : CrearCuenta
    Created on : Jan 9, 2026, 3:25:19 PM
    Author     : admin
--%>

<%@page import="com.mycompany.bankexample.practice.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <!-- Metaetiqueta obligatoria para diseño responsivo [5, 6] -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Calamot Bank | Crear cuenta</title>
    
    <!-- CSS de Bootstrap v5.3 via CDN [1, 2] -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <!-- Estilos de Bootstrap Icons [4, 7] -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #f0f4f8, #c8d3e6);
            min-height: 100vh;
        }
        .navbar-brand-custom {
            font-size: 2rem;
            font-weight: 800;
        }
        .form-card {
            max-width: 500px;
            margin: 120px auto 50px; /* Margen superior para no chocar con la navbar fija */
            background: #fff;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

    <!-- Header con navegación (Navbar) [8] -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top shadow">
        <div class="container position-relative d-flex align-items-center">
            <!-- Título centrado -->
            <a class="navbar-brand navbar-brand-custom position-absolute start-50 translate-middle-x m-0" href="welcome.jsp">
                <i class="bi bi-bank2 me-2"></i>Calamot Bank
            </a>

            <!-- Menú a la derecha [9, 10] -->
            <div class="collapse navbar-collapse" id="navOptions">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle fs-5" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i> Mi Perfil
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow">
                            <li><a class="dropdown-item" href="welcome.jsp">Panel Principal</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="LogoutServlet">Cerrar Sesión</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Contenedor del Formulario -->
    <main class="container">
        <div class="form-card p-4 p-md-5">
            <div class="text-center mb-4">
                <i class="bi bi-plus-square-fill display-4 text-success mb-2"></i>
                <h2 class="fw-bold">Crear Nueva Cuenta</h2>
                <p class="text-muted small">Complete los datos para registrar su cuenta bancaria.</p>
            </div>

            <!-- El formulario envía los datos al servlet para procesar el registro [11] -->
                
                <!-- Número de Cuenta (Máximo 10 caracteres como solicitaste) -->
                <div class="mb-3">
                    <label for="numCuenta" class="form-label fw-semibold">Número de Cuenta</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-123"></i></span> <!-- Icono 123 [12] -->
                        <input type="text" class="form-control" id="numCuenta" name="numCuenta" 
                               maxlength="10" placeholder="Ej: 1234567890" required>
                    </div>
                    <div class="form-text">Máximo 10 caracteres alfanuméricos.</div>
                </div>

                <!-- Nombre de la Cuenta -->
                <div class="mb-3">
                    <label for="nombreCuenta" class="form-label fw-semibold">Nombre de la Cuenta</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-tag-fill"></i></span> <!-- Icono tag [13] -->
                        <input type="text" class="form-control" id="nombreCuenta" name="nombreCuenta" 
                               placeholder="Ej: Ahorros Personales" required>
                    </div>
                </div>

                <!-- Balance inicial -->
                <div class="mb-4">
                    <label for="balance" class="form-label fw-semibold">Saldo Inicial</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-cash-coin"></i></span> <!-- Icono cash-coin [14] -->
                        <input type="number" step="0.01" class="form-control" id="balance" name="balance" 
                               placeholder="0.00" required>
                        <span class="input-group-text">€</span>
                    </div>
                </div>
                
                <div id="resposta"></div>

                <button id="btnCrear" type="submit" class="btn btn-primary w-100 py-3 fw-bold shadow-sm">
                    <i class="bi bi-check-circle-fill me-2"></i> Guardar Cuenta
                </button>
                
                <div class="text-center mt-3">
                    <a href="welcome.jsp" class="text-secondary text-decoration-none small">Cancelar y volver</a>
                </div>
        </div>
    </main>

    <!-- JavaScript de Bootstrap (incluye Popper para el dropdown) [1, 10] -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#btnCrear').click(function() {
                   var numCuenta = $('#numCuenta').val();
                   var nombreCuenta = $('#nombreCuenta').val();
                   var balance = $('#balance').val();
                   
                   $.ajax({
                      type: 'POST',
                      data: {numCuenta: numCuenta, nombreCuenta: nombreCuenta, balance: balance},
                      dataType: "json",
                      url: 'CrearCuentaServlet',
                      success: function(result) {
                          $('#resposta').text(result.message);
                          if (result.status === "OK") {
                              $('#resposta').css('color', 'green');
                          } else {
                              $('#resposta').css('color', 'red');
                          }
                      },
                      error: function(jqXHR, textStatus, errorThrown) {
                          console.log(textStatus);
                      }
                   });
                });
            });
        </script>
    
</body>
</html>