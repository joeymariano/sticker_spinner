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
    translate(width/2, height/2);
    
    if (spin >= TWO_PI){
      spin = 0;
    } else {
      spin += .02;
    }
    rotate(cos(spin));
    stroke(colr);
    strokeWeight(lineSize);

    for (int i = -width; i < width; i += 128) {
      line(i, -width, i, width);
      for (int x = -width; x < width; x += 128) {
        line(-width, x, width, x);
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
