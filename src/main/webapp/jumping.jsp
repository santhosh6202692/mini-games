<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Flying Bird Game with PNG Player and Obstacle</title>
    <style>
        body {
            margin: 0;
            overflow: hidden;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        #gameArea {
            position: relative;
            width: 100%;
            height: 100vh;
            overflow: hidden;
            font-size: 50px; /* Size of the emojis */
        }

        /* Background Video */
        #backgroundVideo {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1; /* Make sure video stays behind the game content */
        }

        /* Player Bird (PNG Image) */
        .player {
            position: absolute;
            width: 120px;  /* Adjust this to your PNG width */
            height: auto;
        }

        /* Obstacle Birds (PNG Image) */
        .obstacle {
            position: absolute;
            width: 400px; /* Set obstacle width */
            height: auto; /* Maintain aspect ratio */
        }

        /* Clouds (Emoji) */
        .cloud {
            position: absolute;
            width: 100px;
            height: 60px;
            font-size: 60px;
            line-height: 60px;
            text-align: center;
        }

        /* Custom Game Over Popup */
        #gameOverPopup {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 30px;
            border-radius: 10px;
            font-size: 30px;
            display: none;
            text-align: center;
            z-index: 20;
        }

        #gameOverPopup button {
            padding: 10px 20px;
            font-size: 18px;
            cursor: pointer;
            background-color: #ff6347;
            color: white;
            border: none;
            border-radius: 5px;
        }

        /* Pause Button */
        #pauseButton {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 10px 20px;
            font-size: 20px;
            cursor: pointer;
            background-color: #ff6347;
            color: white;
            border: none;
            border-radius: 5px;
            z-index: 10;
        }

        /* Scoreboard - Centered at the top */
        #scoreboard {
            position: absolute;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            color: white;
            font-size: 30px;
            font-weight: bold;
            z-index: 10;
        }
    </style>
