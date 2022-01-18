import java.util.concurrent.ThreadLocalRandom;
import java.util.Stack;

int numElements = 200;
int deltaX = 1/numElements;
//int numElements = 200;
int[] quickArray = new int[numElements];
int[] selectArray = new int[numElements];
int[] arr = new int[numElements];
int pos = -1;
int horizon;
int l, h, pivot;
int quickIterations = 0;
int selectIterations = 0;

int binaryGuess = numElements/2;
int sequentialGuess = 0;

int searchTarget = 0;
int searchIndex = 0;

boolean sequentialFound = false;
boolean binaryFound = false;

Stack<Integer> lowStack = new Stack<>();
Stack<Integer> highStack = new Stack<>();

void setup() {
  size(1000, 500);
  horizon = height/2;
  deltaX = width/numElements;
  selectArray = new int[numElements];
  for (int i=0; i < numElements; i++) {
    arr[i] = ThreadLocalRandom.current().nextInt(0,height/2);
//    quickArray[i] = selectArray[i];
  }
  
  quickSort(arr,0,(numElements-1));
//  quickSort(quickArray,0,(numElements-1));
  
// initialize quickSort stack
//  lowStack.push(0);
//  highStack.push((numElements-1));

}

void draw() {

  background(255);
  stroke(180);
  
// select sort plotting

  for (int i=0; i < numElements; i++) {
    int sequentialAlpha = 255;
    int binaryAlpha = 255;
    int blue = 255;
    int green = 200;
    
    if (arr[i] == sequentialGuess) {
      sequentialAlpha = 128;
      sequentialFound = true;
    } else {
      ++sequentialGuess;
      println("Sequential ", sequentialGuess);
    }
    
    if (arr[i] == binaryGuess) {
      binaryAlpha = 255;
      binaryFound = true;
    } else {
      if (binaryGuess < arr[i]) {
        binaryGuess = (binaryGuess + arr[numElements-1])/2;
      } else {
        binaryGuess = binaryGuess/2;
      }
      println("Binary ", binaryGuess);
    }
    
    if (arr[i] == searchTarget) {
      blue = 200;
      green = 255;
    }
      
    fill(arr[i],blue,green,binaryAlpha);
    rect(i * deltaX, horizon, deltaX, arr[i]);
    fill(arr[i],blue,green,sequentialAlpha);
    rect(i * deltaX, horizon, deltaX, arr[i] * -1);
  }
}
    
void mouseClicked() {
  if (searchTarget == 0) {
    println("Mouse clicked by bar ", mouseX/deltaX);
    searchTarget = arr[mouseX/deltaX];
    println("Searching for value ", searchTarget);
  }
}

int findSmallest(int from) {
  ++selectIterations;
  int min_idx = from;
  for (int i=from; i < numElements-1; i++) {
    for (int j=i+1; j < numElements; j++) {
      if (selectArray[j] < selectArray[min_idx]) {
        min_idx = j;
      }
    }
  }
  return min_idx;
}

void swap(int a, int b, int[] arr) {
  int tmp = arr[a];
  arr[a] = arr[b];
  arr[b] = tmp;
}


int partition(int arr[], int low, int high) {

  int pivot = arr[high];
  int i = (low-1);
  for (int j=low; j < high; j++) {
    if (arr[j] < pivot) {
//      ++quickIterations;
      i++;
      swap(i, j, arr);
    }
  }
  swap((i+1),high, arr);
//  printArray(arr);
  return (i+1);
}

//void quickSortStack(int[] arr, int low, int high) {
void quickSortStack(int[] arr) {
  int l, h, pi;
  while (!lowStack.empty()) {
    l = lowStack.pop();
    h  = highStack.pop();
    pi  = partition(arr, l, h);
//    println("pivot ",pi);
    if (l < pi) {
      lowStack.push(l);
      highStack.push(pi-1);
    }
    if (pi <  numElements-1) {
      lowStack.push(pi+1);
      highStack.push(h);
//      lowStack.push(l);
//      highStack.push(pi-1);
   }
  }
}

void quickSort(int arr[], int low, int high) {
  if (low < high) {
    int pi = partition(arr,low,high);
//     println("Recursive pivot ",pi);
     quickSort(arr,low,pi-1);
    quickSort(arr,pi+1,high);
  }
}

void printArray(int a[]) {
  int n = a.length;
  for (int i=0; i < n; ++i) {
    print("a[",i,"] = ",a[i]," ");
  }
  println();
}
