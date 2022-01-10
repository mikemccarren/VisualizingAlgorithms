import java.util.concurrent.ThreadLocalRandom;
import java.util.Stack;

int numElements = 200;
int deltaX = 1/numElements;
//int numElements = 200;
int[] quickArray = new int[numElements];
int[] selectArray = new int[numElements];
int pos = -1;
int horizon;
int l, h, pivot;
int quickIterations = 0;
int selectIterations = 0;

Stack<Integer> lowStack = new Stack<>();
Stack<Integer> highStack = new Stack<>();

void setup() {
  size(1000, 500);
  horizon = height/2;
  deltaX = width/numElements;
  selectArray = new int[numElements];
  for (int i=0; i < numElements; i++) {
    selectArray[i] = ThreadLocalRandom.current().nextInt(0,height/2);
    quickArray[i] = selectArray[i];
  }
  
// initialize quickSort stack
  lowStack.push(0);
  highStack.push((numElements-1));
}

void draw() {

//  selectionSort();
  ++pos;
  if (pos < numElements - 1) {
    int smallest = findSmallest(pos);
    if (smallest != pos) {
      swap(pos,smallest,selectArray);
    }
  }
  
// quick sort
  if (!lowStack.empty()) {

    l = lowStack.pop();
    h = highStack.pop();
    pivot = partition(quickArray, l, h);
    if (l < pivot) {
      ++quickIterations;
      lowStack.push(l);
      highStack.push(pivot-1);
    } 
    if (pivot < h) {
      ++quickIterations;
      lowStack.push(pivot+1);
      highStack.push(h);
    }
  } else {
    print("Completed select in ", selectIterations, " iterations :: ");
    println("Completed quick in ",quickIterations," iterations");
  }
  
  background(255);
  stroke(180);
  
// select sort plotting

  for (int i=0; i < numElements; i++) {
    if (i < pos) {
      fill(selectArray[i],255,200);
    } else {
      fill(selectArray[i],255,200,128);
    }
    rect(i * deltaX, horizon, deltaX, selectArray[i]*-1);

// quick sort plotting
    if ((i >= l) && (i <= h)) {
      fill(128,quickArray[i],200);
    } else {
      fill(255,quickArray[i],200);
    }
    rect(i * deltaX, horizon, deltaX, quickArray[i]);
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
     println("Recursive pivot ",pi);
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
