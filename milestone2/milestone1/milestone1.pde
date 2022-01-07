import java.util.concurrent.ThreadLocalRandom;

int[] anArray;
int deltaX = 1/200;
int numElements = 200;
int pos = -1;

void setup() {
  size(1000, 500);
  deltaX = width/numElements;
  anArray = new int[numElements];
  for (int i=0; i < numElements; i++) {
    anArray[i] = ThreadLocalRandom.current().nextInt(0,height);
  }
}

void draw() {
  ++pos;
  if (frameCount % 5 ==0) {
    background(255);
    stroke(180);
    for (int i=0; i < numElements; i++) {
      if (i < pos) {
        fill(anArray[i],255,200);
      } else {
        fill(anArray[i],255,200,128);
      }
      rect(i * deltaX, height - anArray[i], deltaX, anArray[i]);
    }
  }

//  selectionSort();

  if (pos < numElements - 1) {
    int smallest = findSmallest(pos);
    if (smallest != pos) {
      swap(pos,smallest);
    }
  }
}

/*
void selectionSort() {
  for (int i=0; i < numElements-1; i++) {
    int min_idx = i;
    for (int j = i+1; j < numElements; j++) {
      if (anArray[j] < anArray[min_idx]) {
        min_idx = j;
      }
    }
    swap(i,min_idx);
  }
}
*/

int findSmallest(int from) {
  int min_idx = from;
  for (int i=from; i < numElements-1; i++) {
    for (int j=i+1; j < numElements; j++) {
      if (anArray[j] < anArray[min_idx]) {
        min_idx = j;
      }
    }
  }
  return min_idx;
}

void swap(int a, int b) {
  int tmp =anArray[a];
  anArray[a] = anArray[b];
  anArray[b] = tmp;
}
