package com.minigames;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.Base64;

@WebServlet("/SaveDrawingServlet")
public class DrawingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // HTML form to display a drawing interface
        out.println("<html><head><title>Drawing Game</title></head><body>");
        out.println("<h2>Welcome to the Drawing Game!</h2>");
        
        // The form will handle the drawing data (basic example, no JS)
        out.println("<form action='/DrawingGame/draw' method='POST'>");
        out.println("<textarea name='drawingData' rows='20' cols='50'></textarea><br>");
        out.println("<input type='submit' value='Save Drawing'>");
        out.println("<input type='reset' value='Clear'>");
        out.println("</form>");
        
        // Display saved drawings (if any)
        String drawingData = (String) request.getAttribute("drawingData");
        if (drawingData != null && !drawingData.isEmpty()) {
            out.println("<h3>Your Drawing:</h3>");
            out.println("<pre>" + drawingData + "</pre>");
        }
        
        out.println("</body></html>");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String drawingData = request.getParameter("drawingData");
        
        // Here we can save drawing data to a database or file system, but we'll just forward it back to the form for simplicity
        request.setAttribute("drawingData", drawingData);
        
        // Forward to the same page (GET) to display the drawing
        RequestDispatcher dispatcher = request.getRequestDispatcher("/draw");
        dispatcher.forward(request, response);
    }
}