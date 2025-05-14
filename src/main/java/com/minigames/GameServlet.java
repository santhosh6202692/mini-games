package com.minigames;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


public class GameServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set the content type to be HTML
        response.setContentType("text/html");

        // Get the PrintWriter object to write HTML
        PrintWriter out = response.getWriter();
        
        // Generate the HTML page
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Snake Game</title>");
        out.println("<link rel='stylesheet' type='text/css' href='style.css'>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Snake Game</h1>");
        
        // Include the game interface (game.jsp)
        request.getRequestDispatcher("game.jsp").include(request, response);
        
        out.println("</body>");
        out.println("</html>");
    }
}
