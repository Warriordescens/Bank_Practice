/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.bankexample.practice.dao;

import com.mycompany.bankexample.practice.exceptions.BankException;
import com.mycompany.bankexample.practice.model.Account;
import com.mycompany.bankexample.practice.model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class CalamotBankDAO {
    
    private static CalamotBankDAO instance;
    
    private CalamotBankDAO() {
    }
    
    public static CalamotBankDAO getInstance() {
        if (instance == null) {
            instance = new CalamotBankDAO();
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
    
    public boolean existAccount(Account a) throws SQLException, ClassNotFoundException { 
        Connection c = conectar();
        Statement st = c.createStatement();
        ResultSet rs = st.executeQuery("select * from account where idaccount = '" + a.getIdaccount()+"';");
        boolean existe = rs.next();
        rs.close();
        st.close();
        desconectar(c);
        return existe;
    }
     
     public User login(String nif, String pass) throws SQLException, ClassNotFoundException, BankException {
         User u = null;
         Connection c = conectar();
         try (Statement st = c.createStatement()) {
             ResultSet rs = st.executeQuery("select * from user where nif = '" + nif + "' and pass = '" + pass + "';");
             if (rs.next()) {
                 String name = rs.getString("name");
                 String surname = rs.getString("surname");
                 u = new User(nif, name, surname);
             } else {
                 throw new BankException("Usuari o contrasenya incorrectes.");
             }
             rs.close();
         } finally {
             desconectar(c);
         }
         return u;
     }
    
    public void insertUser(User u) throws SQLException, ClassNotFoundException, BankException {  
        if (existUser(u)){   
            throw new BankException("user.dao.duplicate");   
        }
        Connection c = conectar();
        try (PreparedStatement ps = c.prepareStatement("insert into user values (?, ?, ?, ?);")) { 
            ps.setString(1, u.getNif());
            ps.setString(2, u.getPass());
            ps.setString(3, u.getName());
            ps.setString(4, u.getSurname());
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
    }
    
    
    public void createAccount(Account a, User u) throws SQLException, ClassNotFoundException, BankException {  
        if (existAccount(a)) {
            throw new BankException("Ya existeix un compte amb aquest id.");  
        }
        Connection c = conectar();
        try (PreparedStatement ps = c.prepareStatement("insert into account values (?, ?, ?, ?);")) { 
            ps.setInt(1, a.getIdaccount());
            ps.setString(2, a.getName());
            ps.setDouble(3, a.getBalance());
            ps.setString(4, u.getNif());
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
    }
    
    
    public List<Account> getAccountsWithBalance(User u) throws SQLException, ClassNotFoundException {  
        List<Account> accounts = new ArrayList<>();
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from account where owner = '" + u.getNif() + "' and balance > 0;")) {
            while (rs.next()) {
                int num = rs.getInt("idaccount");
                String nom = rs.getString("name");
                double saldo = rs.getDouble("balance");
                accounts.add(new Account(num, nom, saldo));
            }
        } finally {
            desconectar(c);
        }
        return accounts;
    }
    
    
    public List<Account> getAccounts(User u) throws SQLException, ClassNotFoundException {  
        List<Account> accounts = new ArrayList<>();
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from account where owner = '" + u.getNif() + "';")) {
            while (rs.next()) {
                int num = rs.getInt("idaccount");
                String nom = rs.getString("name");
                double saldo = rs.getDouble("balance");
                accounts.add(new Account(num, nom, saldo));
            }
        } finally {
            desconectar(c);
        }
        return accounts;
    }
    
    public double selectSaldoById(int id) throws SQLException, ClassNotFoundException {
        Connection c = conectar();
        double saldo = 0;
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select balance from account where idaccount = " + id + ";");){
            if (rs.next()) {
                saldo = rs.getDouble("balance");
            }
        } finally {
            desconectar(c);
        }
        return saldo;
    }
    
    public void transfer(int origen, int desti, double importe) throws ClassNotFoundException, SQLException {
        Connection c  = conectar();
        //comprovar si tiene el dinero que se quiere tranferir
        // Hacer una transaccion para que si una de las dos cuentas fallan no se siga haciendo
        try {
        c.setAutoCommit(false);
        PreparedStatement ps = c.prepareStatement("update account set balance = balance - ? where idaccount = ?;");
        ps.setDouble(1, importe);
        ps.setInt(2, origen);
        ps.executeUpdate();
        
        ps = c.prepareStatement("update account set balance = balance + ? where idaccount = ?;");
        ps.setDouble(1, importe);
        ps.setInt(2, desti);
        ps.executeUpdate();
        ps.close();
        c.commit();
        } catch (SQLException ex) {
            c.rollback();
        } finally {
            c.setAutoCommit(true);
            desconectar(c);
        }
        
    }
    
    
    public List<Account> selectAccountsWithoutOne(int idAccount) throws SQLException, ClassNotFoundException {
        List<Account> accounts = new ArrayList<>();
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from account where idaccount != '" + idAccount + "';")) {
            while (rs.next()) {
                int num = rs.getInt("idaccount");
                String nom = rs.getString("name");
                double saldo = rs.getDouble("balance");
                accounts.add(new Account(num, nom, saldo));
            }
        } finally {
            desconectar(c);
        }
        return accounts;
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