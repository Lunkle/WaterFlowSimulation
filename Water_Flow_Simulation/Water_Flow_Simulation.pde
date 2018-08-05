final float SQUARE_SIZE = 1;//5;
final int GRID_X = 160;//160;
final int GRID_Y = 120;//120;

final float PADDING = 10;

final float POUR_SPEED = 160; //Adjust this for more water!

final float WATER_FLOW_RATE = 0.5;

boolean startedPouring = false;
int waterPourX, waterPourY;

final float FRAMES_PER_SECOND = 20; //Change this to slow or speed up the animation

float[][] heights = new float[GRID_X][GRID_Y];
float[][] depths = new float[GRID_X][GRID_Y];

void setup() {
  noStroke();
  surface.setSize(parseInt(GRID_X * SQUARE_SIZE + 2 * PADDING), parseInt(GRID_Y * SQUARE_SIZE + 2 * PADDING));
  generateTerrain();
}

void draw() {
  if (startedPouring == true) {
    updateWaterSimple();
    updateWaterSimple();
  }
  setBackground();
  displaySquares();
  indicateCursorTile();
}

void setBackground() {
  background(130);
}

void indicateCursorTile() {
  if (startedPouring == false) {
    PVector waterPourLocationXY =  getGridMouseXY();
    fill(51, 187, 255);
    createSquare(parseInt(waterPourLocationXY.x), parseInt(waterPourLocationXY.y));
  }
}

void displaySquares() {
  for (int i = 0; i < GRID_X; i++) {
    for (int j = 0; j < GRID_Y; j++) {
      if (depths[i][j] < 0.001) {
        if (heights[i][j] > 0) {
          fill(255, 255 - parseInt(heights[i][j]), 0);
        } else {
          fill(255 + heights[i][j], 255, 0);
        }
      } else {
        float gradientPerccentage =  min(510, depths[i][j]) / 510;
        fill(51 - 51 * gradientPerccentage, 187 - 187 * gradientPerccentage, 255 - 95 * gradientPerccentage);
      }
      createSquare(i, j);
    }
  }
}

PVector getGridMouseXY() {
  int gridMouseX = parseInt((mouseX - PADDING) / SQUARE_SIZE);
  int gridMouseY = parseInt((mouseY - PADDING) / SQUARE_SIZE);
  return new PVector(gridMouseX, gridMouseY);
}

void createSquare(int squareX, int squareY) {
  if (squareX >= 0 && squareY >= 0 && squareX < GRID_X && squareY < GRID_Y) {
    rect(PADDING + squareX * SQUARE_SIZE, PADDING + squareY * SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE);
    fill(0);
    //text(round(depths[squareX][squareY]), PADDING + squareX * SQUARE_SIZE, PADDING + (squareY+0.3) * SQUARE_SIZE);
    //text(round(heights[squareX][squareY]), PADDING + squareX * SQUARE_SIZE, PADDING + (squareY+0.75) * SQUARE_SIZE);
  }
}

void mouseClicked() {
  if (startedPouring == false) {
    startedPouring = true;
    PVector waterPourLocationXY =  getGridMouseXY();
    waterPourX = parseInt(waterPourLocationXY.x);
    waterPourY = parseInt(waterPourLocationXY.y);
    frameRate(FRAMES_PER_SECOND);
  }
}

void generateTerrain() {
  int numOfMountains = parseInt(random(max(2, GRID_X * GRID_Y / 600), GRID_X * GRID_Y / 500));
  //numOfMountains = parseInt(random(9, GRID_X * GRID_Y / 500));
  println("numOfMountains="+numOfMountains);
  PVector[] mountainCentres = new PVector[numOfMountains];
  float[] mountainSizes = new float[numOfMountains];
  int numOfPresetMountains = presetMountains();
  for (int i = numOfPresetMountains; i < numOfMountains; i++) {
    mountainCentres[i] = new PVector(parseInt(random(GRID_X)), parseInt(random(GRID_Y)));
    mountainSizes[i] = random(4, 6 * sqrt(sqrt(sqrt(sqrt(GRID_X * GRID_Y)))));
  }
  for (int i = 0; i < GRID_X; i++) {
    for (int j = 0; j < GRID_Y; j++) {
      heights[i][j] = random(-455, -405);
      //If it is near a mountain centre, make it higher
      for (int k = 0; k < numOfMountains; k++) {
        heights[i][j] += min(300, 100 * mountainSizes[k]/dist(mountainCentres[k].x, mountainCentres[k].y, i, j));
      }
    }
  }
}

int presetMountains() {
  return 0;
}