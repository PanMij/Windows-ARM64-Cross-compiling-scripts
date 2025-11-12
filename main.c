#include <stdio.h>
#include <stdlib.h>
#include "header.h"

int main() {
    printf("Windows Arm64 cross compiling test!\n");
    printf("Add: %d\n", add(5, 3));
    printf("Sub: %d\n", sub(5, 3));
    return EXIT_SUCCESS;
}