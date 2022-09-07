#include "myl.h"

int main(){
    printStr("Hello World!\n");
    printStr("Testing printStr...\n");
    //We test print string by giving an empty string and a non-empty string
    int numberOfCharactersPrinted = 0;
    numberOfCharactersPrinted = printStr("");
    if(numberOfCharactersPrinted == 0){
        printStr("Test 1: PASSED\n");
    }
    else{
        printStr("Test 1: FAILED\n");
    }
    numberOfCharactersPrinted = printStr("This string is not empty!\n");
    if(numberOfCharactersPrinted == 26){
        printStr("Test 2: PASSED\n");
    }
    else{
        printStr("Test 2: FAILED\n");
    }

    printStr("Testing printInt...\n");
    //We test printInt by giving a negative integer, a positive integer and 0
    numberOfCharactersPrinted = 0;
    numberOfCharactersPrinted = printInt(-123);
    if(numberOfCharactersPrinted == 4){
        printStr("Test 1: PASSED\n");
    }
    else{
        printStr("Test 1: FAILED\n");
    }
    numberOfCharactersPrinted = printInt(123);
    if(numberOfCharactersPrinted == 3){
        printStr("Test 2: PASSED\n");
    }
    else{
        printStr("Test 2: FAILED\n");
    }
    numberOfCharactersPrinted = printInt(0);
    if(numberOfCharactersPrinted == 1){
        printStr("Test 3: PASSED\n");
    }
    else{
        printStr("Test 3: FAILED\n");
    }

    printStr("Testing readInt...\n");
    //We test readInt by entering a negative integer, a positive integer, 0, an integer greater than limits of int and a non-integer
    int numberRead = 0, error=0;
    printStr("Enter a negative integer: ");
    error = readInt(&numberRead);
    if(error == OK && numberRead < 0){
        printStr("Test 1: PASSED\n");
    }
    else{
        printStr("Test 1: FAILED\n");
    }
    printStr("Enter a positive integer: ");
    error = readInt(&numberRead);
    if(error == OK && numberRead > 0){
        printStr("Test 2: PASSED\n");
    }
    else{
        printStr("Test 2: FAILED\n");
    }
    printStr("Enter 0: ");
    error = readInt(&numberRead);
    if(error == OK && numberRead == 0){
        printStr("Test 3: PASSED\n");
    }
    else{
        printStr("Test 3: FAILED\n");
    }
    printStr("Enter a number greater than INT_MAX: ");
    error = readInt(&numberRead);
    if(error == ERR){
        printStr("Test 4: PASSED\n");
    }
    else{
        printStr("Test 4: FAILED\n");
    }
    printStr("Enter a non-integer: ");
    error = readInt(&numberRead);
    if(error == ERR){
        printStr("Test 5: PASSED\n");
    }
    else{
        printStr("Test 5: FAILED\n");
    }

    printStr("Testing printFlt...\n");
    //We test printFlt by giving a negative float, a positive float and 0
    numberOfCharactersPrinted = 0;
    numberOfCharactersPrinted = printFlt(-123.456);
    if(numberOfCharactersPrinted == 11){
        printStr("Test 1: PASSED\n");
    }
    else{
        printStr("Test 1: FAILED\n");
    }
    numberOfCharactersPrinted = printFlt(123.456);
    if(numberOfCharactersPrinted == 10){
        printStr("Test 2: PASSED\n");
    }
    else{
        printStr("Test 2: FAILED\n");
    }
    numberOfCharactersPrinted = printFlt(0.0);
    if(numberOfCharactersPrinted == 3){
        printStr("Test 3: PASSED\n");
    }
    else{
        printStr("Test 3: FAILED\n");
    }

    printStr("Testing readFlt...\n");
    //We test readFlt by entering a negative float, a positive float, 0 and a non-float
    float numberReadFlt = 0.0;
    printStr("Enter a negative float: ");
    error = readFlt(&numberReadFlt);
    if(error == OK && numberReadFlt < 0.0){
        printStr("Test 1: PASSED\n");
    }
    else{
        printStr("Test 1: FAILED\n");
    }
    printStr("Enter a positive float: ");
    error = readFlt(&numberReadFlt);
    if(error == OK && numberReadFlt > 0.0){
        printStr("Test 2: PASSED\n");
    }
    else{
        printStr("Test 2: FAILED\n");
    }
    printStr("Enter 0: ");
    error = readFlt(&numberReadFlt);
    if(error == OK && numberReadFlt == 0.0){
        printStr("Test 3: PASSED\n");
    }
    else{
        printStr("Test 3: FAILED\n");
    }
    printStr("Enter a non-float: ");
    error = readFlt(&numberReadFlt);
    if(error == ERR){
        printStr("Test 4: PASSED\n");
    }
    else{
        printStr("Test 4: FAILED\n");
    }
    
    printStr("Testing done!\n");
    printStr("Bye World!\n");
    return 0;
}