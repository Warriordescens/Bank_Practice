<%-- 
    Document   : welcome
    Created on : Dec 19, 2025, 3:58:08 PM
    Author     : admin
--%>

<%@page import="com.mycompany.bankexample.practice.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User usuari = (User) session.getAttribute("usuari");
    %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- [4, 6] -->
    <title>Calamot Bank | Inicio</title>
    
    <!-- CSS de Bootstrap v5.3 vía CDN [7, 8] -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <!-- Bootstrap Icons [9] -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    
    <style>
        .hero-welcome {
            min-height: 80vh;
            background: linear-gradient(180deg, #162447 0%, #1f4068 100%);
            color: white;
            padding-top: 100px;
        }
        /* Ajuste para el texto grande del banco en el header */
        .navbar-brand-custom {
            font-size: 2rem; 
            font-weight: 800;
        }
    </style>
</head>
<body>

    <!-- Navbar fija en la parte superior -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top shadow">
    <!-- El contenedor usa 'position-relative' para que el centrado del título sea exacto -->
    <div class="container position-relative d-flex align-items-center">
        
        <!-- 1. Título del Banco: Centrado absoluto en la barra -->
        <!-- Se usa 'position-absolute', 'start-50' y 'translate-middle-x' para centrarlo respecto al contenedor [4] -->
        <a class="navbar-brand fw-bold position-absolute start-50 translate-middle-x m-0" href="#" style="font-size: 1.8rem;">
            <i class="bi bi-bank2 me-2"></i>Calamot Bank
        </a>

        <!-- 2. Botón Toggler (para visualización en móviles) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navOptions" aria-controls="navOptions" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- 3. Contenedor de Opciones: Pegado a la derecha -->
        <div class="collapse navbar-collapse" id="navOptions">
            <!-- La clase 'ms-auto' (margin-start: auto) empuja este elemento al final derecho del flexbox [7] -->
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle fs-5" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle me-1"></i> Opciones de Usuario
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow">
                        <li>
                            <a class="dropdown-item" href="CrearCuentaServlet">
                                <i class="bi bi-plus-circle me-2"></i>Crear cuenta
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="LogoutServlet">Cerrar Sesión</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

    <!-- Sección de Bienvenida (Hero) [1] -->
    <header class="hero-welcome d-flex align-items-center text-center">
        <div class="container">
            <h1 class="display-2 fw-bold mb-3">¡Bienvenido, <%= usuari.getName() %>!</h1>
            <p class="lead mb-5 fs-4">Gestione sus finanzas con la seguridad de Calamot Bank.</p>
        </div>
    </header>

    <!-- Sección de Acciones (Botón principal sigue presente) -->
    <section class="py-5 bg-light">
        <div class="container text-center">
            <div class="card shadow border-0 p-5 mx-auto" style="max-width: 600px;">
                <h3 class="mb-4">Acceso Rápido</h3>
                <a href="CrearCuentaServlet" class="btn btn-success btn-lg px-5 py-3 fw-bold">
                    <i class="bi bi-plus-circle-fill me-2"></i> Crear Cuenta del Banco
                </a>
                <p><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></p>
            </div>
        </div>
    </section>
    
    <footer class="py-4 border-top bg-white">
        <div class="container text-center">
            <span class="text-muted">&copy; 2025 Calamot Bank - Seguridad Garantizada</span>
        </div>
    </footer>

    <!-- JavaScript de Bootstrap (Indispensable para el desplegable) [3, 4, 7] -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>
