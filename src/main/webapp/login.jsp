<%-- 
    Document   : login
    Created on : Dec 19, 2025, 3:28:56 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- [5, 6] -->
    <title>Calamot Bank | Iniciar Sesión</title>
    
    <!-- CSS de Bootstrap v5.3 vía CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous"> <!-- [2, 7] -->
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"> <!-- [8] -->
    
    <style>
        /* Estilos para mantener la estética de banca profesional */
        .form-signin {
            width: 100%;
            max-width: 400px;
            padding: 15px;
            margin: auto;
        }
        .bg-bank-login {
            background: linear-gradient(135deg, #1f4068, #162447); /* Basado en el estilo previo */
            min-height: 100vh;
        }
        .login-card {
            background-color: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body class="d-flex align-items-center py-4 bg-bank-login">

    <main class="form-signin login-card p-4 p-md-5">
        <!-- El formulario se enviaría a un LoginServlet para su validación en servidor -->
        <form action="Login" method="POST">
            <div class="text-center mb-4">
                <!-- Icono de banco (bank2) de la librería Bootstrap Icons -->
                <i class="bi bi-bank2 display-4 text-primary mb-2"></i>
                <h1 class="h3 mb-3 fw-bold">Acceso Clientes</h1>
                <p class="text-muted small">Calamot Bank</p>
            </div>

            <!-- Campo NIF con icono -->
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingNif" name="nif" placeholder="12345678X" required>
                <label for="floatingNif">
                    <i class="bi bi-credit-card-2-front me-2"></i>NIF:
                </label>
            </div>

            <!-- Campo Contraseña con icono -->
            <div class="form-floating mb-4">
                <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Contraseña" required>
                <label for="floatingPassword">
                    <i class="bi bi-lock me-2"></i>Contraseña:
                </label>
            </div>

            <button class="btn btn-primary w-100 py-3 fw-bold" type="submit">
                <i class="bi bi-box-arrow-in-right me-2"></i>Entrar Seguramente
            </button>
            
            <div class="mt-4 text-center">
                <p class="mb-0 small text-muted">¿No tienes cuenta?</p>
                <a href="Register.jsp" class="text-decoration-none fw-bold">Regístrate aquí</a>
            </div>
            
            <p class="mt-5 mb-3 text-muted text-center small">&copy; 2025 Calamot Bank</p>
        </form>
    </main>

    <!-- JS de Bootstrap (Bundle) antes de cerrar el body -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script> <!-- [2, 7] -->
</body>
</html>
