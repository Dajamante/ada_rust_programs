#include "stdio.h"
#include "string.h"

typedef struct
{
    int first;
    int last;
} AdaBounds;

typedef struct
{
    char *data;
    AdaBounds *bounds;
} AdaString;

extern AdaString allocate_str();
extern void free_str(AdaString s);
extern void adainit();
extern void adafinal();

int main()
{
    adainit();
    AdaString ada_string_ptr = allocate_str();
    printf("Hello pointer, %p\n", ada_string_ptr.data);
    printf("Array bytes, %s\n", ada_string_ptr.data);
    strcpy(ada_string_ptr.data, "World");
    printf("Pointer after replacing in C, %s\n", ada_string_ptr.data);
    free_str(ada_string_ptr);
    adafinal();
}