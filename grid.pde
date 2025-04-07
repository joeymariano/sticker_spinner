class Grid {
  float gridStroke;
  boolean gridGrow;
  float spin;
  float lineSize;

  Grid() {
    gridStroke = 0;
    gridGrow = true;
    lineSize = 4;
  }

  void update(color colr) {
    pushMatrix();
    translate(displayWidth/2, displayHeight/2);
    
    if (spin >= TWO_PI){
      spin = 0;
    } else {
      spin += .02;
    }
    rotate(cos(spin));
    stroke(colr);
    strokeWeight(lineSize);

    for (int i = -displayWidth; i < displayWidth; i += 128) {
      line(i, -displayWidth, i, displayWidth);
      for (int x = -displayWidth; x < displayWidth; x += 128) {
        line(-displayWidth, x, displayWidth, x);
      }
    }

    if (gridGrow == true) {
      lineSize += .25;
    } else {
      lineSize -= .25;
    }

    if (lineSize <= .3) {
      gridGrow = true;
    }
    if (lineSize >= 32) {
      gridGrow = false;
    }
    popMatrix();
  }
}
