class Sticker {
  PImage img;
  boolean expand = true;
  float imageWidth;
  float imageHeight;
  boolean reverseImage = false;
  boolean spinHorizontal = true;
  float speed = 4;
  float spin;
  float scaleFactor;

  Sticker(PImage inComingImage) {
    img = inComingImage;
    // Determine the scale factor based on the larger dimension
    if (img.width > img.height) {
      scaleFactor = (displayWidth * 0.75) / img.width;
    } else {
      scaleFactor = (displayHeight * 0.75) / img.height;
    }
  }

  void hover(float rate, float widen) {
    spin += rate;
    pushMatrix();
    scale(scaleFactor);
    translate(0, (sin(spin) * widen));
    image(img, 0, 0);
    popMatrix();
  }

  void spinFlatRight() {
    spin += .02;
    pushMatrix();
    rotate(spin);
    scale(scaleFactor);
    image(img, 0, 0);
    popMatrix();
  }

  void spinFlatLeft() {
    spin -= .02;
    pushMatrix();
    rotate(spin);
    scale(scaleFactor);
    image(img, 0, 0);
    popMatrix();
  }

  void spinVertical() {
    if (reverseImage == false) {
      if (expand == true) {
        if (imageHeight >= img.height) {
          expand = false;
        } else {
          imageHeight += speed;
        }
      }
      if (expand == false) {
        if (imageHeight <= 0) {
          expand = true;
          reverseImage = true;
        } else {
          imageHeight -= speed;
        }
      }
    } else {
      if (expand == true) {
        if (imageHeight >= img.height) {
          expand = false;
        } else {
          imageHeight += speed;
        }
      }
      if (expand == false) {
        if (imageHeight <= 0) {
          expand = true;
          reverseImage = false;
        } else {
          imageHeight -= speed;
        }
      }
    }
    pushMatrix();
    if (reverseImage) {
      scale(-scaleFactor, scaleFactor);
    } else {
      scale(scaleFactor);
    } // Reverse the image if necessary
    image(img, 0, 0, img.width, imageHeight);
    popMatrix();
  }

  void spinHorizontal() {
    if (reverseImage == false) {
      if (expand == true) {
        if (imageWidth >= img.width) {
          expand = false;
        } else {
          imageWidth += speed;
        }
      }
      if (expand == false) {
        if (imageWidth <= 0) {
          expand = true;
          reverseImage = true;
        } else {
          imageWidth -= speed;
        }
      }
    } else {
      if (expand == true) {
        if (imageWidth >= img.width) {
          expand = false;
        } else {
          imageWidth += speed;
        }
      }
      if (expand == false) {
        if (imageWidth <= 0) {
          expand = true;
          reverseImage = false;
        } else {
          imageWidth -= speed;
        }
      }
    }
    pushMatrix();
    if (reverseImage) {
      scale(-scaleFactor, scaleFactor);
    } else {
      scale(scaleFactor);
    } // Reverse the image if necessary
    image(img, 0, 0, imageWidth, img.height);
    popMatrix();
  }

  void bounce(float rate, float minScale, float maxScale) {
    spin += rate;
    float scaleValue = map(sin(spin), -1, 1, minScale, maxScale);
    pushMatrix();
    scale(scaleFactor * scaleValue);
    image(img, 0, 0);
    popMatrix();
  }

  void pulsate(float rate, float minScale, float maxScale) {
    spin += rate;
    // Stronger scaling effect for a more dynamic pulsation
    float scaleValue = map(sin(spin), -1, 1, minScale, maxScale);
    float alphaValue = map(sin(spin), -1, 1, 200, 255); // Maintain a subtle opacity change
    pushMatrix();
    tint(255, alphaValue); // Apply slight opacity change
    scale(scaleFactor * scaleValue); // Apply scaling
    image(img, 0, 0);
    noTint(); // Reset tint to default
    popMatrix();
  }


void rotateAndScale(float rate, float scaleRange) {
  spin += rate;
  // Increase the scale range for more dramatic scaling
  float currentScale = map(sin(spin), -1, 1, scaleFactor - scaleRange * 4, scaleFactor + scaleRange * 4);
  pushMatrix();
  // Apply a more pronounced rotation
  rotate(spin * 1.2);
  scale(currentScale);
  image(img, 0, 0);
  popMatrix();
}


  void wobble(float rate, float angleRange) {
    spin += rate;
    float angle = sin(spin) * angleRange;
    pushMatrix();
    rotate(angle);
    scale(scaleFactor);
    image(img, 0, 0);
    popMatrix();
  }

  void fadeInOut(float rate) {
    spin += rate;
    // Smooth fade in and out between full opacity and complete transparency
    float alphaValue = map(sin(spin), -1, 1, 0, 255);
    pushMatrix();
    tint(255, alphaValue); // Adjust opacity only
    scale(scaleFactor);
    image(img, 0, 0);
    noTint(); // Reset tint to default
    popMatrix();
  }
}
