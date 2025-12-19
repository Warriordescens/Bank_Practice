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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagina inici</title>
    </head>
    <body>
        <h1>Hola <%= usuari.getName() %></h1>
    </body>
</html>
