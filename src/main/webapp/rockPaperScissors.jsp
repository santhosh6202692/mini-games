<!DOCTYPE html>
<html>
<head>
    <title>Rock, Paper, Scissors</title>
    <style>
        body {
            background-image: url('rpbg6.jpg'); /* Replace with your image URL */
            background-size: 93%;  /* Makes the background cover the entire page */
            background-position: center left; /* Centers the background */
            font-family: Arial, sans-serif;  /* Sets the font style */
            color: white;  /* Changes the text color to white */
            text-align: center;  /* Centers the text */
            margin: 0;
            padding: 0;
           
             
            height: 70vh;   /* Makes the body take the full height of the viewport */
        }

        h2 {
            font-size: 36px;
            margin-top: 20px;
        }

        form {
            margin-top: 20px;
        }

        button {
            background-color: rgba(255, 255, 255, 0.8); /* Slightly transparent button */
            border: none;
            padding: 10px 20px;
            font-size: 18px;
            margin: 10px;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: rgba(255, 255, 255, 1); /* Solid white when hovered */
        }

        p {
            font-size: 20px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Rock, Paper, Scissors</h2>
    <form action="Rock" method="POST">
        <button type="submit" name="choice" value="Rock">Rock</button>
        <button type="submit" name="choice" value="Paper">Paper</button>
        <button type="submit" name="choice" value="Scissors">Scissors</button>
    </form>

    <p>Your choice: ${param.choice}</p>
    <p>Server's choice: ${serverChoice}</p>
    <p>${result}</p>
</body>
</html>
