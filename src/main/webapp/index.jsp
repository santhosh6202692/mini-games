<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mini Games Website</title>
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-image: url('gaming.jpg');  /* Replace with your background image path */
            background-size: cover;
            background-position:  -20px -137px;
            background-attachment: fixed; 
            color: white;
        }

        h1, h2, h3 {
            font-family: 'Arial', sans-serif;
            color: #fff;
        }

        /* Header Styles */
        header {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 47px;
            position: sticky;
            top: 0;
            z-index: 20;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header .logo h1 {
            font-size: 36px;
            letter-spacing: 2px;
            margin-left:-180px;
        }

        /* Search Box */
        .search-box {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .search-box input[type="text"] {
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: none;
            width: 200px;
            margin-right: 10px;
        }

        .search-box button {
            padding: 10px;
            background-color: #f39c12;
            border: none;
            border-radius: 5px;
            color: white;
            cursor: pointer;
        }

        .search-box button:hover {
            background-color: #e67e22;
        }

        /* Modal Styles */
        /* Hidden Modal */
        #aboutUsModal {
            display: none;
        }

       /* About Us button styling */
#aboutUsBtn {
    cursor: pointer;
    background: transparent;
    border: none;
    color: white;
    font-size: 16px;
    font-weight: 600;
    transition: color 0.3s ease, transform 0.1s ease;
}
#aboutUsBtn:hover {
    color: #ffcc00;
}
#aboutUsBtn:active {
    color: #ff9900;
    transform: scale(0.95);
}

/* Modal (Popup) */
#aboutUsModal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.8);
    display: none;
    z-index: 100;
    justify-content: center;
    align-items: center;
    opacity: 0;
    transition: opacity 0.3s ease;
}

/* Show modal when checkbox is checked */
#aboutUsTrigger:checked ~ #aboutUsModal {
    display: flex;
    opacity: 1;
}

/* Modal Content */
.modal-content {
    background-color: #333;
    padding: 30px;
    border-radius: 10px;
    width: 70%;
    max-width: 600px;
    color: white;
    font-size: 18px;
    text-align: center;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    position: relative;
}

/* Modal Title */
.modal-content h2 {
    font-size: 30px;
    margin-bottom: 15px;
    color: #f39c12;
    text-transform: uppercase;
}

/* Close Button */
.close {
    color: #aaa;
    font-size: 28px;
    font-weight: bold;
    position: absolute;
    top: 10px;
    right: 15px;
    cursor: pointer;
    transition: color 0.2s ease;
}

