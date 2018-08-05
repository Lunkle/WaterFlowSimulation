float FLOW_AMOUNT = POUR_SPEED / 8;

void updateWaterSimple(){
    float[][] depthChanges = new float[GRID_X][GRID_Y];
    
    int[] iValues = fillArrayTo(GRID_X);
    while(iValues.length != 0){
        int iRemovalIndex = parseInt(random(0, iValues.length));
        int i = iValues[iRemovalIndex];
        iValues = remove(iValues, iRemovalIndex);
        int[] jValues = fillArrayTo(GRID_Y);
        while(jValues.length != 0){
            int jRemovalIndex = parseInt(random(0, jValues.length));
            int j = jValues[jRemovalIndex];
            jValues = remove(jValues, jRemovalIndex);
            int[] xValues = {1, 0, -1};
            //println(i, j, jValues.length);
            while(xValues.length != 0){
                int xRemovalIndex = parseInt(random(0, xValues.length));
                int x = xValues[xRemovalIndex];
                xValues = remove(xValues, xRemovalIndex);
                int[] yValues = {-1, 0, 1};
                while(yValues.length != 0){
                    int yRemovalIndex = parseInt(random(0, yValues.length));
                    int y = yValues[yRemovalIndex];
                    yValues = remove(yValues, yRemovalIndex);
                    if(!(isOutOfRange(i + x, j + y))){
                        float amountFlowed = 0;
                        if(depths[i][j] > 0 && depths[i][j] + heights[i][j] > depths[i + x][j + y] + heights[i + x][j + y]){
                            amountFlowed = min(FLOW_AMOUNT, depths[i][j] + heights[i][j] - depths[i + x][j + y] - heights[i + x][j + y]);
                        }else if(depths[i + x][j + y] > 0 && depths[i][j] + heights[i][j] < depths[i + x][j + y] + heights[i + x][j + y]){
                            amountFlowed = max(-FLOW_AMOUNT, -depths[i + x][j + y]);
                        }
                        depths[i][j] = depths[i][j] - amountFlowed;
                        depthChanges[i + x][j + y] += amountFlowed;
                    }
                }
            }
        }
    }
    for(int i = 0; i < GRID_X; i++){
        for(int j = 0; j < GRID_Y; j++){
            depths[i][j] += depthChanges[i][j];
        }
    }
    depths[waterPourX][waterPourY] += POUR_SPEED;
}

boolean isOutOfRange(int x, int y){
    return x >= GRID_X || x < 0 || y >= GRID_Y || y < 0;
}

int[] remove(int[] array, int index) {
    int[] firstHalf = new int[index];
    int[] secondHalf = new int[array.length - index - 1];
    for (int i = 0; i < index; i++) {
        firstHalf[i] = array[i];
    }
    for (int i = index + 1; i < array.length; i++) {
        secondHalf[i - index - 1] = array[i];
    }
    
    return concat(firstHalf, secondHalf);
}

int[] fillArrayTo(int number){
    int[] array = new int[number];
    for(int i = 0; i < number; i++){
        array[i] = i;
    }
    return array;
}