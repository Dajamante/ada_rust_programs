#include "stdio.h"
#include "string.h"

extern void read_from_spark(void* c);
extern void adainit();
extern void adafinal();

int main() {
  adainit();
  char* v = "hello";
  read_from_spark(v);
  adafinal();
}
