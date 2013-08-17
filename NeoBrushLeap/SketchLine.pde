class  SketchLine {

  int numberOfVertices;
  PVector[] curveVertices, distances, endPoints;
  float easeFactor, speedFactor;

  SketchLine(int _numberOfVertices, float _easeFactor, float _speedFactor) {
    numberOfVertices = _numberOfVertices;
    easeFactor = _easeFactor;
    speedFactor = _speedFactor;
    curveVertices = new PVector[numberOfVertices];
    distances = new PVector[numberOfVertices];
    endPoints = new PVector[numberOfVertices];
    for (int i = 0; i < numberOfVertices; i++) {
      curveVertices[i] = new PVector(width/2, height/2);
      distances[i] = new PVector();
      endPoints[i] = new PVector();
    }
  }

  void update() {  
    PVector handPosition = leap.getPosition(leap.getHand(0)); 
    for (int i = 0; i < numberOfVertices; i++) {
      distances[i].x = (i == 0) ? handPosition.x - curveVertices[0].x : curveVertices[i-1].x - curveVertices[i].x;
      distances[i].y = (i == 0) ? handPosition.y - curveVertices[0].y : curveVertices[i-1].y - curveVertices[i].y;
      distances[i].mult(easeFactor);
      endPoints[i].add(distances[i]);
      curveVertices[i].add(endPoints[i]);
      endPoints[i].mult(speedFactor);
    }
  }

  void render() {
    beginShape();
    for (int i = 0; i < numberOfVertices; i++) {
      strokeWeight(0.1);
      stroke(src.get((int) curveVertices[i].x, (int) curveVertices[i].y), 30);
      curveVertex(curveVertices[i].x, curveVertices[i].y);
    }
    endShape();
  }
}

