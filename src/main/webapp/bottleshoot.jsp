<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Tennis Game</title>
<style>
    body {
        font-family: Arial, sans-serif;
        text-align: center;
        background-color:#00BFFF;
        color: #333;
        margin: 0;
        padding: 0;
    }
    h1 {
        color:black;
        margin-top: 20px;
    }

    /* Container to hold both score boxes side by side */
    .scoreboard-container {
        display: flex;
        justify-content: center;
        gap: 50px;
        margin: 30px 0 20px 0;
    }

    /* Individual player score boxes */
    .scoreboard-box {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 15px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        padding: 25px 50px;
        width: 200px;
        display: flex;
        flex-direction: column;
        align-items: center;
        font-weight: 700;
        color: #007acc;
        position: relative;
        transition: transform 0.3s ease;
    }

    /* Hover effect on scoreboard boxes */
    .scoreboard-box:hover {
        transform: scale(1.05);
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.25);
    }

    /* Circle icon before player name */
    .scoreboard-box::before {
        content: "";
        position: absolute;
        top: 20px;
        left: 20px;
        border-radius: 50%;
        background-color: #ff6347;
    }

    /* Different colors for Player 1 and Player 2 circles */
    .player1::before {
        background-color: #ff6347; /* tomato red */
    }
    .player2::before {
        background-color: #007acc; /* blue */
    }

    .player-name {
        font-size: 22px;
        margin-bottom: 15px;
        color: #ff6347;
    }

    .player2 .player-name {
        color: #007acc;
    }

    .score-number {
        font-size: 48px;
        color: #ff6347;
    }
    .player2 .score-number {
        color: #007acc;
    }

    #gameCanvas {
        border: 2px solid #333;
        background-color: #c1e0ff;
        margin-top: 20px;
    }
    button {
        padding: 10px 20px;
        font-size: 18px;
        background-color: #ff6347;
        color: white;
        border: none;
        cursor: pointer;
        margin-bottom: 10px;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }
    button:hover {
        background-color: #ff4500;
    }
    
    /* Modal background */
    #gameOverModal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100vw;
        height: 100vh;
        background: rgba(0,0,0,0.6);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* Modal content box */
    #gameOverContent {
        background: white;
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        max-width: 400px;
        text-align: center;
    }

    #gameOverContent h2 {
        color: #ff6347;
        margin-bottom: 20px;
        font-size: 28px;
    }

    #gameOverContent button {
        background-color: #00BFFF;
        color: white;
        font-size: 20px;
        padding: 12px 25px;
        border-radius: 8px;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    #gameOverContent button:hover {
        background-color: #007acc;
    }
</style>
</head>
<body>
<h1>Tennis Game</h1>

<button id="startButton">Start Game</button>

<!-- Scoreboard container with two separate boxes -->
<div class="scoreboard-container">
    <div class="scoreboard-box player1">
        <div class="player-name">Player 1 Score</div>
        <div id="player1Score" class="score-number">0</div>
    </div>
    <div class="scoreboard-box player2">
        <div class="player-name">Player 2 Score</div>
        <div id="player2Score" class="score-number">0</div>
    </div>
</div>

<canvas id="gameCanvas" width="1100" height="600"></canvas>

<!-- Modal for Game Over -->
<div id="gameOverModal">
    <div id="gameOverContent">
        <h2 id="winnerText">Mini Tennis</h2>
        <button id="restartButton">Start Game</button>
    </div>
</div>

