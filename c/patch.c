#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

void patch_file(const char *filename, const char *bytes, size_t offset) {
    FILE *file = fopen(filename, "r+b");
    if (!file) {
        perror("Error opening file");
        return;
    }
    
    fseek(file, offset, SEEK_SET);
    fwrite(bytes, 1, strlen(bytes), file);
    fclose(file);
}

int main() {
    clock_t start = clock();

    const char *filename = "randomblock";
    const char *bytes = "d1ffd1ff";
    size_t offset = 100;
    patch_file(filename, bytes, offset);

    clock_t end = clock();
    double time_taken = ((double)(end - start)) / CLOCKS_PER_SEC;
    printf("Time taken: %f seconds (c)\n", time_taken);
    return 0;
}