package com.example.lab2;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public abstract class MyServlet extends HttpServlet {
    protected abstract void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
