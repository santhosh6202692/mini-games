package com.minigames;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class carServlet
 */
@WebServlet("/carServlet")
public class carServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the user to the game.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("car.jsp");
        dispatcher.forward(request, response);
    }
}