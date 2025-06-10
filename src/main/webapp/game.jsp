<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Snake Game</title>
    <style>
        /* General Styles for Body */
        body {
            font-family: 'Arial', sans-serif;
            text-align: center;
            background-image: url("snakebackground.jpg");
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            height: 100vh;
            color: #fff;
            position: relative; /* For positioning the pause button */
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
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.5);
            background-color: #fff;
            position: absolute;
            top: 130px;
            left: 690px;
        }

        /* Styling for the Score Text */
        #score {
            font-weight: bold;
            font-size: 1.5rem;
        }

        /* Pause Button Styling with red background */
        #pauseBtn {
            position: fixed;
            top: 10px;
            right: 10px;
            background-color: green;  /* bright red */
            color: #fff;
            border: none;
            padding: 10px 15px;
            font-size: 1rem;
            cursor: pointer;
            border-radius: 5px;
            z-index: 1000;
            transition: background-color 0.3s;
        }

        #pauseBtn:hover {
            background-color: #d62828; /* darker red on hover */
        }

        /* Popup styles */
        .popup {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.6);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }

        .popup-content {
            background-color: #222;
            padding: 30px 50px;
            border-radius: 10px;
            text-align: center;
            color: #fff;
            box-shadow: 0 0 15px #0f0;
            min-width: 300px;
        }

        .popup-content h2 {
            margin-top: 0;
            font-size: 2rem;
            margin-bottom: 15px;
        }

        .popup-content p {
            font-size: 1.5rem;
            margin-bottom: 20px;
        }

        .popup-content button {
            background-color: #0a0;
            border: none;
            padding: 10px 20px;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .popup-content button:hover {
            background-color: #0f0;
        }

        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <button id="pauseBtn">Pause</button>
    <h1>Snake Game</h1>
    <canvas id="gameCanvas" width="500" height="500"></canvas>
    <h3>Score: <span id="score">0</span></h3>

    <!-- Popup scoreboard -->
    <div id="scorePopup" class="popup hidden">
        <div class="popup-content">
            <h2>Scoreboard</h2>
            <p>Your Score: <span id="popupScore">0</span></p>
            <button id="closePopupBtn">Close</button>
        </div>
    </div>

    <script>
        const canvas = document.getElementById('gameCanvas');
        const ctx = canvas.getContext('2d');
        const pauseBtn = document.getElementById('pauseBtn');

        // Popup elements
        const scorePopup = document.getElementById('scorePopup');
        const popupScore = document.getElementById('popupScore');
        const closePopupBtn = document.getElementById('closePopupBtn');

        // Load snake head PNG image
        const snakeHeadImg = new Image();
        snakeHeadImg.src = 'snakeimg2.png';

        const segmentSize = 20;
        const headSize = 44;
        const headOffset = (headSize - segmentSize) / 2;

        let snake = [{x: 10, y: 10}];
        let food = {x: 15, y: 15};
        let score = 0;
        let direction = 'RIGHT';
        let gameRunning = false;
        let paused = false;

        snakeHeadImg.onload = function() {
            gameRunning = true;
            gameLoop();
        };

        function gameLoop() {
            if (!gameRunning) return;

            if (!paused) {
                moveSnake();

                if (checkSelfCollision()) {
                    resetGame();
                }
            }

            drawGame();

            setTimeout(gameLoop, 100);
        }

        function drawGame() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            ctx.drawImage(
                snakeHeadImg, 
                snake[0].x * segmentSize - headOffset, 
                snake[0].y * segmentSize - headOffset, 
                headSize, 
                headSize
            );

            snake.slice(1).forEach((segment) => {
                ctx.beginPath();
                ctx.arc(segment.x * segmentSize + segmentSize / 2, segment.y * segmentSize + segmentSize / 2, segmentSize / 2, 0, 2 * Math.PI);
                ctx.fillStyle = 'green';
                ctx.fill();
                ctx.strokeStyle = 'black';
                ctx.stroke();
            });

            ctx.fillStyle = 'red';
            ctx.beginPath();
            ctx.arc(food.x * segmentSize + segmentSize / 2, food.y * segmentSize + segmentSize / 2, 8, 0, 2 * Math.PI);
            ctx.fill();

            document.getElementById('score').innerText = score;

            // If paused, display pause text on canvas
            if (paused) {
                ctx.fillStyle = 'rgba(0, 0, 0, 0.5)';
                ctx.fillRect(0, canvas.height/2 - 30, canvas.width, 60);

                ctx.fillStyle = 'white';
                ctx.font = '40px Arial';
                ctx.textAlign = 'center';
                ctx.fillText('PAUSED', canvas.width / 2, canvas.height / 2 + 15);
            }
        }

        function moveSnake() {
            let head = { ...snake[0] };

            switch (direction) {
                case 'UP': head.y--; break;
                case 'DOWN': head.y++; break;
                case 'LEFT': head.x--; break;
                case 'RIGHT': head.x++; break;
            }

            if (head.x < 0) head.x = canvas.width / segmentSize - 1;
            if (head.x >= canvas.width / segmentSize) head.x = 0;
            if (head.y < 0) head.y = canvas.height / segmentSize - 1;
            if (head.y >= canvas.height / segmentSize) head.y = 0;

            snake.unshift(head);

            if (head.x === food.x && head.y === food.y) {
                score++;
                food = generateFood();
            } else {
                snake.pop();
            }
        }

        function checkSelfCollision() {
            let head = snake[0];
            for (let i = 1; i < snake.length; i++) {
                if (snake[i].x === head.x && snake[i].y === head.y) {
                    return true;
                }
            }
            return false;
        }

        function generateFood() {
            let x, y;
            while (true) {
                x = Math.floor(Math.random() * (canvas.width / segmentSize));
                y = Math.floor(Math.random() * (canvas.height / segmentSize));
                if (!snake.some(segment => segment.x === x && segment.y === y)) break;
            }
            return {x, y};
        }

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

        function resetGame() {
            showScorePopup(); // Show popup on game over
            snake = [{x: 10, y: 10}];
            food = {x: 15, y: 15};
            score = 0;
            direction = 'RIGHT';
        }

        // Popup functions
        function showScorePopup() {
            popupScore.textContent = score;
            scorePopup.classList.remove('hidden');
            paused = true;
            pauseBtn.textContent = 'Resume';
        }

        function hideScorePopup() {
            scorePopup.classList.add('hidden');
            paused = false;
            pauseBtn.textContent = 'Pause';
        }

        // Pause button functionality with popup
        pauseBtn.addEventListener('click', () => {
            paused = !paused;
            if (paused) {
                showScorePopup();
            } else {
                hideScorePopup();
            }
        });

        // Close popup button event
        closePopupBtn.addEventListener('click', () => {
            hideScorePopup();
        });
    </script>
</body>
</html>
