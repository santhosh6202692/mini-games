<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Snake Game</title>
    <style>
        /* General Styles for Body */
        body {
            font-family: 'Arial', sans-serif;
            text-align: center;
            background-image: url("snakebackground.jpg");  /* Replace with your local or relative path */
            background-size: cover;  /* Ensures the image covers the whole page */
            background-position: center center;  /* Centers the background image */
            background-attachment: fixed;  /* Keeps the background fixed while scrolling */
            margin: 0;
            padding: 0;
            height: 100vh;  /* Full height */
            color: #fff;  /* White text color for contrast */
        }

        /* Styling for the Header */
        h1 {
            font-family: 'Arial', sans-serif;
            color: #fff;
            font-size: 3rem;
            margin-top: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        /* Styling for Score */
        h3 {
            font-family: 'Arial', sans-serif;
            color: #fff;
            font-size: 1.5rem;
            margin-top: 10px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }

        /* Canvas Styling */
        #gameCanvas {
            border: 1px solid black;
            display: block;
            margin: 30px auto;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.5);  /* Adds a shadow to the canvas */
            background-color: #fff; 
            /* White background for the canvas */
        }

        /* Styling for the Score Text */
        #score {
            font-weight: bold;
            font-size: 1.5rem;
        }

    </style>
</head>
<body>
    <h1>Snake Game</h1>
   <canvas id="gameCanvas" width="500" height="500" style="position: absolute; top: 130px; left: 690px;"></canvas>

    <h3>Score: <span id="score">0</span></h3>
    
    <script>
        const canvas = document.getElementById('gameCanvas');
        const ctx = canvas.getContext('2d');
        
        let snake = [{x: 10, y: 10}];  // Snake body as an array of segments
        let food = {x: 15, y: 15};     // Initial food position
        let score = 0;
        let direction = 'RIGHT';

        // Game loop
        function gameLoop() {
            moveSnake();
            if (checkCollision()) {
                resetGame();
            }

            drawGame();
            setTimeout(gameLoop, 100); // Repeat every 100ms
        }

        // Draw the snake and food
        function drawGame() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            // Draw snake with rounded segments
            ctx.fillStyle = 'green';
            snake.forEach((segment, index) => {
                // Draw each segment as a circle (realistic snake body)
                ctx.beginPath();
                ctx.arc(segment.x * 20 + 10, segment.y * 20 + 10, 8, 0, 2 * Math.PI);
                ctx.fill();
            });

            // Draw food
            ctx.fillStyle = 'red';
            ctx.beginPath();
            ctx.arc(food.x * 20 + 10, food.y * 20 + 10, 8, 0, 2 * Math.PI);
            ctx.fill();

            // Update score
            document.getElementById('score').innerText = score;
        }

        // Move the snake based on the current direction
        function moveSnake() {
            let head = { ...snake[0] }; // Clone the head of the snake
            switch (direction) {
                case 'UP': head.y--; break;
                case 'DOWN': head.y++; break;
                case 'LEFT': head.x--; break;
                case 'RIGHT': head.x++; break;
            }
            snake.unshift(head);  // Add the new head to the front of the snake

            // Check if the snake eats the food
            if (head.x === food.x && head.y === food.y) {
                score++;  // Increase score
                food = generateFood();  // Generate new food
            } else {
                snake.pop();  // Remove the last segment to keep the snake's size constant
            }
        }

        // Check if the snake has collided with walls or itself
        function checkCollision() {
            let head = snake[0];

            // Wall collision
            if (head.x < 0 || head.x >= 20 || head.y < 0 || head.y >= 20) {
                return true;
            }

            // Self-collision
            for (let i = 1; i < snake.length; i++) {
                if (snake[i].x === head.x && snake[i].y === head.y) {
                    return true;
                }
            }

            return false;
        }

        // Generate food at a random location
        function generateFood() {
            let x = Math.floor(Math.random() * 20);
            let y = Math.floor(Math.random() * 20);
            return {x, y};
        }

        // Listen for key events to control the snake
        document.addEventListener('keydown', function(event) {
            switch (event.key) {
                case 'ArrowUp':
                    if (direction !== 'DOWN') direction = 'UP';
                    break;
                case 'ArrowDown':
                    if (direction !== 'UP') direction = 'DOWN';
                    break;
                case 'ArrowLeft':
                    if (direction !== 'RIGHT') direction = 'LEFT';
                    break;
                case 'ArrowRight':
                    if (direction !== 'LEFT') direction = 'RIGHT';
                    break;
            }
        });

        // Reset game
        function resetGame() {
            snake = [{x: 10, y: 10}];
            food = {x: 15, y: 15};
            score = 0;
            direction = 'RIGHT';
        }

        // Start the game
        window.onload = function() {
            gameLoop();  // Start the game loop
        };
    </script>
</body>
</html>