.close:hover,
.close:focus {
    color: white;
}
       

        /* Modal Background */
        #aboutUsModal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            display: none;
            z-index: 100;
            justify-content: center;
            align-items: center;
        }

        /* Modal Content */
        .modal-content {
            background-color: #333;
            padding: 30px;
            border-radius: 10px;
            width: 70%;
            max-width: 600px;
            color: white;
            font-size: 18px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        /* Modal Title */
        .modal-content h2 {
            font-size: 30px;
            margin-bottom: 15px;
            color: #f39c12;
            text-transform: uppercase;
        }

        /* Modal Paragraph */
        .modal-content p {
            font-size: 18px;
            line-height: 1.6;
        }

        /* Close Button */
        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 15px;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: white;
        }

        /* Main Section */
        main {
            padding: 40px 20px;
            text-align: center;
            margin: 100px 100px 80px 250px;
        }

        .welcome {
            margin-bottom: 30px;
        }

        .welcome h2 {
            font-size: 32px;
            margin-bottom: 20px;
        }

        .welcome p {
            font-size: 20px;
        }

        .games {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 150px;
            height: 300px;
            margin-top: 12%;
            margin-left: -10%;
        }

        .game {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 20px;
            border-radius: 10px;
            height : 300px;
            position: relative;
            color: white;
        }
        .game h3 {
            font-size: 24px;
            margin-bottom: 15px;
        }

        .game a {
            color: #f39c12;
            font-size: 18px;
            text-decoration: none;
            background-color: #222;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            position: absolute;
            bottom: 15px;
            left: 75px;
        }

        .game a:hover {
            background-color: #f39c12;
            color: #222;
        }
        
        .game1 {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 20px;
            border-radius: 10px;
            height : 500px;
            position: relative;
            color: white;
        }
        .game1 h3 {
            font-size: 24px;
            margin-bottom: 15px;
        }
        .game1 a {
            color: #f39c12;
            font-size: 18px;
            text-decoration: none;
            background-color: #222;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            position: absolute;
            bottom: 100px;
            left: 80px;
        }
        .game1 a:hover {
            background-color: #f39c12;
            color: #222;
        }

        /* Footer Styles */
        footer {
            background-color: rgba(0, 0, 0, 0.8);
            color: white;
            text-align: center;
            padding: 40px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        footer p {
            font-size: 14px;
        }

        /* Popup Overlay for Search No Results */
        .popup-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.75);
            z-index: 150;
            justify-content: center;
            align-items: center;
        }

        /* Popup Content */
        .popup-content {
            background-color: #333;
            padding: 25px 35px;
            border-radius: 12px;
            max-width: 400px;
            width: 80%;
            color: #f39c12;
            font-size: 20px;
            text-align: center;
            box-shadow: 0 0 15px #f39c12;
            position: relative;
        }

        /* Close Button */
        .popup-close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 28px;
            color: #f39c12;
            cursor: pointer;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .popup-close:hover {
            color: white;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <!-- Left side (Search Box) -->
        <div class="search-box">
            <input type="text" id="search" placeholder="Search for games..." oninput="searchGame()" />
            <button onclick="searchGame()">Search</button>
        </div>

        <!-- Logo -->
        <div class="logo">
            <h1>Mini Games Hub</h1>
        </div>

     <!-- Right side (About Us - Trigger for Modal) -->
<nav>
    <button id="aboutUsBtn" type="button" 
        onclick="document.getElementById('aboutUsTrigger').checked = true;"
        onmouseover="this.style.color='#ffcc00';"
        onmouseout="this.style.color='white';"
        onmousedown="this.style.color='#ff9900';"
        onmouseup="this.style.color='#ffcc00';"
        style="
            cursor: pointer; 
            color: white; 
            font-size: 16px; 
            background: transparent; 
            border: none; 
            font-weight: 600; 
            transition: color 0.3s ease, transform 0.1s ease;">
        About Us
    </button>
</nav>

    </header>

    <!-- Modal (Popup) -->
    <input type="checkbox" id="aboutUsTrigger" style="display:none;">
    <div id="aboutUsModal">
        <div class="modal-content">
            <span class="close" onclick="document.getElementById('aboutUsTrigger').checked = false;">&times;</span>
            <h2>About Us</h2>
            <p>Welcome to Mini Games Hub! We are passionate about providing exciting, accessible, and fun games to players of all ages. Whether you're here to challenge your friends, pass the time, or learn new skills, we have something for everyone!</p>
            <p>Our mission is simple: to offer a great selection of games that entertain and engage. We are constantly adding new games and improving existing ones. Stay tuned for more updates!</p>
        </div>
    </div>

    <!-- Main Content -->
    <main>
        <section class="welcome">
            <h2 style="margin-right: 8%; font-size:150%;">Welcome to the Mini Games Website!</h2>
        </section>

        <!-- Games Section -->
        <section class="games">
            <div class="game" style="background-image: url('trivia game.jfif'); background-size: cover; background-position: center;">
                <h3 style="margin-top: -5%;">Trivia Game</h3>
        <a href="game1.jsp">Start Game</a>
            </div>

            <div class="game" style="background-image: url('snakeimg.png'); background-size: cover; background-position: center;">
                <h3 style="margin-top: -5%;">Snake Game</h3>
                <a href="game.jsp">Start Game</a>
            </div>

            <div class="game" style="background-image: url('rockimg1.jpg'); background-size: 130%; background-position: center;">
                <h3 style="margin-top: -5%; font-size:22px;">Rock Paper Scissors</h3>
                <a href="rockPaperScissors.jsp">Start Game</a>
            </div>

            <div class="game" style="background-image: url('guessimg.jfif'); background-size: 180%; background-position: -116px -30px;">
                <h3 style="margin-top: -5%;">Guess the Number</h3>
                <a href="guessTheNumber.jsp">Start Game</a>
            </div>
            
            <div class="game1" style="background-image: url('aeroplaneindex.png'); background-size: 160%; background-position: -95px 50px;">
                <h3 style="margin-top: -5%;">Flying game</h3>
                <a href="jumping.jsp">Start Game</a>
            </div>
            
            <div class="game1" style="background-image: url('pencil4.png'); background-size: 130%; background-position:-40px 10px;">
                <h3 style="margin-top: -5%;">Drawing game</h3>
                <a href="draw.jsp">Start Game</a>
            </div>
 
            <div class="game1" style="background-image: url('car01.avif'); background-size: 160%; background-position: -100px 10px;">
                <h3 style="margin-top: -5%;">Car game</h3>
                <a href="car.jsp">Start Game</a>
            </div>
            
            <div class="game1" style="background-image: url('tennisimg.jfif'); background-size: 130%; background-position: -50px -100px;">
                <h3 style="margin-top: -5%;">Tennis game</h3>
                <a href="bottleshoot.jsp">Start Game</a>
            </div>
        </section>
    </main>

    <!-- Search No Results Popup -->
    <div id="searchNoResultsPopup" class="popup-overlay">
        <div class="popup-content">
            <span class="popup-close" onclick="closeSearchPopup()">&times;</span>
            <p id="searchNoResultsMessage"></p>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Mini Games Hub. All rights reserved.</p>
    </footer>

    <script>
        function searchGame() {
            let query = document.getElementById("search").value.toLowerCase().trim();
            const games = document.querySelectorAll(".game, .game1");

            if (!query) {
                // Show all games if input is empty
                games.forEach(game => game.style.display = "block");
                closeSearchPopup();
                return;
            }

            let foundAny = false;

            games.forEach(game => {
                const title = game.querySelector("h3").textContent.toLowerCase();
                if (title.startsWith(query)) {  // match only games starting with the query
                    game.style.display = "block";
                    foundAny = true;
                } else {
                    game.style.display = "none";
                }
            });

            if (!foundAny) {
                showSearchPopup("No games found matching: " + query);
            } else {
                closeSearchPopup();
            }
        }

        function showSearchPopup(message) {
            const popup = document.getElementById("searchNoResultsPopup");
            const messageEl = document.getElementById("searchNoResultsMessage");
            messageEl.textContent = message;
            popup.style.display = "flex";
        }

        function closeSearchPopup() {
            document.getElementById("searchNoResultsPopup").style.display = "none";
        }
    </script>

</body>
</html>   
