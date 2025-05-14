<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Drawing Game</title>

    <!-- Add FontAwesome CDN for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <style>
        /* General reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
       font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-image: url('pencilbg1.jpg'); /* Path to your image */
    background-size: cover; /* Ensure the image covers the whole body */
    background-position: center center; /* Center the image */
    color: #333;
    text-align: center;
    padding: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
        }
       
        

        /* Header */
        h2 {
            color: #2c3e50;
            font-size: 32px;
            margin-bottom: 20px;
            text-transform: uppercase;
        }

        /* Canvas container */
        #drawingCanvas {
            border: 4px solid #3498db;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            cursor: crosshair;
            position: relative;
            border-radius: 8px;
            margin-top: 20px;
            transition: transform 0.3s ease;
        }

        #drawingCanvas:hover {
            transform: scale(1.05);
        }

        /* Undo/Redo buttons */
        .undo-redo-buttons {
            position: absolute;
            top: 10px;
            right: 10px;
            display: flex;
            gap: 12px;
            z-index: 2;
        }

        .undo-redo-btn {
            background: transparent;
            border: none;
            font-size: 28px;
            color: #2c3e50;
            cursor: pointer;
            transition: color 0.2s ease;
            border-radius: 50%;
            padding: 8px;
        }

        .undo-redo-btn:hover {
            color: #3498db;
            background-color: rgba(52, 152, 219, 0.1);
        }

        /* Control Panel */
        .controls {
            margin-top: 30px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
        }

        button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        button:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        button:active {
            transform: translateY(2px);
        }

        /* Color Picker & Tool Controls */
        .color-picker, .shape-picker, .tool-picker {
            margin: 15px 0;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
            font-size: 16px;
        }

        input[type="color"], select {
            padding: 8px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            background-color: #ecf0f1;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        input[type="color"]:focus, select:focus {
            outline: none;
            box-shadow: 0 0 8px rgba(52, 152, 219, 0.5);
        }

        /* View Saved Drawings */
        #drawingsContainer {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .drawing-thumbnail {
            width: 120px;
            height: 120px;
            position: relative;
            overflow: hidden;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .drawing-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 8px;
        }

        .drawing-thumbnail button {
            position: absolute;
            bottom: 8px;
            left: 50%;
            transform: translateX(-50%);
            padding: 5px 10px;
            font-size: 12px;
            background-color: #27ae60;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease;
        }

        .drawing-thumbnail button:hover {
            background-color: #2ecc71;
        }

        .drawing-thumbnail button:active {
            background-color: #16a085;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            #drawingCanvas {
                width: 100%;
                height: auto;
            }

            .controls {
                flex-direction: column;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
    <h2>Welcome to the Drawing Game!</h2>

    <!-- Canvas to simulate drawing -->
    <div style="position: relative;">
        <canvas id="drawingCanvas" width="600" height="400"></canvas>

        <!-- Undo and Redo Buttons with FontAwesome icons inside the canvas container -->
        <div class="undo-redo-buttons">
            <button id="undoBtn" class="undo-redo-btn">
                <i class="fas fa-arrow-left"></i> <!-- FontAwesome icon for Undo -->
            </button>
            <button id="redoBtn" class="undo-redo-btn">
                <i class="fas fa-arrow-right"></i> <!-- FontAwesome icon for Redo -->
            </button>
        </div>
    </div>

    <div class="controls">
        <button id="clearBtn">Clear</button>
        <button id="saveBtn">Save Drawing</button>
        <button id="viewBtn">View Drawings</button>
    </div>

    <div class="color-picker">
        <label for="colorPicker">Choose a stroke color:</label>
        <input type="color" id="colorPicker" value="#000000">
    </div>

    <div class="color-picker">
        <label for="fillColorPicker">Choose a fill color:</label>
        <input type="color" id="fillColorPicker" value="#FFFFFF">
    </div>

    <div class="tool-picker">
        <label for="toolPicker">Choose Tool:</label>
        <select id="toolPicker">
            <option value="brush">Brush</option>
            <option value="eraser">Eraser</option>
        </select>
    </div>

    <div class="shape-picker">
        <label for="shapePicker">Choose a shape:</label>
        <select id="shapePicker">
            <option value="line">Line</option>
            <option value="rectangle">Rectangle</option>
            <option value="circle">Circle</option>
        </select>
    </div>

    <div id="drawingDataDisplay"></div>

    <div id="drawingsContainer"></div>

    <script>
        const canvas = document.getElementById("drawingCanvas");
        const ctx = canvas.getContext("2d");

        let drawing = false;
        let currentStrokeColor = "#000000";
        let currentFillColor = "#FFFFFF";
        let currentShape = "line";
        let currentTool = "brush";
        let startX, startY;

        ctx.lineWidth = 2;
        ctx.lineCap = 'round';
        ctx.strokeStyle = currentStrokeColor;

        // Stack to store canvas states for undo/redo
        let history = [];
        let currentHistoryIndex = -1;

        // Save the current state of the canvas to history stack
        function saveHistory() {
            if (currentHistoryIndex < history.length - 1) {
                history = history.slice(0, currentHistoryIndex + 1); // Remove future states if any
            }
            history.push(canvas.toDataURL());
            currentHistoryIndex++;
        }

        // Redraw the canvas from a saved state
        function loadHistory() {
            if (currentHistoryIndex >= 0 && currentHistoryIndex < history.length) {
                const dataUrl = history[currentHistoryIndex];
                const img = new Image();
                img.onload = function() {
                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                    ctx.drawImage(img, 0, 0);
                };
                img.src = dataUrl;
            }
        }

        // Mouse events for drawing
        canvas.addEventListener("mousedown", (event) => {
            drawing = true;
            startX = event.offsetX;
            startY = event.offsetY;
            ctx.beginPath();
            ctx.moveTo(startX, startY);
        });

        canvas.addEventListener("mousemove", (event) => {
            if (drawing) {
                if (currentTool === "brush") {
                    if (currentShape === "line") {
                        ctx.lineTo(event.offsetX, event.offsetY);
                        ctx.stroke();
                    }
                } else if (currentTool === "eraser") {
                    ctx.clearRect(event.offsetX - 10, event.offsetY - 10, 20, 20);
                }
            }
        });

        canvas.addEventListener("mouseup", (event) => {
            drawing = false;
            if (currentShape === "rectangle") {
                const width = event.offsetX - startX;
                const height = event.offsetY - startY;
                if (currentTool === "brush") {
                    ctx.fillStyle = currentFillColor;
                    ctx.fillRect(startX, startY, width, height);
                    ctx.strokeRect(startX, startY, width, height);
                } else if (currentTool === "eraser") {
                    ctx.clearRect(startX, startY, width, height);
                }
            } else if (currentShape === "circle") {
                const radius = Math.sqrt(Math.pow(event.offsetX - startX, 2) + Math.pow(event.offsetY - startY, 2));
                ctx.beginPath();
                ctx.arc(startX, startY, radius, 0, 2 * Math.PI);
                if (currentTool === "brush") {
                    ctx.fillStyle = currentFillColor;
                    ctx.fill();
                    ctx.stroke();
                } else if (currentTool === "eraser") {
                    ctx.clearRect(startX - radius, startY - radius, 2 * radius, 2 * radius);
                }
            }
            saveHistory(); // Save after each action
        });

        // Clear the canvas
        document.getElementById("clearBtn").addEventListener("click", () => {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            saveHistory(); // Save the cleared state
        });

        // Save drawing
        document.getElementById("saveBtn").addEventListener("click", () => {
            const dataUrl = canvas.toDataURL();
            let savedDrawings = JSON.parse(localStorage.getItem("drawings")) || [];
            savedDrawings.unshift(dataUrl);
            if (savedDrawings.length > 5) {
                savedDrawings = savedDrawings.slice(0, 5);
            }
            localStorage.setItem("drawings", JSON.stringify(savedDrawings));
            alert("Drawing Saved!");
        });

        // View saved drawings
        document.getElementById("viewBtn").addEventListener("click", () => {
            const savedDrawings = JSON.parse(localStorage.getItem("drawings")) || [];
            const container = document.getElementById("drawingsContainer");
            container.innerHTML = '';
            if (savedDrawings.length === 0) {
                container.innerHTML = '<p>No saved drawings yet.</p>';
            } else {
                savedDrawings.forEach((drawing, index) => {
                    const img = new Image();
                    img.src = drawing;
                    img.classList.add('drawing-thumbnail');
                    img.onclick = function() {
                        const imgDisplay = document.getElementById("drawingDataDisplay");
                        imgDisplay.innerHTML = '<h3>Your Drawing:</h3>';
                        imgDisplay.appendChild(img);
                    };

                    const downloadBtn = document.createElement('button');
                    downloadBtn.classList.add('download-btn');
                    downloadBtn.innerText = 'Download';
                    downloadBtn.onclick = function() {
                        const link = document.createElement('a');
                        link.href = drawing;
                        link.download = `drawing-${index + 1}.png`;
                        link.click();
                    };

                    const thumbnailContainer = document.createElement('div');
                    thumbnailContainer.classList.add('drawing-thumbnail');
                    thumbnailContainer.appendChild(img);
                    thumbnailContainer.appendChild(downloadBtn);
                    container.appendChild(thumbnailContainer);
                });
            }
        });

        // Update stroke color
        document.getElementById("colorPicker").addEventListener("input", (event) => {
            currentStrokeColor = event.target.value;
            ctx.strokeStyle = currentStrokeColor;
        });

        // Update fill color
        document.getElementById("fillColorPicker").addEventListener("input", (event) => {
            currentFillColor = event.target.value;
        });

        // Update shape
        document.getElementById("shapePicker").addEventListener("change", (event) => {
            currentShape = event.target.value;
        });

        // Update tool
        document.getElementById("toolPicker").addEventListener("change", (event) => {
            currentTool = event.target.value;
            if (currentTool === "brush") {
                ctx.globalCompositeOperation = "source-over";
            } else if (currentTool === "eraser") {
                ctx.globalCompositeOperation = "destination-out";
            }
        });

        // Undo action
        document.getElementById("undoBtn").addEventListener("click", () => {
            if (currentHistoryIndex > 0) {
                currentHistoryIndex--;
                loadHistory();
            }
        });

        // Redo action
        document.getElementById("redoBtn").addEventListener("click", () => {
            if (currentHistoryIndex < history.length - 1) {
                currentHistoryIndex++;
                loadHistory();
            }
        });

        // Save initial canvas state
        saveHistory();
    </script>
</body>
</html>
