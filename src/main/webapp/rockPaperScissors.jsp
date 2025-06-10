<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rock, Paper, Scissors</title>
    <style>
        /* Body and background styles */
        body {
            background-image: url('rockgameimg.jpg'); /* Replace with your image URL */
            background-size: cover;
            background-position: center center; /* Centers the background */
            font-family: Arial, sans-serif; /* Sets the font */
            color: black;
            text-align: center;
            margin: 0;
            padding: 0;
            height: 100vh; /* Full height of the viewport */
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        /* Heading styles */
        h2 {
            font-size: 48px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7);
            margin-top: -250px; /* Inline adjustment */
            color: black;
        }

        /* Form and button styles */
        form {
            display: flex;
            justify-content: space-between;
            width: 80%;
            max-width: 600px;
        }

        /* Button styles */
        button {
            background-color: rgba(255, 255, 255, 0.8); /* Slightly transparent button */
            border: none;
            padding: 20px;
            font-size: 18px;
            cursor: pointer;
            border-radius: 10px;
            width: 120px;
            height: 120px;
            text-align: center;
            transition: background-color 0.3s ease, transform 0.2s ease;
            display: flex;
            justify-content: center;
            align-items: center;
            color: black;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.7);
            position: relative;
        }

        button:hover {
            background-color: rgba(255, 255, 255, 1); /* Solid white when hovered */
            transform: scale(1.1); /* Slight zoom effect on hover */
        }

        /* Add a container to the button to position text */
        button div {
            position: absolute;
            bottom: 10px; /* Position text at the bottom */
            width: 100%;
            text-align: center;
            font-size: 16px;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.7);
        }

        /* Specific button background images */
        button[name="choice"][value="Rock"] {
            background-image: url('rock img.jpg'); /* Replace with your image URL */
            background-size: cover;
            background-position: center;
        }

        button[name="choice"][value="Paper"] {
            background-image: url('paper img.jfif'); /* Replace with your image URL */
            background-size: cover;
            background-position: center;
        }

        button[name="choice"][value="Scissors"] {
            background-image: url('scissors img.jfif'); /* Replace with your image URL */
            background-size: cover;
            background-position: center;
        }

        /* Paragraph styles for results */
        p {
            font-size: 30px;
            margin-top: 40px;
            text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.7);
        }

        /* Custom styles for choice paragraphs */
        .choice-text {
            font-size: 24px;
            margin-top: 20px;
            font-weight: bold;
            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.7);
        }

        /* Image for user choice */
        .choice-img {
            width: 100px;
            height: 100px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h2>Rock, Paper, Scissors</h2>

    <form action="Rock" method="POST">
        <button type="submit" name="choice" value="Rock">
            <div></div>
        </button>
        <button type="submit" name="choice" value="Paper">
            <div></div>
        </button>
        <button type="submit" name="choice" value="Scissors">
            <div></div>
        </button>
    </form>

    <!-- User's choice with styled text -->
    <p class="choice-text">Your choice:</p>
    <img src="${param.choice == 'Rock' ? 'rock img.jpg' : param.choice == 'Paper' ? 'paper img.jfif' : 'scissors img.jfif'}" alt="Your choice" class="choice-img">

    <!-- Server's choice with styled text -->
    <p class="choice-text">Server's choice:</p>
    <img src="${serverChoice == 'Rock' ? 'rock img.jpg' : serverChoice == 'Paper' ? 'paper img.jfif' : 'scissors img.jfif'}" alt="Server's choice" class="choice-img">

    <!-- Result of the game -->
    <p>${result}</p>
</body>
</html>
-