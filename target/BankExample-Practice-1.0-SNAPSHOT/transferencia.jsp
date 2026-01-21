<%-- 
    Document   : transferencia
    Created on : Jan 14, 2026, 6:59:23 PM
    Author     : admin
--%>

<%@page import="com.mycompany.bankexample.practice.model.Account"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Transferencia | Calamot Bank</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    
    <style>
        body {
            background-color: #f0f4f8;
            padding-top: 90px;
        }
        .navbar-brand-custom {
            font-size: 1.8rem;
            font-weight: 800;
        }
        .account-card {
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
            border: 2px solid transparent;
        }
        .account-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            border-color: #198754; 
        }
        .account-input {
            display: none;
        }
        .account-input:checked + .account-card {
            border-color: #198754;
            background-color: #f1fcf6;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top shadow">
        <div class="container position-relative d-flex align-items-center">
            <a class="navbar-brand navbar-brand-custom position-absolute start-50 translate-middle-x m-0" href="welcome.jsp">
                <i class="bi bi-bank2 me-2"></i>Calamot Bank
            </a>
            <div class="collapse navbar-collapse" id="navOptions">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i> Mi Perfil
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow">
                            <li><a class="dropdown-item" href="welcome.jsp">Panel Principal</a></li>
                            <li>
                                <a class="dropdown-item" href="CrearCuenta.jsp">
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

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                
                <% 
                    List<Account> accounts = (List<Account>) request.getAttribute("accounts");
                    
                    if (accounts == null || accounts.isEmpty()) { 
                %>
                    <div class="transfer-card p-5 text-center">
                        <i class="bi bi-exclamation-octagon-fill text-danger display-1 mb-4"></i>
                        <h2 class="fw-bold text-dark">No tienes cuentas disponibles</h2>
                        <p class="text-muted fs-5 mb-5">Para realizar una transferencia, primero debes disponer de al menos una cuenta bancaria activa con saldo.</p>
                        
                        <div class="d-grid gap-3">
                            <a href="CrearCuenta.jsp" class="btn btn-success btn-lg py-3 fw-bold shadow-sm">
                                <i class="bi bi-plus-circle me-2"></i>Crear cuenta 
                            </a>
                        </div>
                    </div>

                <% } else { %>

                    <div class="text-center mb-4">
                        <h2 class="fw-bold">Nueva Transferencia</h2>
                        <p class="text-muted">Seleccione la cuenta de origen.</p>
                    </div>

                    <div class="transfer-card p-4 p-md-5">
                        
                            <div class="mb-4">
                                <label for="cuentaOrigen" class="form-label fw-bold">Cuenta de Origen</label>
                                <select class="form-select form-select-lg" id="origen" name="cuentaOrigen" required>
                                    <option value="" selected disabled>Elija una cuenta...</option>
                                    <% for (Account a : accounts) {
                                    %>
                                    <option value="<%= a.getIdaccount()%>"><%= a.getIdaccount()%> - <%= a.getName()%> : (<%= a.getBalance() %> €)</option>
                                    <% } %>
                                </select>
                            </div>

                            <div>
                                <button type="button" class="btn btn-primary w-100 py-3 fw-bold shadow-sm" id="seleccionarOrigen">
                                    Continuar <i class="bi bi-chevron-right ms-2"></i> 
                                </button>
                            </div>
                            <div id="contenidorDinamic" class="d-none mb-3" >

                            </div>
                                <br/>
                            <div>
                                <button type="button" class="btn btn-success d-none" id="transfButton">
                                    Fer Transferencia 
                                </button>
                            </div>
                            <div id="missatgeResultat" class="alert mt-3 d-none" role="alert" ></div>
                    </div>
                <% } %>
                
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(function() {
                        $('#seleccionarOrigen').click(function() {
                           var origen = $('#origen').val();

                           $.ajax({
                              type: 'POST',
                              data: {origen: origen},
                              dataType: "json",
                              url: 'CuentaTransfer',
                              success: function(llista) {
                                  var $div =  $('#contenidorDinamic');
                                  $div.empty().removeClass('d-none');
                                  
                                  var html = '<div class="mb-3"><label class="form-label text-secondary">Destí:</label>';
                                  html+= '<select class="form-select" id="desti">';
                                  $.each(llista, function(i, account) {
                                      html += '<option value="' + account.idaccount + '">' + account.idaccount + "- " + account.name + '</option>';
                                  });
                                  html += '</select></div>';
                                  
                                  html += '<div class="mb-3"><label class="form-label text-secondary">Import</label>';
                                  html += '<input type="number" class="form-control" id="import" min="1" value="1"></div>';
                                  
                                  $div.append(html);
                                  $('#transfButton').removeClass('d-none');
                              },
                              error: function(jqXHR, textStatus, error) {
                                  console.error("Error en les dades:", error);
                              }
                           });
                        });
                        
                        $('#transfButton').click(function() {
                           var origen = $('#origen').val();
                           var desti = $('#desti').val();
                           var importe = $('#import').val();

                           $.ajax({
                              type: 'POST',
                              data: {origen: origen, desti: desti, importe: importe},
                              dataType: "json",
                              url: 'Transferencia',
                              success: function(resposta) {
                                  if (resposta.status === "OK") {
                                      $('#missatgeResultat')
                                    .removeClass('d-none alert-danger')
                                    .addClass('alert-success')
                                    .text(resposta.message); // Accedim a la propietat de l'objecte JSON
                                  } else {
                                      $('#missatgeResultat')
                                    .removeClass('d-none alert-success')
                                    .addClass('alert-danger')
                                    .text(resposta.message); // Accedim a la propietat de l'objecte JSON
                                  }
                                  
                              },
                              error: function(jqXHR, textStatus, error) {
                                  console.error("Error en les dades:", error);
                              }
                           });
                        });
                        
                    });
                </script>
                
                <div class="d-grid gap-3">
                    <a href="welcome.jsp" class="btn btn-outline-secondary btn-lg py-3 fw-bold">
                        <i class="bi bi-arrow-left me-2"></i>Volver al Panel Principal
                    </a>
                </div>

            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>
