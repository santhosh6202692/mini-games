<!DOCTYPE html>
<html>
<head>
    <title>Guess the Number</title>
    <style>
        body {
            background-image: url('guessbackground.jpg'); /* Replace with your image URL */
            background-size: cover;  /* Makes the background cover the entire page */
            background-position: center center; /* Centers the background */
            font-family: Arial, sans-serif;  /* Sets the font style */
            color: white;  /* Changes the text color to white */
            text-align: center;  /* Centers the text */
            margin: 0;
            padding: 0;
            height: 100vh;  /* Makes the body take the full height of the viewport */
        }

        h2 {
            font-size: 36px;
            margin-top: 50px;
            color: white; /* Ensures the header stands out */
        }

        form {
            margin-top: 20px;
            display: inline-block;
            background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent background */
            padding: 20px;
            border-radius: 10px;
        }

        label {
            font-size: 18px;
            margin-right: 10px;
        }

        input[type="number"] {
            padding: 10px;
            font-size: 18px;
            border-radius: 5px;
            margin-top: 10px;
        }

        button {
            background-color: rgba(255, 255, 255, 0.8); /* Slightly transparent button */
            border: none;
            padding: 10px 20px;
            font-size: 18px;
            margin-top: 10px;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: rgba(255, 255, 255, 1); /* Solid white when hovered */
        }

        p {
            font-size: 20px;
            margin-top: 20px;
            color: white;
        }
    </style>
</head>
<body>
   <h2 style="position: absolute; top: 280px; left: 100px;">Guess the Number Game:</h2>
   
    <form action="GuessNumberServlet"style="position: absolute; top: 380px; left: 100px;" method="POST">
        <label >Enter a number between 1 and 10 :</label>
        <input type="number" name="guess" required><br><br>
        <button type="submit">Submit Guess</button>
    </form>

    <p style="position: absolute; top: 580px; left: 100px; color: white; font-size: 20px;">
  ${message}
</p>

</body>
</html>
