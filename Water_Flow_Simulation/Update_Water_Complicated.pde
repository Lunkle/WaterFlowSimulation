final float FLUIDITY = 0.5;

void updateWaterComplicated() {
    //boolean[][] alreadyFilled = new boolean[GRID_X][GRID_Y];
    float[][] depthChanges = new float[GRID_X][GRID_Y];
    for (int i = 0; i < GRID_X; i++) {
        for (int j = 0; j < GRID_Y; j++) {
            float amountOfWater = depths[i][j];
            Height[] heightsOrder = {};
            for (int k = -1; k <= 1; k++) {
                for (int l = -1; l <= 1; l++) {
                    try {
                        heightsOrder = (Height[]) append(heights[i + k][j + l], heightsOrder);
                    }
                    catch(Exception e) {
                        continue;
                    }
                }
            }
            heightsOrder = sort(heightsOrder);
            int numHeights = 0;
            float waterUsed = 0;
            Height[] targetElevations = new Height[heightsOrder.length];
            while(true){
                numHeights++;
                float waterToNextHeight = numHeights * (heightsOrder[numHeights].h + depths[heightsOrder[numHeights].x][] - heightsOrder[numHeights - 1].h);
                waterUsed += waterToNextHeight;
                if(){
                    for(int h = 0; h < numHeights; h++){
                    }
                }else{
                }
            }
            
            
        }
    }
    for (int i = 0; i < GRID_X; i++) {
        for (int j = 0; j < GRID_Y; j++) {
            depths[i][j] += depthChanges[i][j] * FLUIDITY;
        }
    }
    depths[waterPourX][waterPourY] += POUR_SPEED;
}

Height[] sort(Height[] heights){
    for(int i = 1; i < heights.length; i++){
        for(int j = i - 1; j > 0; j--){
            if(heights[j].h < heights[i].h){
                heights = swap(heights, i, j);
            }else{
                break;
            }
        }
    }
    return heights;
}

Height[] swap(Height[] heights, int i1, int i2){
    Height temp = heights[i1];
    heights[i1] = heights[i2];
    heights[i2] = temp;
    return heights;
}
