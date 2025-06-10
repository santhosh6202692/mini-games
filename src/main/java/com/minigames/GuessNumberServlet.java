package com.minigames;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

/**
 * Servlet implementation class GuessNumberServlet
 */
@WebServlet("/GuessNumberServlet")
public class GuessNumberServlet extends HttpServlet {

    private static final int MIN_NUMBER = 1;
    private static final int MAX_NUMBER = 10;
    private int targetNumber;

    @Override
    public void init() throws ServletException {
        // Initialize the target number at the start of the game (on server startup or when servlet is loaded)
        Random rand = new Random();
        targetNumber = rand.nextInt(MAX_NUMBER - MIN_NUMBER + 1) + MIN_NUMBER;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the user's guess from the form
        String guessStr = request.getParameter("guess");
        String message = "";
        
        // Print the target number in the console (useful for debugging)
        System.out.println("Target number: " + targetNumber);
        
        try {
            int guess = Integer.parseInt(guessStr);
            
            if (guess < MIN_NUMBER || guess > MAX_NUMBER) {
                message = "Please enter a number between " + MIN_NUMBER + " and " + MAX_NUMBER + ".";
            } else if (guess < targetNumber) {
                message = "Your guess is too low. Try again!";
            } else if (guess > targetNumber) {
                message = "Your guess is too high. Try again!";
            } else {
                message = "Congratulations! You've guessed the number!";
            }

        } catch (NumberFormatException e) {
            message = "Invalid input. Please enter a valid number.";
        }
        
        // Set the message and targetNumber as request attributes to be displayed on the HTML page
        request.setAttribute("message", message);
        request.setAttribute("targetNumber", targetNumber);
        
        // Forward the request to the JSP or HTML page for displaying the result
        RequestDispatcher dispatcher = request.getRequestDispatcher("/guessTheNumber.jsp");  // Or your HTML page
        dispatcher.forward(request, response);
    }}