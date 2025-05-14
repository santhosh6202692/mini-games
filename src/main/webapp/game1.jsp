<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Trivia Game</title>
    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            background-image: url('tbg.jpg');  /* Replace with your background image path */
            background-size:100%;
            background-position: 50% -100px;
             background-attachment: fixed ;
            color: white;  /* Set the text color to white for better contrast on dark backgrounds */
            text-align: center;  /* Center-align the content */
            padding: 50px 0;  /* Add some padding around the body */
            
        }

        h2 {
            font-size: 36px;
         margin-top: 170px; 
            
        }

        form {
            background-color: rgba(0, 0, 0, 0.6);  /* Slightly transparent background for the form */
            padding: 20px;
            border-radius: 10px;
            display: inline-block;
            width: 100%;
            max-width: 400px;  /* Limit the width of the form */
        }

        label {
            font-size: 18px;
            margin-bottom: 10px;
            display: block;
        }

        input[type="text"] {
            padding: 10px;
            width: 100%;
            font-size: 16px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: none;
        }

        button {
            padding: 10px 20px;
            background-color: #f39c12;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            color: white;
        }

        button:hover {
            background-color: #e67e22;
        }
     
    </style>
</head>
<body>
    <h2 style='margin-top: 80px; '>Trivia Game</h2>
    <form action="Game1Servlet" method="post">
        <label for="question">What is 2 + 2?</label>
               <input style="margin-left: -10px;" type="text" id="answer" name="answer">
        <button type="submit">Submit Answer</button>
    </form><br><br>
     <form action="Game1Servlet" method="post">
              <label for="question">What is 287 - 112?</label>
               <input style="margin-left: -10px;" type="text" id="answer" name="answer">
        <button type="submit">Submit Answer</button>
    </form><br><br>
     <form action="Game1Servlet" method="post">
                    <label for="question">What is 315 % 8?</label>
                     <input style="margin-left: -10px;" type="text" id="answer" name="answer">
        <button type="submit">Submit Answer</button>
    </form><br><br>
     <form action="Game1Servlet" method="post">
                          <label for="question">What is 23456 * 2?</label>
                           <input style="margin-left: -10px;" type="text" id="answer" name="answer">
        <button type="submit">Submit Answer</button>
    </form><br><br>
     <form action="Game1Servlet" method="post">
                                <label for="question">What is 987652 + 23452?</label>
                                 <input style="margin-left: -10px;" type="text" id="answer" name="answer">
        <button type="submit">Submit Answer</button>
    </form><br><br>
     <form action="Game1Servlet" method="post">
                                      <label for="question">What is 0 * 2?</label>
                                       <input style="margin-left: -10px;" type="text" id="answer" name="answer">
        <button type="submit">Submit Answer</button>
    </form>
        
</body>
</html> 