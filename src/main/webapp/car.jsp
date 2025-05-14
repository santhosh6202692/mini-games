<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mini Car Game</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 20px;
            position: relative; /* Ensure video is behind the content */
            overflow: hidden; /* Hide any overflow */
        }

        /* Background Video */
        video.background-video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover; /* Make sure the video covers the entire screen */
            z-index: -1; /* Send video behind content */
        }

 canvas {
    border: 2px solid black;
    display: block;
    margin: auto;
    background-image: url('roadbg.jpg'); /* Set background image */
    background-size: cover; /* Ensure the image covers the entire canvas */
    background-position: center; /* Center the image */
}


        h1 {
            color: #fff; /* White text to stand out on video */
        }

        .score {
            font-size: 24px;
            color: #fff; /* White text for score */
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- Background Video -->
    <video class="background-video" autoplay muted loop>
        <source src="carbgvideo.webm" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <h1>Mini Car Game</h1>
    <div class="score">Score: <span id="scoreDisplay">0</span></div>
    <canvas id="gameCanvas" width="500" height="800"></canvas>

    <script>
        const canvas = document.getElementById("gameCanvas");
        const ctx = canvas.getContext("2d");

        // Car Object
        const carWidth = 50;
        const carHeight = 100;
        let carX = canvas.width / 2 - carWidth / 2;
        let carY = canvas.height - carHeight - 10;
        let carSpeed = 5;

        // Obstacle Array (Now with truck emojis)
        let obstacles = [];
        let obstacleSpeed = 3;

        // Score variable
        let score = 0;

        // Handle keyboard input
        let moveLeft = false;
        let moveRight = false;
        let moveUp = false;
        let moveDown = false;

        document.addEventListener("keydown", (e) => {
            if (e.key === "ArrowLeft") moveLeft = true;
            if (e.key === "ArrowRight") moveRight = true;
            if (e.key === "ArrowUp") moveUp = true;
            if (e.key === "ArrowDown") moveDown = true;
        });

        document.addEventListener("keyup", (e) => {
            if (e.key === "ArrowLeft") moveLeft = false;
            if (e.key === "ArrowRight") moveRight = false;
            if (e.key === "ArrowUp") moveUp = false;
            if (e.key === "ArrowDown") moveDown = false;
        });

        // Draw Car Function using Emoji
        function drawCar() {
            ctx.font = "100px Arial"; // Set the font size for the emoji
            ctx.fillText("🚔", carX, carY + carHeight - 10); // Draw car emoji (adjust the position)
        }

        // Generate Obstacles (Truck emojis, 3 obstacles per line)
        function generateObstacles() {
            if (obstacles.length < 3) {
                const obstacleWidth = 50;
                const obstacleX1 = Math.random() * (canvas.width - obstacleWidth);
                const obstacleX2 = Math.random() * (canvas.width - obstacleWidth);
                const obstacleX3 = Math.random() * (canvas.width - obstacleWidth);
                const yPosition = -100;  // Start above the canvas

                obstacles.push(
                    { x: obstacleX1, y: yPosition, width: obstacleWidth, height: obstacleWidth },
                    { x: obstacleX2, y: yPosition, width: obstacleWidth, height: obstacleWidth },
                    { x: obstacleX3, y: yPosition, width: obstacleWidth, height: obstacleWidth }
                );
            }
        }

        // Draw Obstacles (Truck Emoji)
        function drawObstacles() {
            ctx.font = "100px Arial"; // Adjust size for truck emoji
            obstacles.forEach(obstacle => {
                ctx.fillText("🚖", obstacle.x, obstacle.y + obstacle.height); // Draw truck emoji
            });
        }

        // Move Obstacles
        function moveObstacles() {
            obstacles.forEach(obstacle => {
                obstacle.y += obstacleSpeed;
            });
        }

        // Detect Collision
        function checkCollision() {
            for (let i = 0; i < obstacles.length; i++) {
                const obs = obstacles[i];
                if (
                    carX < obs.x + obs.width &&
                    carX + carWidth > obs.x &&
                    carY < obs.y + obs.height &&
                    carY + carHeight > obs.y
                ) {
                    alert("Game Over! Final Score: " + score);
                    resetGame();
                }
            }
        }

        // Increment Score when obstacles pass
        function updateScore() {
            for (let i = 0; i < obstacles.length; i++) {
                if (obstacles[i].y > canvas.height) {
                    score += 1; // Increase score when obstacle passes bottom
                    obstacles.splice(i, 1); // Remove passed obstacle from array
                }
            }
            // Update score display
            document.getElementById('scoreDisplay').innerText = score;
        }

        // Reset Game
        function resetGame() {
            carX = canvas.width / 2 - carWidth / 2;
            carY = canvas.height - carHeight - 10;
            obstacles = [];
            score = 0; // Reset score
            document.getElementById('scoreDisplay').innerText = score; // Update the display
        }

        // Game Loop
        function gameLoop() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            
            // Move Car Based on Key Presses
            if (moveLeft && carX > 0) carX -= carSpeed;
            if (moveRight && carX < canvas.width - carWidth) carX += carSpeed;
            if (moveUp && carY > 0) carY -= carSpeed;
            if (moveDown && carY < canvas.height - carHeight) carY += carSpeed;

            generateObstacles();
            moveObstacles();
            drawCar(); // Draw the car emoji on canvas
            drawObstacles(); // Draw truck emojis as obstacles
            checkCollision();
            updateScore(); // Update the score during each frame

            requestAnimationFrame(gameLoop);
        }

        gameLoop();
    </script>
</body>
</html>
