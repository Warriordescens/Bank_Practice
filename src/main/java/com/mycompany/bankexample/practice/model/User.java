/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.bankexample.practice.model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class User {
    
    private String nif;
    private String pass;
    private String name;
    private String surname;
    private List<Account> accounts;

    public User(String nif, String pass, String name, String surname) {
        this.nif = nif;
        this.pass = pass;
        this.name = name;
        this.surname = surname;
        accounts = new ArrayList<>();
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public List<Account> getAccounts() {
        return accounts;
    }

    public void setAccounts(List<Account> accounts) {
        this.accounts = accounts;
    }
    
    
}
