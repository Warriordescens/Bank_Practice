/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package com.mycompany.bankexample.practice.filter;

import java.io.IOException;
import java.util.Locale;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.core.Config;

/**
 *
 * @author admin
 */
@WebFilter(filterName = "LanguageFilter", urlPatterns = {"/*"})
public class LanguageFilter implements Filter {
    
    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession();

        // 1. Obtenim el paràmetre 'lang' de la URL (si existeix)
        String langParam = request.getParameter("lang");
        Locale userLocale = null;

        // ESTRUCTURA DE DECISIÓ (PRIORITATS)
        // CAS 1: L'usuari demana canviar d'idioma explícitament (clic a bandera)
        if (langParam != null && !langParam.isEmpty()) {
            // Locale.forLanguageTag converteix "ca", "es", "en" en objecte Locale
            userLocale = Locale.forLanguageTag(langParam);
            // Guardem l'elecció a la sessió per recordar-la en el futur
            session.setAttribute("currentLocale", userLocale);
        } // CAS 2: L'usuari ja té un idioma preferit guardat a la sessió
        else if (session.getAttribute("currentLocale") != null) {
            userLocale = (Locale) session.getAttribute("currentLocale");
        } // CAS 3: Primera visita -> Utilitzem l'idioma del navegador
        else {
            userLocale = request.getLocale();
            session.setAttribute("currentLocale", userLocale);
        }

        // PUNT CRÍTIC: Sincronització amb JSTL
        // Això diu a les etiquetes <fmt:message> quin idioma han de mostrar
        Config.set(session, Config.FMT_LOCALE, userLocale);

        // Assegurem que les dades viatgin en UTF-8 (important per accents)
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Continuem amb la petició normal cap al Servlet o JSP
        chain.doFilter(request, response);
        
    }

}