</head>
<body>
    <div id="gameArea">
        <!-- Background Video -->
        <video id="backgroundVideo" autoplay loop muted>
            <source src="jumpvideo.mp4" type="video/mp4" />
            Your browser does not support the video tag.
        </video>

        <!-- Player Bird PNG Image -->
        <img id="player" class="player" src="birdimg.png" alt="Player Bird" />

        <!-- Scoreboard -->
        <div id="scoreboard">Score: 0</div>

        <!-- Pause Button -->
        <button id="pauseButton" onclick="togglePause()">Pause</button>

        <!-- Custom Game Over Popup -->
        <div id="gameOverPopup">
            <p id="gameOverMessage">Game Over!</p>
            <p>Your final score: <span id="finalScore"></span></p>
            <button onclick="restartGame()">Restart</button>
        </div>
    </div>

    <script>
        var gameArea = document.getElementById("gameArea");
        var player = document.getElementById("player");
        var gameOverPopup = document.getElementById("gameOverPopup");
        var finalScore = document.getElementById("finalScore");
        var scoreboard = document.getElementById("scoreboard");
        var pauseButton = document.getElementById("pauseButton");

        var playerY;
        var playerX = 100;
        var playerSpeed = 4;
        var gravity = 0.5;
        var lift = -15;
        var playerVelocity = 0;
        var score = 0;

        var obstacles = [];
        var clouds = [];
        var isPaused = false;

        var gameLoopInterval;
        var createObstacleInterval;
        var createCloudInterval;

        function resetGame() {
            playerY = gameArea.offsetHeight / 2;
            playerVelocity = 0;
            score = 0;
            scoreboard.innerText = "Score: 0";
            obstacles.forEach(function (obstacle) {
                obstacle.remove();
            });
            clouds.forEach(function (cloud) {
                cloud.remove();
            });
            obstacles = [];
            clouds = [];
            player.style.top = playerY + "px";
            player.style.left = playerX + "px";
        }

        function startGame() {
            resetGame();
            gameLoopInterval = setInterval(gameLoop, 20);
            createObstacleInterval = setInterval(createObstacle, 2000);
            createCloudInterval = setInterval(createCloud, 3000);
        }

        function gameLoop() {
            if (isPaused) return;

            playerVelocity += gravity;
            playerY += playerVelocity;

            if (playerY < 0) playerY = 0;
            if (playerY > gameArea.offsetHeight - player.offsetHeight) {
                playerY = gameArea.offsetHeight - player.offsetHeight;
                playerVelocity = 0;
            }

            player.style.top = playerY + "px";
            player.style.left = playerX + "px";

            obstacles.forEach(function (obstacle, index) {
                obstacle.style.left = parseInt(obstacle.style.left) - 10 + "px";
                if (parseInt(obstacle.style.left) < -50) {
                    obstacle.remove();
                    obstacles.splice(index, 1);
                    score++;
                    scoreboard.innerText = "Score: " + score;
                }
                checkCollision(obstacle);
            });

            clouds.forEach(function (cloud, index) {
                cloud.style.left = parseInt(cloud.style.left) - 1 + "px";
                if (parseInt(cloud.style.left) < -100) {
                    cloud.remove();
                    clouds.splice(index, 1);
                }
            });
        }

        function createObstacle() {
            var obstacle = document.createElement("img");
            obstacle.classList.add("obstacle");
            obstacle.src = "birdimg2.png"; // <-- Use your PNG obstacle image here
            obstacle.style.left = gameArea.offsetWidth + "px";
            obstacle.style.top = Math.random() * (gameArea.offsetHeight - 80) + "px"; // 80 matches obstacle height approx
            gameArea.appendChild(obstacle);
            obstacles.push(obstacle);
        }

        function createCloud() {
            var cloud = document.createElement("div");
            cloud.classList.add("cloud");
            cloud.style.left = gameArea.offsetWidth + "px";
            cloud.style.top = Math.random() * (gameArea.offsetHeight - 60) + "px";
            cloud.innerText = ""; // Optional cloud emoji: "☁️"
            gameArea.appendChild(cloud);
            clouds.push(cloud);
        }

        // Manually adjustable collision detection
        function checkCollision(obstacle) {
            var playerRect = player.getBoundingClientRect();
            var obstacleRect = obstacle.getBoundingClientRect();

            // Adjust collision box for player - shrink by 20px on all sides
            var playerCollision = {
                left: playerRect.left + 10,
                right: playerRect.right - 10,
                top: playerRect.top + 100,
                bottom: playerRect.bottom - 100
            };

            // Adjust collision box for obstacle - shrink by 10px on all sides
            var obstacleCollision = {
                left: obstacleRect.left + 10,
                right: obstacleRect.right - 5,
                top: obstacleRect.top + 100,
                bottom: obstacleRect.bottom - 100
            };

            // Check for overlap
            if (
                playerCollision.left < obstacleCollision.right &&
                playerCollision.right > obstacleCollision.left &&
                playerCollision.top < obstacleCollision.bottom &&
                playerCollision.bottom > obstacleCollision.top
            ) {
                gameOver();
            }
        }

        function gameOver() {
            gameOverPopup.style.display = "block";
            finalScore.innerText = score;
            clearInterval(gameLoopInterval);
            clearInterval(createObstacleInterval);
            clearInterval(createCloudInterval);

            var backgroundVideo = document.getElementById("backgroundVideo");
            backgroundVideo.pause();
        }

        function restartGame() {
            gameOverPopup.style.display = "none";
            startGame();

            var backgroundVideo = document.getElementById("backgroundVideo");
            backgroundVideo.play();
        }

        document.addEventListener("keydown", function (event) {
            if (event.key === "ArrowUp") {
                playerVelocity = lift;
            }
            if (event.key === "ArrowDown") {
                playerVelocity = 5;
            }
            if (event.key === "ArrowLeft") {
                playerX -= playerSpeed;
                if (playerX < 0) playerX = 0;
            }
            if (event.key === "ArrowRight") {
                playerX += playerSpeed;
                if (playerX > gameArea.offsetWidth - player.offsetWidth)
                    playerX = gameArea.offsetWidth - player.offsetWidth;
            }
        });

        function togglePause() {
            isPaused = !isPaused;
            pauseButton.innerText = isPaused ? "Resume" : "Pause";
        }

        startGame();
    </script>
</body>
</html>
