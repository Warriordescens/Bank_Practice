/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.bankexample.practice.model;

/**
 *
 * @author admin
 */
public class Account {
    
    private int idaccount;
    private String name;
    private double balance;

    public Account(int idaccount, String name, double balance) {
        this.idaccount = idaccount;
        this.name = name;
        this.balance = balance;
    }
    
    

    public int getIdaccount() {
        return idaccount;
    }

    public String getName() {
        return name;
    }

    public double getBalance() {
        return balance;
    }
    
    
    
    
}
