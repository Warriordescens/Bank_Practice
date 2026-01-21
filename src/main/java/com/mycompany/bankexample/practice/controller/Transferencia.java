/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.bankexample.practice.controller;

import com.google.gson.Gson;
import com.mycompany.bankexample.practice.dao.CalamotBankDAO;
import com.mycompany.bankexample.practice.exceptions.BankException;
import com.mycompany.bankexample.practice.model.AnswerTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
@WebServlet(name = "Transferencia", urlPatterns = {"/Transferencia"})
public class Transferencia extends HttpServlet {

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
        int origen = Integer.parseInt(request.getParameter("origen"));
        int desti = Integer.parseInt(request.getParameter("desti"));
        double importe = Double.parseDouble(request.getParameter("importe"));
        Gson gson = new Gson();
        AnswerTO answer = new AnswerTO("", "");
        try {
            double saldo = CalamotBankDAO.getInstance().selectSaldoById(origen);
            if (saldo < importe) {
                throw new BankException("No tens suficient diners per a fer la transferència demanada.");
            }
            CalamotBankDAO.getInstance().transfer(origen, desti, importe);
            answer.setStatus("OK");
            answer.setMessage("Transferència realitzada.");
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
        return "Servlet para hacer la transferencia en si.";
    }// </editor-fold>

}
