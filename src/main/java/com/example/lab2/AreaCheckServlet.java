package com.example.lab2;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class AreaCheckServlet extends MyServlet {
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String queryString = request.getQueryString();
        List<String> parsedData = new java.util.ArrayList<>(Arrays.stream(queryString.split("&"))
                .map(x -> x.split("=")[1])
                .toList());
        double x = Double.parseDouble(parsedData.get(0));
        double y = Double.parseDouble(parsedData.get(1));
        double r = Double.parseDouble(parsedData.get(2));
        if (x < -5 || x > 3 || y < -5 || y > 3 || r < 0 || r > 5) {
            response.setStatus(400);
        } else {
            addAreaDataToContext(checkHit(x, y, r));
            request.getRequestDispatcher("/result.jsp").forward(request, response);
        }
    }

    private void addAreaDataToContext(ResultData data) {
        ServletContext context = getServletContext();
        Object sessionData = context.getAttribute("sessionData");
        if (sessionData == null) {
            sessionData = new ArrayList<ResultData>();
        }
        @SuppressWarnings("unchecked")
        List<ResultData> contents = new java.util.ArrayList<>(((ArrayList<ResultData>) sessionData));
        contents.add(data);
        context.setAttribute("sessionData", contents);
    }

    private ResultData checkHit(double x, double y, double r) {
        long startTime = System.nanoTime() / 1000;
        boolean hit = (x >= 0 && x <= r && y >= 0 && y <= (r / 2))
                || (x >= 0 && y <= 0 && (Math.pow(x, 2) + Math.pow(y, 2)) <= Math.pow(r / 2, 2))
                || (x >= -r && x <= 0 && y <= 0 && y >= (- x - r));
        long execTime = System.nanoTime() / 1000 - startTime;
        String currTime = new SimpleDateFormat("HH:mm:ss").format(new Date(System.currentTimeMillis()));
        return new ResultData(hit, x, y, r, execTime, currTime);
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
