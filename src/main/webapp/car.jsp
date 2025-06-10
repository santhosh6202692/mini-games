<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mini Car Game</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 20px;
            position: relative;
            overflow: hidden;
        }

        video.background-video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        h1 {
            color: #fff;
        }

        .score {
            font-size: 24px;
            color: #fff;
            margin-bottom: 10px;
        }

        #pauseButton {
            padding: 15px 30px;
            font-size: 18px;
            color: #fff;
            background-color: red;
            border: none;
            cursor: pointer;
            border-radius: 8px;
            position: absolute;
            top: 20px;
            right: 20px;
            transition: background-color 0.3s ease;
        }

        #pauseButton:hover {
            background-color: #555;
        }

        #pauseButton:focus {
            outline: none;
        }

        /* Modal styles */
        #gameOverModal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            text-align: center;
            font-size: 30px;
            z-index: 999;
        }

        #gameOverModal .modalContent {
            margin-top: 200px;
            background-color: rgba(0, 0, 0, 0.8);
            padding: 20px;
            border-radius: 10px;
            display: inline-block;
        }

        #gameOverModal button {
            background-color: #f44336;
            border: none;
            padding: 10px 20px;
            color: white;
            font-size: 18px;
            cursor: pointer;
            border-radius: 5px;
        }

        #gameOverModal button:hover {
            background-color: #e60000;
        }
    </style>
</head>
<body>
    <video id="backgroundVideo" class="background-video" autoplay muted loop>
        <source src="roadbg3.mp4" type="video/mp4" />
        Your browser does not support the video tag.
    </video>

    <h1>Mini Car Game</h1>
    <div class="score">Score: <span id="scoreDisplay">0</span></div>
    <div id="canvasContainer">
        <canvas id="gameCanvas" width="1000" height="800"></canvas>
    </div>
    <button id="pauseButton">Pause</button>

    <!-- Game Over Modal -->
    <div id="gameOverModal">
        <div class="modalContent">
            <p>Game Over! Final Score: <span id="finalScore"></span></p>
            <button onclick="restartGame()">Restart</button>
        </div>
    </div>

    <script>
        const canvas = document.getElementById("gameCanvas");
        const ctx = canvas.getContext("2d");

        // Drawing sizes for car and obstacles
        const carWidth = 180;
        const carHeight = 180;
        const obstacleWidth = 180;
        const obstacleHeight = 180;

        // --- MANUAL COLLISION BOX SIZES ---
        // Adjust these to control the actual collision detection area (can be smaller/larger than image)
        const carCollisionWidth = 80;
        const carCollisionHeight = 150;

        const obstacleCollisionWidth = 80;
        const obstacleCollisionHeight = 150;

        let carX = canvas.width / 2 - carWidth / 2;
        let carY = canvas.height - carHeight - 10;
        let carSpeed = 5;

        let obstacles = [];
        let obstacleSpeed = 3;

        let score = 0;

        let moveLeft = false;
        let moveRight = false;
        let moveUp = false;
        let moveDown = false;

        let isPaused = false;
        let gameInterval;

        const video = document.getElementById('backgroundVideo');

        // Load images
        const carImage = new Image();
        carImage.src = "carimg1.png";  // Player car image

        const obstacleImage = new Image();
        obstacleImage.src = "carimg2.png";  // Obstacle image

        // Keyboard input handlers
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

        function drawCar() {
            ctx.drawImage(carImage, carX, carY, carWidth, carHeight);
        }

        function generateObstacles() {
            const yPosition = -obstacleHeight;
            if (obstacles.length < 5) {
                for (let i = 0; i < 5 - obstacles.length; i++) {
                    const obstacleX = Math.random() * (canvas.width - obstacleWidth);
                    obstacles.push({ x: obstacleX, y: yPosition - i * 150, width: obstacleWidth, height: obstacleHeight });
                }
            }
        }

        function drawObstacles() {
            obstacles.forEach(obstacle => {
                ctx.drawImage(obstacleImage, obstacle.x, obstacle.y, obstacle.width, obstacle.height);
            });
        }

        function moveObstacles() {
            obstacles.forEach(obstacle => {
                obstacle.y += obstacleSpeed;
            });
        }

        // Collision detection uses manual collision box sizes
        function checkCollision() {
            for (let i = 0; i < obstacles.length; i++) {
                const obs = obstacles[i];

                if (
                    carX < obs.x + obstacleCollisionWidth &&
                    carX + carCollisionWidth > obs.x &&
                    carY < obs.y + obstacleCollisionHeight &&
                    carY + carCollisionHeight > obs.y
                ) {
                    clearInterval(gameInterval);
                    showGameOver();
                    return;
                }
            }
        }

        function updateScore() {
            for (let i = obstacles.length - 1; i >= 0; i--) {
                if (obstacles[i].y > canvas.height) {
                    score += 1;
                    obstacles.splice(i, 1);
                }
            }
            document.getElementById('scoreDisplay').innerText = score;
        }

        function resetGame() {
            carX = canvas.width / 2 - carWidth / 2;
            carY = canvas.height - carHeight - 10;
            obstacles = [];
            score = 0;
            document.getElementById('scoreDisplay').innerText = score;
            document.getElementById('gameOverModal').style.display = 'none';
        }

        function restartGame() {
            resetGame();
            gameLoop();
        }

        function showGameOver() {
            document.getElementById('finalScore').innerText = score;
            document.getElementById('gameOverModal').style.display = 'block';
        }

        document.getElementById("pauseButton").addEventListener("click", () => {
            isPaused = !isPaused;
            if (isPaused) {
                document.getElementById("pauseButton").textContent = "Resume";
                video.pause();
                clearInterval(gameInterval);
            } else {
                document.getElementById("pauseButton").textContent = "Pause";
                video.play();
                gameLoop();
            }
        });

        function gameLoop() {
            gameInterval = setInterval(() => {
                if (isPaused) return;

                ctx.clearRect(0, 0, canvas.width, canvas.height);

                if (moveLeft && carX > 0) carX -= carSpeed;
                if (moveRight && carX < canvas.width - carWidth) carX += carSpeed;
                if (moveUp && carY > 0) carY -= carSpeed;
                if (moveDown && carY < canvas.height - carHeight) carY += carSpeed;

                generateObstacles();
                moveObstacles();
                drawCar();
                drawObstacles();
                checkCollision();
                updateScore();
            }, 1000 / 60);
        }

        gameLoop();
    </script>
</body>
</html>
