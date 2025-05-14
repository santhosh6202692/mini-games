<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jumping and Moving Game</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }
        #gameArea {
            position: relative;
            width: 500px;
            height: 400px;
            background-color: #8EC6FF;
            overflow: hidden;
            border: 1px solid black;
        }
        #player {
            position: absolute;
            bottom: 0;
            left: 50px;
            width: 50px;
            height: 50px;
            background-color: red;
        }
        #jumpButton {
            position: absolute;
            top: 420px;
            left: 50%;
            transform: translateX(-50%);
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            font-size: 18px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div id="gameArea">
        <div id="player"></div>
    </div>
    <button id="jumpButton">Jump</button>

    <script>
        var player = document.getElementById('player');
        var jumpButton = document.getElementById('jumpButton');
        var jumping = false;
        var playerLeft = 50; // Initial position
        var moveSpeed = 5; // Speed of movement

        // Function to make the player jump
        function jump() {
            if (jumping) return;

            jumping = true;
            var jumpHeight = 150;
            var currentBottom = 0;
            var jumpUpInterval = setInterval(function() {
                if (currentBottom < jumpHeight) {
                    currentBottom += 5;
                    player.style.bottom = currentBottom + 'px';
                } else {
                    clearInterval(jumpUpInterval);
                    var fallDownInterval = setInterval(function() {
                        if (currentBottom > 0) {
                            currentBottom -= 5;
                            player.style.bottom = currentBottom + 'px';
                        } else {
                            clearInterval(fallDownInterval);
                            jumping = false;
                        }
                    }, 20);
                }
            }, 20);
        }

        // Function to move the player left
        function moveLeft() {
            if (playerLeft > 0) {
                playerLeft -= moveSpeed;
                player.style.left = playerLeft + 'px';
            }
        }

        // Function to move the player right
        function moveRight() {
            if (playerLeft < 450) { // Prevent player from moving out of bounds
                playerLeft += moveSpeed;
                player.style.left = playerLeft + 'px';
            }
        }

        // Event listener for jumping
        jumpButton.addEventListener('click', jump);

        // Event listeners for keyboard input
        document.addEventListener('keydown', function(event) {
            if (event.key === 'ArrowLeft' || event.key === 'a') {
                moveLeft();
            }
            if (event.key === 'ArrowRight' || event.key === 'd') {
                moveRight();
            }
        });
    </script>
</body>
</html>
