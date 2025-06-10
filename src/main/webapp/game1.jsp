<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Trivia Game</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background-image: url('tbg.jpg');
    background-size: 100%;
    background-position: 50% -100px;
    background-attachment: fixed;
    color: white;
    text-align: center;
    padding: 50px 0;
  }
  h2 {
    font-size: 36px;
    margin-top: 80px;
  }
  form {
    background-color: rgba(0, 0, 0, 0.6);
    padding: 20px;
    border-radius: 10px;
    display: inline-block;
    width: 100%;
    max-width: 400px;
  }
  label {
    font-size: 18px;
    margin-bottom: 10px;
    display: block;
  }
  input[type="text"] {
    padding: 10px;
    width: 100%;
    font-size: 16px;
    margin-bottom: 20px;
    border-radius: 5px;
    border: none;
  }
  button {
    padding: 10px 20px;
    background-color: #f39c12;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    color: white;
  }
  button:hover {
    background-color: #e67e22;
  }
  #result {
    margin-top: 20px;
    font-size: 20px;
    min-height: 24px;
  }
  #timer {
    font-size: 18px;
    margin-bottom: 15px;
    font-weight: bold;
    color: white; /* Explicitly set white color */
    min-height: 24px; /* Reserve space */
  }
  #restartBtn {
    margin-top: 20px;
    display: none;
  }
</style>
</head>
<body>

<h2>Trivia Game</h2>

<form id="triviaForm">
  <div id="timer"></div>
  <label id="questionLabel" for="answer"></label>
  <input type="text" id="answer" name="answer" autocomplete="off" required style="margin-left: -9px;" />
  <button type="submit">Submit Answer</button>
</form>

<div id="result"></div>
<button id="restartBtn">Restart Quiz</button>

<!-- Hidden form to send result to Servlet -->
<form id="resultForm" method="POST" action="Game1Servlet" style="display:none;">
  <input type="hidden" name="percentage" id="percentageInput" />
</form>

<script>
  const questions = [
    { question: "What is 2 + 2?", answer: "4" },
    { question: "What is 287 - 112?", answer: "175" },
    { question: "What is 315 % 8?", answer: "3" },
    { question: "What is 23456 * 2?", answer: "46912" },
    { question: "What is 987652 + 23452?", answer: "1012104" },
    { question: "What is 0 * 2?", answer: "0" }
  ];

  let currentQuestionIndex = 0;
  let correctCount = 0;
  const timeLimit = 5;
  let timerInterval;

  const form = document.getElementById('triviaForm');
  const questionLabel = document.getElementById('questionLabel');
  const answerInput = document.getElementById('answer');
  const resultDiv = document.getElementById('result');
  const timerDiv = document.getElementById('timer');
  const restartBtn = document.getElementById('restartBtn');
  const resultForm = document.getElementById('resultForm');
  const percentageInput = document.getElementById('percentageInput');

  function startTimer() {
    let secondsElapsed = 0;
    timerDiv.textContent = `Time limit : 5s`;
    console.log('Timer started');

    clearInterval(timerInterval);
    timerInterval = setInterval(() => {
      secondsElapsed++;
      timerDiv.textContent = `Time limit : 5s`;
      console.log(`Timer: ${secondsElapsed}s`);

      if (secondsElapsed >= timeLimit) {
        clearInterval(timerInterval);
        resultDiv.style.color = 'lightcoral';
        resultDiv.textContent = `Time's up!  ${questions[currentQuestionIndex].answer}.`;
        currentQuestionIndex++;
        setTimeout(loadQuestion, 2000);
      }
    }, 1000);
  }

  function loadQuestion() {
    clearInterval(timerInterval);

    if (currentQuestionIndex < questions.length) {
      questionLabel.textContent = questions[currentQuestionIndex].question;
      answerInput.value = '';
      answerInput.style.display = 'inline-block';
      form.querySelector('button').style.display = 'inline-block';
      answerInput.disabled = false;
      form.querySelector('button').disabled = false;
      answerInput.focus();
      resultDiv.textContent = '';
      restartBtn.style.display = 'none';
      startTimer();
    } else {
      // Quiz finished, submit result to server
      questionLabel.textContent = "Quiz completed!";
      answerInput.style.display = 'none';
      form.querySelector('button').style.display = 'none';
      timerDiv.textContent = '';
      clearInterval(timerInterval);

      const totalQuestions = questions.length;
      const percentage = totalQuestions > 0 ? (correctCount / totalQuestions) * 100 : 0;

      percentageInput.value = percentage.toFixed(2);
      resultForm.submit();
    }
  }

  form.addEventListener('submit', function(e) {
    e.preventDefault();
    clearInterval(timerInterval);

    const userAnswer = answerInput.value.trim();
    if (userAnswer === '') {
      resultDiv.style.color = 'lightcoral';
      resultDiv.textContent = "Please enter an answer.";
      return;
    }

    const correctAnswer = questions[currentQuestionIndex].answer;

    const userAnswerNum = Number(userAnswer);
    const correctAnswerNum = Number(correctAnswer);
    let isCorrect = false;

    if (!isNaN(userAnswerNum) && !isNaN(correctAnswerNum)) {
      isCorrect = userAnswerNum === correctAnswerNum;
    } else {
      isCorrect = userAnswer.toLowerCase() === correctAnswer.toLowerCase();
    }

    if (isCorrect) {
      correctCount++;
      resultDiv.style.color = 'lightgreen';
      resultDiv.textContent = "Correct!";
    } else {
      resultDiv.style.color = 'lightcoral';
      resultDiv.textContent = `Wrong!  ${correctAnswer}`;
    }

    currentQuestionIndex++;
    answerInput.disabled = true;
    form.querySelector('button').disabled = true;

    setTimeout(() => {
      form.querySelector('button').disabled = false;
      loadQuestion();
    }, 1000);
  });

  restartBtn.addEventListener('click', () => {
    currentQuestionIndex = 0;
    correctCount = 0;
    restartBtn.style.display = 'none';
    answerInput.style.display = 'inline-block';
    answerInput.disabled = false;
    form.querySelector('button').style.display = 'inline-block';
    loadQuestion();
  });

  loadQuestion();
</script>

</body>
</html>
