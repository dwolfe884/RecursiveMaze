class Cell {
  int col = w/scale;
  int rows = h/scale;
  boolean visited;
  //ArrayList[][] walls = new ArrayList[1][1];
  boolean[][] walls = {{true, true}, {true, true}};
  float cellX;
  float cellY;
  int arrX;
  int arrY;
  float cellSize;

  Cell(float x, float y, float side) {
    cellX = x;
    cellY = y;
    cellSize = side;
  }
  void highlight(){
    fill(0,150,150);
    square(cellX, cellY, cellSize);
  }
  void show() {
    noStroke();
    if (visited) {
      fill(226,252,239);
      square(cellX, cellY, cellSize);
    } else {
      stroke(0);
      fill(0);
    }
    for (int x=0; x<2; x++) {
      for (int y=0; y<2; y++) {
        if (walls[x][y]) {
          if (!visited) {
            stroke(100);
          } else {
            stroke(202,186,199);
          }
          switch(x) {
          case 0:
            switch(y) {
            case 0:
              line(cellX, cellY, cellX+cellSize, cellY);
              break;
            case 1:
              line(cellX+cellSize, cellY, cellX+cellSize, cellY+cellSize);
              break;
            }
            break;

          case 1:
            switch(y) {
            case 0:
              line(cellX, cellY, cellX, cellY+cellSize);
              break;
            case 1:
              line(cellX, cellY+cellSize, cellX+cellSize, cellY+cellSize);
              break;
            }
            break;
          }
        } else { 
          noStroke();
        }
      }
    }
    //square(cellX, cellY, cellSize);
  }
}
