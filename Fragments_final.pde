PImage[] img;
PFont font;

Bang displacement;

import controlP5.*;
ControlP5 cp5;

PVector startingPoint = new PVector();
PVector endingPoint = new PVector();

float selectionSizeX;
float selectionSizeY;

boolean mouseReleased = false;

int strokeWeight = 2;

int mode = 0;

int sliderValueBlur = 5;

int h = 175;
int s = 182;
int b = 188;

int currentImage = 0;
int imageAmount = 7;

int colorBackground = 50;
int colorForeground = 100;
int colorActive = 255;

int sliderValuePixelate = 30;

void setup() {
  size(1000, 800);
  surface.setTitle("FRAGMENTATION");
  rectMode(CORNERS);
  smooth();
  img = new PImage[imageAmount];

  for (int i = 0; i < imageAmount; i++) {
    img[i] = loadImage("image" + i + ".jpg");
  }

  font = createFont("PxGroteskRegular.ttf", 10);
  textFont(font);

  colorMode(HSB);
  cp5 = new ControlP5(this);

  cp5.addBang("displacement")
    .setPosition(850, 100)
    .setSize(100, 40)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Displacement")
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    ;

  cp5.addBang("blur")
    .setPosition(850, 170)
    .setSize(100, 40)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Blur")
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    ;

  cp5.addSlider("sliderValueBlur")
    .setPosition(850, 230)
    .setRange(0, 40)
    .setLabel("Blur amount")
    .setColorBackground(color(colorBackground))
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    ;

  cp5.addBang("pixel")
    .setPosition(850, 270)
    .setSize(100, 40)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Pixelate")
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    ;

  cp5.addSlider("sliderValuePixelate")
    .setPosition(850, 330)
    .setRange(1, 100)
    .setLabel("Pixelate amount")
    .setColorBackground(color(colorBackground))
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    ;

  cp5.addBang("rectFill")
    .setPosition(850, 400)
    .setSize(100, 40)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Fill")
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    ;


  cp5.addSlider("h")
    .setPosition(850, 460)
    .setRange(0, 255)
    .setLabel("Hue")
    .setColorBackground(color(colorBackground))
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    ;

  cp5.addSlider("s")
    .setPosition(850, 490)
    .setRange(0, 255)
    .setLabel("Saturation")
    .setColorBackground(color(colorBackground))
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    ;

  cp5.addSlider("b")
    .setPosition(850, 520)
    .setRange(0, 255)
    .setLabel("Brightness")
    .setColorBackground(color(colorBackground))
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    ;

  PImage[] imgsPrev = {loadImage("prev.png"), loadImage("prev.png"), loadImage("prev_click.png")};
  cp5.addBang("prevImage")
    .setPosition(850, 655)
    .setSize(40, 40)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Previous")
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    .setImages(imgsPrev)
    .updateSize()
    ;

  PImage[] imgsNext = {loadImage("next.png"), loadImage("next.png"), loadImage("next_click.png")};
  cp5.addBang("nextImage")
    .setPosition(925, 655)
    .setSize(40, 40)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Next")
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    .setImages(imgsNext)
    .updateSize()
    ;

  cp5.addBang("resetImg")
    .setPosition(850, height - 80)
    .setSize(100, 40)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Reset Canvas")
    .setColorForeground(color(colorForeground))
    .setColorActive(color(colorActive))
    .setFont(font)
    ;

  cp5.getController("resetImg").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

  cp5.getController("sliderValueBlur").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("sliderValueBlur").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

  cp5.getController("sliderValuePixelate").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("sliderValuePixelate").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

  cp5.getController("h").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("s").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("b").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

  cp5.getController("h").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("s").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("b").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
}

void draw() {
  background(30);
  strokeWeight(strokeWeight);
  image(img[currentImage], 0, 0);
  img[currentImage].loadPixels();
  fill(0, 0, 0);
  push();
  stroke(60);
  line(801, 70, 1000, 70);
  line(801, 378, 1000, 378);
  line(801, 630, 1000, 630);
  pop();
  //stroke(255);

  selectionSizeX = abs(endingPoint.x - startingPoint.x);
  selectionSizeY = abs(endingPoint.y - startingPoint.y);

  if (mode == 1) {
    if (mouseX < 800 && mouseY < 800) {
      if (mousePressed) {
        push();
        noFill();
        stroke(255);
        rect(startingPoint.x, startingPoint.y, mouseX, mouseY);
        pop();
      }
      if (mouseReleased == true) {
        drawDisplace(startingPoint.x, startingPoint.y, endingPoint.x, endingPoint.y);
      }
    }
  }

  if (mode == 2) {
    if (mouseX < 800 && mouseY < 800) {
      if (mousePressed) {
        push();
        noFill();
        stroke(255);
        rect(startingPoint.x, startingPoint.y, mouseX, mouseY);
        pop();
      }
      if (mouseReleased == true) {
        drawBlur(startingPoint.x, startingPoint.y, endingPoint.x, endingPoint.y);
      }
    }
  }

  if (mode == 3) {
    if (mouseX < 800 && mouseY < 800) {
      if (mousePressed) {
        push();
        fill(h, s, b);
        noStroke();
        rect(startingPoint.x, startingPoint.y, mouseX, mouseY);
        pop();
      }
      if (mouseReleased == true) {
        drawFill(startingPoint.x, startingPoint.y, endingPoint.x, endingPoint.y);
      }
    }
  }

  if (mode == 4) {
    if (mouseX < 800 && mouseY < 800) {
      if (mousePressed) {
        push();
        noFill();
        stroke(255);
        rect(startingPoint.x, startingPoint.y, mouseX, mouseY);
        pop();
      }
      if (mouseReleased == true) {
        drawPixel();
      }
    }
  }

  //println(mode);
  mouseReleased = false;
  fill(255, 0, 255);
  text("FRAGMENTATION", 840, 40);
  textSize(15);
  text(currentImage, 895, 673);
  push();
  fill(h, s, b);
  noStroke();
  rect(850, 550, 950, 610);
  pop();
  smooth();
}

