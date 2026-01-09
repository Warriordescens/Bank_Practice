/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.bankexample.practice.controller;

import com.google.gson.Gson;
import com.mycompany.bankexample.practice.dao.CalamotBankDAO;
import com.mycompany.bankexample.practice.exceptions.BankException;
import com.mycompany.bankexample.practice.model.AnswerTO;
import com.mycompany.bankexample.practice.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
@WebServlet(name = "RegistreServlet", urlPatterns = {"/RegistreServlet"})
public class RegistreServlet extends HttpServlet {

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
        String status = "ok";
        String nif = request.getParameter("nif");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String pass1 = request.getParameter("pass1");
        String pass2 = request.getParameter("pass2");
        
        AnswerTO answer = new AnswerTO("", "");
        Gson gson = new Gson();
        try {
            if (nif != null && !validateNif(nif)) {
                throw new BankException("Nif incorrecto");
            } else {
                if (!pass1.equals(pass2)) {
                    answer.setStatus("ERROR");
                    answer.setMessage("les contrasenyes son diferents!!");
                } else {
                    User u = new User(nif, pass1, name, surname);
                    CalamotBankDAO.getInstance().insertUser(u);
                    answer.setStatus("OK");
                    answer.setMessage("Usuari registrat.");
                }
            }
        } catch(BankException | SQLException | ClassNotFoundException ex) {
            answer.setStatus("ERROR");
            answer.setMessage(ex.getMessage());
        }
        
//        request.setAttribute("status", status);
//        request.getRequestDispatcher("/Registre.jsp").forward(request, response);

        String answerJson = gson.toJson(answer);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(answerJson);
        out.flush();

        
    }
    
    private boolean validateNif(String nif) {
        Pattern REGEXP = Pattern.compile("[0-9]{8}[A-Z]");
        String DIGITO_CONTROL = "TRWAGMYFPDXBNJZSQVHLCKE";
        String[] INVALIDOS = new String[]{"00000000T", "00000001R", "99999999R"};
        return Arrays.binarySearch(INVALIDOS, nif) < 0 // <1>
                && REGEXP.matcher(nif).matches() // <2>
                && nif.charAt(8) == DIGITO_CONTROL.charAt(Integer.parseInt(nif.substring(0, 8)) % 23);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
