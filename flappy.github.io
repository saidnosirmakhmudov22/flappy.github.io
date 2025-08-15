<p class="bubble">
  <a href="flappy.html">🎮 Play Flappy Bird!</a>
</p>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Flappy Bird - Simple Game</title>
<style>
  body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    background: #a0e8ff; /* sky blue */
    font-family: sans-serif;
    overflow: hidden;
  }
  canvas {
    background: #70c5ce; /* sky background */
    display: block;
    border: 3px solid #333;
    border-radius: 10px;
  }
</style>
</head>
<body>
<canvas id="gameCanvas" width="400" height="600"></canvas>
<script>
const canvas = document.getElementById("gameCanvas");
const ctx = canvas.getContext("2d");

// Game variables
let birdY = 300;
let birdX = 80;
let birdVelocity = 0;
let gravity = 0.6;
let lift = -10;
let pipeWidth = 60;
let pipeGap = 150;
let pipes = [];
let frame = 0;
let score = 0;
let gameOver = false;

// Controls
document.addEventListener("keydown", () => { birdVelocity = lift; });
document.addEventListener("click", () => { birdVelocity = lift; });

// Game loop
function draw() {
  if(gameOver){
    ctx.fillStyle = "black";
    ctx.font = "30px Arial";
    ctx.fillText("Game Over! Score: " + score, 50, 300);
    return;
  }
  
  ctx.clearRect(0,0,canvas.width,canvas.height);
  
  // Bird
  birdVelocity += gravity;
  birdY += birdVelocity;
  ctx.fillStyle = "yellow";
  ctx.fillRect(birdX, birdY, 30, 30);
  
  // Pipes
  if(frame % 90 === 0){
    let pipeTop = Math.floor(Math.random()* (canvas.height - pipeGap - 50)) + 20;
    pipes.push({x: canvas.width, top: pipeTop});
  }
  
  for(let i=0;i<pipes.length;i++){
    let p = pipes[i];
    p.x -= 3;
    
    // Draw top pipe
    ctx.fillStyle = "green";
    ctx.fillRect(p.x, 0, pipeWidth, p.top);
    // Draw bottom pipe
    ctx.fillRect(p.x, p.top + pipeGap, pipeWidth, canvas.height - p.top - pipeGap);
    
    // Collision
    if(birdX + 30 > p.x && birdX < p.x + pipeWidth && (birdY < p.top || birdY + 30 > p.top + pipeGap)){
      gameOver = true;
    }
    
    // Score
    if(p.x + pipeWidth === birdX){
      score++;
    }
  }
  
  // Floor and ceiling collision
  if(birdY + 30 > canvas.height || birdY < 0) gameOver = true;
  
  // Score display
  ctx.fillStyle = "black";
  ctx.font = "20px Arial";
  ctx.fillText("Score: " + score, 10, 25);
  
  frame++;
  requestAnimationFrame(draw);
}


draw();
</script>
</body>
</html>