void mousePressed() {
  startingPoint = new PVector(mouseX, mouseY);
}

void mouseReleased() {
  endingPoint = new PVector(mouseX, mouseY);
  mouseReleased = true;
}

void drawDisplace(float x, float y, float xSize, float ySize) {
  PImage displaced = img[currentImage].get(int(x), int(y), int(selectionSizeX), int(selectionSizeY));
  image(displaced, random(0, 800 - selectionSizeX), random(0, 800 - selectionSizeY));
  saveFrame("outputImage.png");
  img[currentImage] = loadImage("outputImage.png");
}

void drawBlur(float x, float y, float xEnd, float yEnd) {
  PImage blurred = img[currentImage].get(int(x), int(y), int(selectionSizeX), int(selectionSizeY));
  blurred.filter(BLUR, sliderValueBlur);
  if (xEnd < x) {
    x -= selectionSizeX;
  }
  if (yEnd < y) {
    y -= selectionSizeY;
  }
  image(blurred, x + (strokeWeight/2), y + (strokeWeight/2));
  saveFrame("outputImage.png");
  img[currentImage] = loadImage("outputImage.png");
}

void drawFill(float x, float y, float xSize, float ySize) {
  push();
  fill(h, s, b);
  noStroke();
  rect(x, y, xSize, ySize);
  pop();
  saveFrame("outputImage.png");
  img[currentImage] = loadImage("outputImage.png");
}

void drawPixel() {
  push();
  noStroke();
  rectMode(CORNER);
  PImage pixelated = img[currentImage];
  pixelated.loadPixels();
  for (int pixelX = int(startingPoint.x); pixelX < endingPoint.x; pixelX += sliderValuePixelate) {
    for (int pixelY = int(startingPoint.y); pixelY < endingPoint.y; pixelY += sliderValuePixelate) {
      color c = pixelated.pixels[pixelY * pixelated.width + pixelX];
      fill(c);
      rect(pixelX, pixelY, sliderValuePixelate, sliderValuePixelate);
    }
  }
  pixelated.updatePixels();
  saveFrame("outputImage.png");
  img[currentImage] = loadImage("outputImage.png");
  pop();
}

public void displacement() {
  mode = 1;
  cp5.getController("displacement").setColorForeground(color(colorActive));
  cp5.getController("blur").setColorForeground(color(colorForeground));
  cp5.getController("pixel").setColorForeground(color(colorForeground));
  cp5.getController("rectFill").setColorForeground(color(colorForeground));
}

public void blur() {
  mode = 2;
  cp5.getController("displacement").setColorForeground(color(colorForeground));
  cp5.getController("blur").setColorForeground(color(colorActive));
  cp5.getController("pixel").setColorForeground(color(colorForeground));
  cp5.getController("rectFill").setColorForeground(color(colorForeground));
}

public void rectFill() {
  mode = 3;
  cp5.getController("displacement").setColorForeground(color(colorForeground));
  cp5.getController("blur").setColorForeground(color(colorForeground));
  cp5.getController("pixel").setColorForeground(color(colorForeground));
  cp5.getController("rectFill").setColorForeground(color(colorActive));
}

public void pixel() {
  mode = 4;
  cp5.getController("displacement").setColorForeground(color(colorForeground));
  cp5.getController("blur").setColorForeground(color(colorForeground));
  cp5.getController("rectFill").setColorForeground(color(colorForeground));
  cp5.getController("pixel").setColorForeground(color(colorActive));
}

public void resetImg() {
  img[currentImage] = loadImage("image" + currentImage + ".jpg");
}

public void nextImage() {
  if (currentImage >= imageAmount - 1) {
    currentImage = 0;
  } else {
    currentImage++;
  }
}

public void prevImage() {
  if (currentImage <= 0) {
    currentImage = imageAmount - 1;
  } else {
    currentImage--;
  }
}
