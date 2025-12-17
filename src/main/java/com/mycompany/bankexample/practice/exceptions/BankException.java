/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Exception.java to edit this template
 */
package com.mycompany.bankexample.practice.exceptions;

/**
 *
 * @author admin
 */
public class BankException extends Exception {

    /**
     * Creates a new instance of <code>BankException</code> without detail
     * message.
     */
    public BankException() {
    }

    /**
     * Constructs an instance of <code>BankException</code> with the specified
     * detail message.
     *
     * @param msg the detail message.
     */
    public BankException(String msg) {
        super(msg);
    }
}
