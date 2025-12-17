<%-- 
    Document   : Registre
    Created on : Dec 12, 2025, 3:19:22 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página de registre</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

        <style>
            .form-registration {
                width: 100%;
                max-width: 450px;
                padding: 15px;
                margin: auto;
            }
            .bg-bank {
                background-color: #f0f4f8; 
            }
        </style>
        
    </head>
    <body class="d-flex align-items-center py-4 bg-bank min-vh-100">
        
        <main class="form-registration p-4 p-md-5 bg-white shadow-lg rounded-3">

                <div class="text-center mb-4">
                    <i class="bi bi-person-vcard-fill display-4 text-success mb-2" aria-hidden="true"></i>
                    <h1 class="h3 mb-3 fw-normal">Registro Calamot Bank</h1>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="nifInput" name="nif" placeholder="NIF/DNI" maxlength="9" required>
                    <label for="nifInput"><i class="bi bi-credit-card-2-front me-2" aria-hidden="true"></i> NIF (DNI/NIE)</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="floatingName" name="nombre" placeholder="Nombre" maxlength="20" required>
                    <label for="name"><i class="bi bi-person me-2" aria-hidden="true"></i> Nombre</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="floatingSurname" name="apellidos" placeholder="Apellidos" maxlength="50" required>
                    <label for="surname"><i class="bi bi-people me-2" aria-hidden="true"></i> Apellidos</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" required minlength="4">
                    <label for="password"><i class="bi bi-lock me-2" aria-hidden="true"></i> Contraseña</label>
                </div>

                <div class="form-floating mb-4">
                    <input type="password" class="form-control" id="confirmPassword" name="confirm_password" placeholder="Confirmar Contraseña" required minlength="4">
                    <label for="confirmPassword"><i class="bi bi-check-circle me-2" aria-hidden="true"></i> Repetir Contraseña</label>
                </div>
            
                <button class="btn btn-success w-100 py-3 fw-bold" type="submit" id="btnRegistro">
                    <i class="bi bi-send-fill me-2" aria-hidden="true"></i> Registrarme en Calamot Bank
                </button>

                <div id="resposta"></div>
            
                <p class="mt-4 text-center">
                    <a href="index.html" class="text-secondary">Volver al inicio de sesión</a>
                </p>
                
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#btnRegistro').click(function() {
                   var nif = $('#nifInput').val();
                   var name = $('#floatingName').val();
                   var surname = $('#floatingSurname').val();
                   var pass1 = $('#password').val();
                   var pass2 = $('#confirmPassword').val();
                   
                   $.ajax({
                      type: 'POST',
                      data: {nif: nif, name: name, surname: surname, pass1: pass1, pass2: pass2},
                      dataType: "json",
                      url: 'RegistreServlet',
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