<script>
    const canvas = document.getElementById("gameCanvas");
    const ctx = canvas.getContext("2d");

    let player1Score = 0;
    let player2Score = 0;

    // Paddle size
    const paddleWidth = 150;
    const paddleHeight = 150;
    const ballRadius = 10;

    // Initial paddle positions (top-left corner)
    let player1X = 0;
    let player1Y = canvas.height / 2 - paddleHeight / 2;

    let player2X = canvas.width - paddleWidth;
    let player2Y = canvas.height / 2 - paddleHeight / 2;

    let ballX = canvas.width / 2;
    let ballY = canvas.height / 2;
    let ballDX = 3;
    let ballDY = 0;

    let isGameActive = false;

    const playerSpeed = 10;
    const ballSpeed = 4;
    const winningScore = 5;  // Points needed to win

    const player1ScoreElement = document.getElementById("player1Score");
    const player2ScoreElement = document.getElementById("player2Score");

    // Modal elements
    const gameOverModal = document.getElementById("gameOverModal");
    const winnerText = document.getElementById("winnerText");
    const restartButton = document.getElementById("restartButton");
    const startButton = document.getElementById("startButton");

    // Player images
    const player1Img = new Image();
    player1Img.src = "player1.png"; // update path if needed

    const player2Img = new Image();
    player2Img.src = "player2.png"; // update path if needed

    // Background image for canvas
    const backgroundImg = new Image();
    backgroundImg.src = "tenniscourt.avif";

    function drawPaddles() {
        ctx.drawImage(player1Img, player1X, player1Y, paddleWidth, paddleHeight);
        ctx.drawImage(player2Img, player2X, player2Y, paddleWidth, paddleHeight);
    }

    function drawBall() {
        ctx.fillStyle = "yellow";
        ctx.beginPath();
        ctx.arc(ballX, ballY, ballRadius, 0, Math.PI * 2);
        ctx.fill();
        ctx.closePath();
    }

    function drawNet() {
        ctx.strokeStyle = "#000";
        ctx.lineWidth = 2;
        ctx.setLineDash([5, 5]);
        ctx.beginPath();
        ctx.moveTo(canvas.width / 2, 0);
        ctx.lineTo(canvas.width / 2, canvas.height);
        ctx.stroke();
        ctx.setLineDash([]);
        ctx.lineWidth = 1;
    }

    // Show modal popup for game over message
    function showGameOverPopup(winner) {
        winnerText.textContent = `${winner} wins the game! 🎉`;
        gameOverModal.style.display = "flex";
        isGameActive = false;
    }

    function updateBall() {
        ballX += ballDX * ballSpeed;
        ballY += ballDY * ballSpeed;

        // Bounce on top/bottom edges
        if (ballY - ballRadius < 0 || ballY + ballRadius > canvas.height) {
            ballDY = -ballDY;
        }

        // Bounce off Player 1 paddle
        if (
            ballX - ballRadius < player1X + paddleWidth &&
            ballX - ballRadius > player1X &&
            ballY > player1Y &&
            ballY < player1Y + paddleHeight
        ) {
            ballDX = -ballDX;
            ballDY = ((ballY - (player1Y + paddleHeight / 2)) / (paddleHeight / 2)) * 5;
        }

        // Bounce off Player 2 paddle
        if (
            ballX + ballRadius > player2X &&
            ballX + ballRadius < player2X + paddleWidth &&
            ballY > player2Y &&
            ballY < player2Y + paddleHeight
        ) {
            ballDX = -ballDX;
            ballDY = ((ballY - (player2Y + paddleHeight / 2)) / (paddleHeight / 2)) * 5;
        }

        // Check if Player 1 missed (ball beyond left edge)
        if (ballX - ballRadius < 0) {
            player2Score++;
            player2ScoreElement.textContent = player2Score;
            if (player2Score >= winningScore) {
                showGameOverPopup("Player 2");
            } else {
                resetBall();
            }
        }

        // Check if Player 2 missed (ball beyond right edge)
        if (ballX + ballRadius > canvas.width) {
            player1Score++;
            player1ScoreElement.textContent = player1Score;
            if (player1Score >= winningScore) {
                showGameOverPopup("Player 1");
            } else {
                resetBall();
            }
        }
    }

    function movePlayer1Paddle(e) {
        if (!isGameActive) return;

        switch (e.key.toLowerCase()) {
            case "w": // Up
                if (player1Y > 0) player1Y -= playerSpeed;
                break;
            case "s": // Down
                if (player1Y + paddleHeight < canvas.height) player1Y += playerSpeed;
                break;
            case "a": // Left (within left half)
                if (player1X > 0) player1X -= playerSpeed;
                break;
            case "d": // Right (limit to middle line)
                if (player1X + paddleWidth + playerSpeed <= canvas.width / 2)
                    player1X += playerSpeed;
                break;
        }
    }

    function movePlayer2Paddle(e) {
        if (!isGameActive) return;

        switch (e.key) {
            case "ArrowUp":
                if (player2Y > 0) player2Y -= playerSpeed;
                break;
            case "ArrowDown":
                if (player2Y + paddleHeight < canvas.height) player2Y += playerSpeed;
                break;
            case "ArrowRight": // Move right (limit to right side)
                if (player2X + paddleWidth + playerSpeed <= canvas.width)
                    player2X += playerSpeed;
                break;
            case "ArrowLeft": // Move left (limit not to cross middle line)
                if (player2X - playerSpeed >= canvas.width / 2)
                    player2X -= playerSpeed;
                break;
        }
    }

    function resetBall() {
        ballX = canvas.width / 2;
        ballY = canvas.height / 2;
        ballDX = 3 * (Math.random() > 0.5 ? 1 : -1);
        ballDY = 0;
    }

    function startGame() {
        if (!player1Img.complete || !player2Img.complete || !backgroundImg.complete) {
            alert("Loading images, please wait a moment and try again.");
            return;
        }

        isGameActive = true;
        player1Score = 0;
        player2Score = 0;
        player1ScoreElement.textContent = player1Score;
        player2ScoreElement.textContent = player2Score;

        resetBall();

        document.removeEventListener("keydown", keydownHandler);
        document.addEventListener("keydown", keydownHandler);

        startButton.style.display = "none"; // Hide start button when game starts

        gameOverModal.style.display = "none"; // Hide modal in case it was open

        gameLoop();
    }

    function keydownHandler(e) {
        movePlayer1Paddle(e);
        movePlayer2Paddle(e);
    }

    restartButton.addEventListener("click", () => {
        gameOverModal.style.display = "none";
        startGame();
    });

    startButton.addEventListener("click", () => {
        if (player1Img.complete && player2Img.complete && backgroundImg.complete) {
            startGame();
        } else {
            alert("Images are still loading, please wait a moment.");
        }
    });

    function gameLoop() {
        if (!isGameActive) return;

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        if (backgroundImg.complete) {
            const bgWidth = 1400;
            const bgHeight = 1000;
            const bgX = (canvas.width - bgWidth) / 2;
            const bgY = (canvas.height - bgHeight) / 2;
            ctx.drawImage(backgroundImg, bgX, bgY, bgWidth, bgHeight);
        } else {
            ctx.fillStyle = "#c1e0ff";
            ctx.fillRect(0, 0, canvas.width, canvas.height);
        }

        drawNet();
        drawPaddles();
        drawBall();
        updateBall();

        requestAnimationFrame(gameLoop);
    }
</script>
</body>
</html>
