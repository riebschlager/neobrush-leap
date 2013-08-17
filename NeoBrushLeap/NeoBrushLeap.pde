import java.util.*;
import com.onformative.leap.LeapMotionP5;

int numberOfLines = 100;
ArrayList<SketchLine> lines = new ArrayList<SketchLine>();
PImage src;
int videoFrame = 0;
LeapMotionP5 leap;
PGraphics pointer;

void setup() {
  size(1280, 720);
  src = loadImage("http://payload33.cargocollective.com/1/0/128/2961375/manabe015_905.jpg");
  src.resize(width, height);
  background(0);
  noFill();
  leap = new LeapMotionP5(this);
  for (int i = 0; i < numberOfLines; i++) {
    lines.add(new SketchLine(10, 0.05 + random(-0.01, 0.01), 0.5  + random(-0.2, 0.2)));
  }
  pointer = createGraphics(width, height);
}

void draw() {
  if (leap.getHandList().size() > 0) { 
    for (SketchLine line : lines) {
      line.update();
      line.render();
    }
    pointer.beginDraw();
    pointer.clear();
    pointer.fill(255);
    PVector handPosition = leap.getPosition(leap.getHand(0));
    pointer.ellipse(handPosition.x, handPosition.y, 10, 10);
    pointer.endDraw();
    image(pointer, 0, 0);
    //saveFrameForVideo();
  }
}

void mouseReleased() {
  lines.clear();
}

void keyPressed() {
  if (key == ' ') {
    background(0);
  }
  if (key == 's') {
    String fileName = "data/output/composition-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".png";
    save(fileName);
    println("Saved: " + fileName);
  }
}

void saveFrameForVideo() {
  String index = nf(videoFrame, 5);
  saveFrame("data/video/" + index + ".tif");
  videoFrame++;
}

