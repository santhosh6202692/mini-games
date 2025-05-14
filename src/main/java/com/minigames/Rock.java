package com.minigames;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class Rock
 */
@WebServlet("/Rock")
public class Rock extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userChoice = request.getParameter("choice");
        String[] choices = {"Rock", "Paper", "Scissors"};
        String serverChoice = choices[(int) (Math.random() * 3)];
        String result;

        if (userChoice.equals(serverChoice)) {
            result = "It's a tie!";
        } else if ((userChoice.equals("Rock") && serverChoice.equals("Scissors")) ||
                   (userChoice.equals("Paper") && serverChoice.equals("Rock")) ||
                   (userChoice.equals("Scissors") && serverChoice.equals("Paper"))) {
            result = "You win!";
        } else {
            result = "You lose!";
        }

        request.setAttribute("result", result);
        request.setAttribute("serverChoice", serverChoice);
        RequestDispatcher dispatcher = request.getRequestDispatcher("rockPaperScissors.jsp");
        dispatcher.forward(request, response);
    }
}
