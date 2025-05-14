package com.minigames;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class Game1Servlet
 */
@WebServlet("/Game1Servlet")
public class Game1Servlet extends HttpServlet {

    private final String[] questions = {
        "What is 2 + 2?",
        "What is 25 + 150?",
        "What is 5 * 5?",
        "What is the square root of 26977905?",
        "What is the binary of 1050730?",
        "What is 0 + 0?"
    };
    
    private final String[] correctAnswers = {
        "4", "175", "25", "164192", "1011104", "0"
    };

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve the question number, if it's not set, initialize it to 0
        Integer questionNumberObj = (Integer) session.getAttribute("questionNumber");
        int questionNumber = (questionNumberObj == null) ? 0 : questionNumberObj;

        String userAnswer = request.getParameter("answer");
        String correctAnswer = correctAnswers[questionNumber];
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Start of HTML with background styling
        out.println("<html>");
        out.println("<head>");
        out.println("<style>");
        out.println("body {");
        out.println("    font-family: Arial, sans-serif;");
        out.println("    background-image: url('tbg.jpg');");  // Replace with your image path
        out.println("    background-size: cover;");
        out.println("    background-position: center;");
        out.println("    color: white; ");
        out.println("    text-align: center;");
        out.println("    padding: 50px 0;");
        out.println("}");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");

        // Check if the answer is correct or not
        if (userAnswer.equals(correctAnswer)) {
            out.println("<h2 style='margin-top: 350px; '>Correct Answer!</h2>");
        } else {
            out.println("<h2 style='margin-top: 350px; '>Wrong Answer! Try Again!</h2>");
        }

        // If there are more questions, proceed to the next one
        if (questionNumber < questions.length - 1) {
            // Increment the question number for the next question
            session.setAttribute("questionNumber", questionNumber + 1);
            out.println("<form action='game1.jsp' method='post'>");
            
            out.println("<button type='submit' style='background-color:#f39c12 ; margin-top:10px; color: white; border-radius: 12px; padding: 10px 20px;'>Next Question</button>");
            out.println("</form>");
        } else {
            // Game over - show a final message
            out.println("<h2 style='margin-top: 350px;'>Game Over! You answered all questions.</h2>");
            out.println("<form action='game1.jsp' method='get'>");
            out.println("<button type='submit' style='background-color:#f39c12; margin-top:10px; color: white; border-radius: 12px; padding: 10px 20px;'>Play Again</button>");
            out.println("</form>");
        }

        out.println("</body>");
        out.println("</html>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Initialize the session with the first question number if it hasn't been set
        HttpSession session = request.getSession();
        if (session.getAttribute("questionNumber") == null) {
            session.setAttribute("questionNumber", 0); // Starting at question 0
        }

        // Forward to the game page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/game1.jsp");
        dispatcher.forward(request, response);
    }
}
