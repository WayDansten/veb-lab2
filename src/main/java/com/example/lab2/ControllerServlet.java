package com.example.lab2;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.regex.Pattern;

public class ControllerServlet extends MyServlet {
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String queryString = request.getQueryString();
        if (queryString == null) {
            response.sendRedirect("/index.jsp");
        } else if (!Pattern.matches("X=-?[0-9]+(.[0-9]+)?&Y=-?[0-9]+(.[0-9]+)?&R=[0-9]+(.[0-9]+)?", queryString)) {
            response.setStatus(400);
        } else {
            request.getRequestDispatcher("/area-check-servlet").forward(request, response);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
