/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.bankexample.practice.dao;

import com.mycompany.bankexample.practice.exceptions.BankException;
import com.mycompany.bankexample.practice.model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author admin
 */
public class Calamot_Bank_dao {
    
    private static Calamot_Bank_dao instance;
    
    private Calamot_Bank_dao() {
    }
    
    public static Calamot_Bank_dao getInstance() {
        if (instance == null) {
            instance = new Calamot_Bank_dao();
        }
        return instance;
    }
    
     public boolean existUser(User u) throws SQLException, ClassNotFoundException { 
        Connection c = conectar();
        Statement st = c.createStatement();
        ResultSet rs = st.executeQuery("select * from user where nif = '" + u.getNif()+"';");
        boolean existe = rs.next();
        rs.close();
        st.close();
        desconectar(c);
        return existe;
    }
    
    public void insertUser(User u) throws SQLException, ClassNotFoundException, BankException {  
        if (existUser(u)){   
            throw new BankException("Ya existeix un usuari amb aquest nif");   
        }
        Connection c = conectar();
        try (PreparedStatement ps = c.prepareStatement("insert into user values (?, ?, ?, ?);")) { 
            ps.setString(1, u.getNif());
            ps.setString(2, u.getPass());
            ps.setString(3, u.getName());
            ps.setString(4, u.getSurname());
            ps.executeUpdate();
        }
        desconectar(c);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     private Connection conectar() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/calamot_bank";        //ponemos wildcare porque es con la base de datos que queremos hacer conexión
        String user = "root";
        String pass = "root";
        Connection c = DriverManager.getConnection(url, user, pass);
        return c;
    }
    
    private void desconectar(Connection c) throws SQLException {
        c.close();
    }
}