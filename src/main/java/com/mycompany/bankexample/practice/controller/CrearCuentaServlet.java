/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.bankexample.practice.controller;

import com.google.gson.Gson;
import com.mycompany.bankexample.practice.dao.CalamotBankDAO;
import com.mycompany.bankexample.practice.exceptions.BankException;
import com.mycompany.bankexample.practice.model.Account;
import com.mycompany.bankexample.practice.model.AnswerTO;
import com.mycompany.bankexample.practice.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author admin
 */
@WebServlet(name = "CrearCuentaServlet", urlPatterns = {"/CrearCuentaServlet"})
public class CrearCuentaServlet extends HttpServlet {

    
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int numCuenta = Integer.parseInt(request.getParameter("numCuenta"));
        String nombre = request.getParameter("nombreCuenta");
        double balance = Double.parseDouble(request.getParameter("balance"));
        
        AnswerTO answer = new AnswerTO("", "");
        Gson gson = new Gson();
        
        try {
            HttpSession session = request.getSession();
            User usuari = (User) session.getAttribute("usuari");

            Account a = new Account(numCuenta, nombre, balance);

            CalamotBankDAO.getInstance().CreateAccount(a, usuari);
            answer.setStatus("OK");
            answer.setMessage("Cuenta creada correctamente.");
            
        } catch (SQLException | ClassNotFoundException | BankException ex) {
            answer.setStatus("ERROR");
            answer.setMessage(ex.getMessage());
        }
        
        String answerJson = gson.toJson(answer);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(answerJson);
        out.flush();
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet para recoger datos de crear cuenta.";
    }// </editor-fold>

}
