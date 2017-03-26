#include <iostream>

int main(){
  int* a = new int;
  int* b = new int;

  *a = 2;
  *b = 3;

  int c = *a + *b;

  *a = 4;

  std::cout << c << std::endl;

  delete a;
  delete b;

  return 0;
}
