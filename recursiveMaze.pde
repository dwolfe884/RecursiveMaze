import java.util.*; //<>//
int h=750;
int w=1000;
//int h=displayHeight;
//int w=displayWidth;
int scale=10;
int col = w/scale;
int rows = h/scale;
int startX = 0;
int startY = 0;
boolean done = false;
Cell nextC;
Cell currCell;
Cell[][] cells = new Cell[col][rows];
Stack<Cell> STACK = new Stack<Cell>();

void setup() {
  size(1000, 750);
  //fullScreen();
  for (int x=0; x<col; x++) {
    for (int y=0; y<rows; y++) {
      Cell c = new Cell(x*scale, y*scale, scale);
      c.arrX = x;
      c.arrY = y;
      cells[x][y] = c;
    }
  }
  currCell = cells[startX][startY];
  nextC = cells[col-1][rows-1];
}

void draw() {
  noStroke();
  boolean foundN = false;
  background(0);
  for (int x=0; x<col; x++) {
    for (int y=0; y<rows; y++) {
      cells[x][y].show();
    }
  }
  currCell.visited = true;
  if (checkAround(cells, currCell.arrX, currCell.arrY)) {
    //Cell nextC = chooseNeigh(cells, currCell.arrX, currCell.arrY);
    while (!foundN) {
      nextC = chooseNeigh(cells, currCell.arrX, currCell.arrY);
      if (nextC.arrX == currCell.arrX && nextC.arrY == currCell.arrY) {
      } else {
        foundN = true;
      }
    }
    nextC.visited = true;
    currCell.highlight();
    STACK.push(currCell);
    currCell = nextC;
  } else if (STACK.size() != 0) {
    currCell = STACK.pop();
    currCell.highlight();
  } else {
    noLoop();
  }
}


boolean checkAround(Cell[][] cells, int posX, int posY) {
  try {
    if (!cells[posX+1][posY].visited) {
      return true;
    }
  }
  catch (ArrayIndexOutOfBoundsException exception) {
    //print("FUCK THIS");
  } 
  try {
    if (!cells[posX][posY+1].visited) {
      return true;
    }
  }
  catch (ArrayIndexOutOfBoundsException exception) {
  }  
  try {
    if (!cells[posX][posY-1].visited) {
      return true;
    }
  }
  catch (ArrayIndexOutOfBoundsException exception) {
    //print("CAUGHT IT BITCH\n");
  } 
  try {
    if (!cells[posX-1][posY].visited) {
      return true;
    }
  }
  catch (ArrayIndexOutOfBoundsException exception) {
    //print("x-1 u idiot\n");
  } 

  //Returns false if all neighbors have been visited
  return false;
}
boolean areUnvisited(Cell[][] cells) {
  for (int x=0; x<col; x++) {
    for (int y=0; y<rows; y++) {
      if (!cells[x][y].visited) {
        return true;
      }
    }
  }
  //Returns false if no more cells to visit
  return false;
}

Cell chooseNeigh(Cell[][] cells, int x, int y) {
  Cell retC;
  int neigh = floor(random(4));
  //print("SWITCH: "+neigh+"\n");
  try {
    switch(neigh) {
    case 0:
      retC = cells[x][y+1];
      if (retC.visited) {
        //print("VISITED CASE 0\n");
        return cells[x][y];
      }
      //print("1,1 is false\n");
      cells[x][y].walls[1][1]=false;
      retC.walls[0][0]=false;
      return retC;
    case 1:
      retC = cells[x+1][y];
      if (retC.visited) {
        //println("VISITED CASE 1");
        return cells[x][y];
      }
      //print("0,1 is false\n");
      cells[x][y].walls[0][1]=false;
      retC.walls[1][0]=false;
      return retC;
    case 2:
      retC = cells[x][y-1];
      if (retC.visited) {
        //println("VISITED CASE 2");
        return cells[x][y];
      }
      //print("0,0 is false\n");
      cells[x][y].walls[0][0]=false;
      retC.walls[1][1]=false;
      return retC;
    case 3:
      retC = cells[x-1][y];
      if (retC.visited) {
        //println("VISITED CASE 3");
        return cells[x][y];
      }
      //print("1,0 is false\n");
      cells[x][y].walls[1][0]=false;
      retC.walls[0][1]=false;
      return retC;
    }
  }
  catch (ArrayIndexOutOfBoundsException exception) {
    //print("NOT A NEIGH\n");
    return cells[x][y];
  }
  return cells[0][0];
}
