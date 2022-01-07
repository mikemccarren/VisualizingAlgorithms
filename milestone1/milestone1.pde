import java.util.concurrent.ThreadLocalRandom;

int[] anArray;

void setup() {
  size(800,400);
  background(255,255,255);
  anArray = new int[200];
  for (int i=0; i < 200; i++) {
    int randomNum = ThreadLocalRandom.current().nextInt(0,height);
    anArray[i] = randomNum;
  }
}

void draw() {
  for (int i=0; i < 200; i++) {
    int element = anArray[i];
    fill(element,element,0);
    rect(i * width/200, height - 100, width/200, element);
  }
}
