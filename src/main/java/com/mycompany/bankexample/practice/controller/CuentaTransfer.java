/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.bankexample.practice.controller;

import com.google.gson.Gson;
import com.mycompany.bankexample.practice.dao.CalamotBankDAO;
import com.mycompany.bankexample.practice.model.Account;
import com.mycompany.bankexample.practice.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
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
@WebServlet(name = "CuentaTransfer", urlPatterns = {"/CuentaTransfer"})
public class CuentaTransfer extends HttpServlet {

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
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("usuari");
        List<Account> accounts;
        if (u != null) {
            try {
                accounts = CalamotBankDAO.getInstance().getAccountsWithBalance(u);
                request.setAttribute("accounts", accounts);
            } catch (SQLException | ClassNotFoundException ex) {
                Logger.getLogger(CuentaTransfer.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        request.getRequestDispatcher("/transferencia.jsp").forward(request, response);
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
        int id = Integer.parseInt(request.getParameter("origen"));
        Gson gson = new Gson();
        String answerJson = "";
        try {
            List<Account> accounts = CalamotBankDAO.getInstance().selectAccountsWithoutOne(id);
            answerJson = gson.toJson(accounts);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CuentaTransfer.class.getName()).log(Level.SEVERE, null, ex);
        }
        
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
        return "Servlet para consultar cuentas para hacer la transferencia.";
    }// </editor-fold>

}
