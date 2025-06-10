<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Trivia Quiz Result</title>
  <style>
    body { 
      font-family: Arial, sans-serif; 
      background-color: #222; 
      color: white; 
      text-align: center; 
      padding: 50px;
    }
    .result { 
      font-size: 24px; 
      color: lightgreen; 
    }
    a {
      color: #f39c12;
      text-decoration: none;
      font-weight: bold;
      font-size: 18px;
    }
    a:hover {
      color: #e67e22;
    }
  </style>
</head>
<body>
  <h2>Trivia Quiz Completed!</h2>
  <p class="result">
    Your correct answer percentage is <strong><%= request.getAttribute("percentage") %>%</strong>.
  </p>
  <a href="game1.jsp">Play Again</a>
</body>
</html>
