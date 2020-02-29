PImage[] img = new PImage[10];
PImage[] imgFill = new PImage[10];
int[][] puzzle = new int[10][10];
boolean isEnd;

void setup()
{
  background(200, 230, 230);
  size(700, 870);
  
  img[0] = loadImage("1.png");
  img[1] = loadImage("2.png");
  img[2] = loadImage("3.png");
  img[3] = loadImage("4.png");
  img[4] = loadImage("5.png");
  img[5] = loadImage("6.png");
  img[6] = loadImage("7.png");
  img[7] = loadImage("8.png");
  img[8] = loadImage("9.png");
  img[9] = loadImage("10.png");
  imgFill[0] = loadImage("1_fill.png");
  imgFill[1] = loadImage("2_fill.png");
  imgFill[2] = loadImage("3_fill.png");
  imgFill[3] = loadImage("4_fill.png");
  imgFill[4] = loadImage("5_fill.png");
  imgFill[5] = loadImage("6_fill.png");
  imgFill[6] = loadImage("7_fill.png");
  imgFill[7] = loadImage("8_fill.png");
  imgFill[8] = loadImage("9_fill.png");
  imgFill[9] = loadImage("10_fill.png");
  
  image(loadImage("title.png"), 0, 0);
  image(loadImage("help.png"), 0, 770);
  
  initializePuzzle();
}

void draw()
{
  
}

void mouseClicked()
{
  if(mouseY < 70)
    writeOnScreen("This game is made by haward79.");
  else if(mouseY>770 && mouseY<840)
  {
    writeOnScreen("New game.");
    initializePuzzle();
  }
  else if(mouseY > 840)
    writeOnScreen("Status bar show some instructions for you.");
  else
  {
    if(!isEnd)
      rotatePuzzle((mouseY-70)/70, mouseX/70);
    else
      writeOnScreen("The puzzle has been solved. Click \"HELP\" to start a new game.");
  }
}

void initializePuzzle()
{
  isEnd = false;
  
  for(int i=0; i<10; i++)
    for(int j=0; j<10; j++)
      puzzle[i][j] = (int)random(6);
  puzzle[0][0] = (int)random(2)+6;
  puzzle[9][9] = (int)random(2)+8;
  
  resetPuzzle();
}

void postPuzzle(int no, int indexI, int indexJ, boolean isFill)
{
  if(isFill)
    image(imgFill[no], indexJ*70, indexI*70+70);
  else
    image(img[no], indexJ*70, indexI*70+70);
}

void rotatePuzzle(int indexI, int indexJ)
{
  if(puzzle[indexI][indexJ] > 5)
  {
    writeOnScreen("This puzzle can't be ratated.");
    return ;
  }
  else if(puzzle[indexI][indexJ] == 0)
  {
    puzzle[indexI][indexJ] = 1;
    postPuzzle(1, indexI, indexJ, false);
  }
  else if(puzzle[indexI][indexJ] == 1)
  {
    puzzle[indexI][indexJ] = 0;
    postPuzzle(0, indexI, indexJ, false);
  }
  else
  {
    puzzle[indexI][indexJ]++;
    if(puzzle[indexI][indexJ] == 6)
      puzzle[indexI][indexJ] = 2;
    postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, false);
  }
  
  resetPuzzle();
}

void resetPuzzle()
{
  for(int i=0; i<10; i++)
    for(int j=0; j<10; j++)
      postPuzzle(puzzle[i][j], i, j, false);
  postPuzzle(puzzle[0][0], 0, 0, true);
  checkPuzzle(0, 0, 0);
}

void checkPuzzle(int indexI, int indexJ, int direction)
{
  if(indexI<0 || indexJ<0 || indexI>9 || indexJ>9)
    return ;
  
  if(indexI==0 && indexJ==0)
  {
    if(puzzle[0][0] == 6)
      checkPuzzle(indexI, indexJ+1, 4);
    else
      checkPuzzle(indexI+1, indexJ, 1);
  }
  else if(indexI==9 && indexJ==9)
  {
    if(puzzle[9][9]==8 && direction==4)
    {
      postPuzzle(8, 9, 9, true);
      writeOnScreen("You are right!");
      isEnd = true;
    }
    else if(puzzle[9][9]==9 && direction==1)
    {
      postPuzzle(9, 9, 9, true);
      writeOnScreen("Congratulation! You solved the puzzle.");
      isEnd = true;
    }
  }
  else
  {
    if(puzzle[indexI][indexJ] == 0)
    {
      if(direction == 4)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI, indexJ+1, 4);
      }
      else if(direction == 2)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI, indexJ-1, 2);
      }
    }
    else if(puzzle[indexI][indexJ] == 1)
    {
      if(direction == 1)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI+1, indexJ, 1);
      }
      else if(direction == 3)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI-1, indexJ, 3);
      }
    }
    else if(puzzle[indexI][indexJ] == 2)
    {
      if(direction == 4)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI+1, indexJ, 1);
      }
      else if(direction == 3)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI, indexJ-1, 2);
      }
    }
    else if(puzzle[indexI][indexJ] == 3)
    {
      if(direction == 1)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI, indexJ-1, 2);
      }
      else if(direction == 4)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI-1, indexJ, 3);
      }
    }
    else if(puzzle[indexI][indexJ] == 4)
    {
      if(direction == 1)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI, indexJ+1, 4);
      }
      else if(direction == 2)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI-1, indexJ, 3);
      }
    }
    else if(puzzle[indexI][indexJ] == 5)
    {
      if(direction == 2)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI+1, indexJ, 1);
      }
      else if(direction == 3)
      {
        postPuzzle(puzzle[indexI][indexJ], indexI, indexJ, true);
        checkPuzzle(indexI, indexJ+1, 4);
      }
    }
  }
} //<>//

void writeOnScreen(String input)
{
  fill(200, 230, 230);
  rect(0, 840, width, 30);
  fill(0, 0, 255);
  textFont(createFont("Arial", 20));
  text(input, 10, 860);
}
