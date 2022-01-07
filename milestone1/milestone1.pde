import java.util.concurrent.ThreadLocalRandom;

int[] anArray;
int deltaX = 1;

void setup() {
  size(1000, 500);
  anArray = new int[200];
  for (int i=0; i < 200; i++) {
    anArray[i] = ThreadLocalRandom.current().nextInt(0,height);
  }
}

void draw() {
  background(255);
  stroke(180);
  for (int i=0; i < 200; i++) {
    int element = anArray[i];
    fill(element,255,200);
    rect(i * width/200, height - anArray[i], width/200, anArray[i]);
  }
}
