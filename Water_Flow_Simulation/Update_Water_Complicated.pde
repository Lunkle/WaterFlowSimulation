final float FLUIDITY = 0.5;

void updateWaterComplicated() {
    //boolean[][] alreadyFilled = new boolean[GRID_X][GRID_Y];
    float[][] depthChanges = new float[GRID_X][GRID_Y];
    for (int i = 0; i < GRID_X; i++) {
        for (int j = 0; j < GRID_Y; j++) {
            float amountOfWater = depths[i][j];
            float[] heightsOrder = {};
            for (int k = -1; k <= 1; k++) {
                for (int l = -1; l <= 1; l++) {
                    try {
                        heightsOrder = (float[]) append(heights[i + k][j + l], heightsOrder);
                    }
                    catch(Exception e) {
                        continue;
                    }
                }
            }
            heightsOrder = sort(heightsOrder);
        }
    }
    for (int i = 0; i < GRID_X; i++) {
        for (int j = 0; j < GRID_Y; j++) {
            depths[i][j] += depthChanges[i][j] * FLUIDITY;
        }
    }
    depths[waterPourX][waterPourY] += POUR_SPEED;
}
