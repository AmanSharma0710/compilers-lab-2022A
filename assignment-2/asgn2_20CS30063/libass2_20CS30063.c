#include "myl.h"
#define BUFFER_SIZE 20
//buffer size for char arrays to store strings to be printed and read from the user


//printStr: prints a string of characters without using the printf or cout functions
//Parameters: pointer to the string to be printed
//Returns: number of characters printed without the null character that terminates the string
int printStr(char *str){
    int i = 0;
    while(str[i] != '\0'){
        i++;
    }
    __asm__ __volatile__(
        "movl $1, %%eax\n\t"
        "movq $1, %%rdi\n\t"
        "syscall \n\t"
        :
        :"S"(str), "d"(i)
    );
    return i;
}


//printInt: prints a signed integer with left-alignment
//Parameters: integer to be printed
//Returns: on success number of characters printed, on failure ERR
int printInt(int n){
    char buff[BUFFER_SIZE], zero='0';
    int i = 0, j, k, bytes;
    if(n==0){   //if n is 0, print 0
        buff[i++] = zero;
    }
    else{
        if(n<0){    //if n is negative, print - as first character
            buff[i++] = '-';
            n = -n;
        }
        while(n){   //convert n to a string of characters in buff
            buff[i++] = n%10 + zero;
            n /= 10;
        }
        if(buff[0] == '-'){
            j = 1;
        }
        else{
            j = 0;
        }
        k = i-1;
        while(j<k){     //reverse the string of characters in buff
            char temp = buff[j];
            buff[j++] = buff[k];
            buff[k--] = temp;
        }
    }
    buff[i] = '\n';     //add a newline character to the end of the string
    bytes = i+1;
    __asm__ __volatile__(
        "movl $1, %%eax\n\t"
        "movq $1, %%rdi\n\t"
        "syscall \n\t"      //print the string
        :
        :"S"(buff), "d"(bytes)
    );
    return i;   //returns the number of characters printed
}


//printFlt: prints a floating point number with left-alignment
//Parameters: floating point number to be printed
//Returns: on success number of characters printed, on failure ERR
int printFlt(float f){
    char buff[BUFFER_SIZE];
    int i = 0, j, k;
    if(f<0){        //if f is negative, print - as first character
        buff[i++] = '-';
        f = -f;
    }
    int n = (int)f;     //convert f to an integer and store it in n
    if(n==0){
        buff[i++] = '0';
    }
    else{
        while(n){   //convert n to a string of characters in buff
            buff[i++] = n%10 + '0';
            n /= 10;
        }
        if(buff[0] == '-'){
            j = 1;
        }
        else{
            j = 0;
        }
        k = i-1;
        while(j<k){     //reverse the string of characters in buff
            char temp = buff[j];
            buff[j++] = buff[k];
            buff[k--] = temp;
        }
    }
    buff[i++] = '.';     //add a decimal point to the end of the string
    n = (int)f;
    int decimal = (int)((f - n)*1000000);
    if(decimal==0){
        buff[i++] = '0';
    }
    j = i;
    while(decimal){     //convert decimal to a string of characters in buff
        buff[i++] = decimal%10 + '0';
        decimal /= 10;
    }
    k = i-1;
    while(j<k){     //reverse the string of characters in buff
        char temp = buff[j];
        buff[j++] = buff[k];
        buff[k--] = temp;
    }
    buff[i] = '\n';
    int bytes = i+1;
    __asm__ __volatile__(
        "movl $1, %%eax\n\t"
        "movq $1, %%rdi\n\t"
        "syscall \n\t"
        :
        :"S"(buff), "d"(bytes)
    );
    return i;       //returns the number of characters printed
}


//readInt: reads an integer from the user
//Parameters: pointer to an integer to store the integer read from the user
//Returns: on success OK, on failure ERR
int readInt(int *n){
    char buff[BUFFER_SIZE];
    int i;
    __asm__ __volatile__(
        "movl $0, %%eax\n\t"
        "movq $0, %%rdi\n\t"
        "syscall \n\t"
        :"=a"(i)
        :"S"(buff), "d"(BUFFER_SIZE)
    );
    if(i<0){
        return ERR;
    }
    int positive = 1, idx=0;
    long long ans = 0;      //take a long long to avoid overflow
    if(buff[0] == '-'){
        positive = 0;
        idx = 1;
    }
    else if(buff[0] == '+'){
        idx = 1;
    }
    else{
        idx = 0;
    }
    while(idx<i && buff[idx] != '\n'){
        if(buff[idx]<'0' || buff[idx]>'9'){
            return ERR;
        }
        ans *= 10;
        if(positive){
            ans += buff[idx]-'0';
        }
        else{
            ans -= buff[idx]-'0';
        }
        if(ans>__INT32_MAX__ || ans<__INT32_MAX__*-1 - 1){
            return ERR;
        }
        idx++;
    }
    *n = (int)ans;
    return OK;
}


//readFlt: reads a floating point number from the user
//Parameters: pointer to a floating point number to store the number read from the user
//Returns: on success OK, on failure ERR
int readFlt(float *f){
    char buff[BUFFER_SIZE];
    int i;
    __asm__ __volatile__(
        "movl $0, %%eax\n\t"
        "movq $0, %%rdi\n\t"
        "syscall \n\t"
        :"=a"(i)
        :"S"(buff), "d"(BUFFER_SIZE)
    );
    if(i<0){
        return ERR;
    }
    int positive = 1, idx=0;
    float ans = 0;
    if(buff[0] == '-'){
        positive = 0;
        idx = 1;
    }
    else if(buff[0] == '+'){
        idx = 1;
    }
    else{
        idx = 0;
    }
    while(idx<i && buff[idx]!='\n' && buff[idx]!='.'){
        if(buff[idx]<'0' || buff[idx]>'9'){
            return ERR;
        }
        ans *= 10;
        ans += buff[idx]-'0';
        idx++;
    }
    if(idx<i && buff[idx]=='.'){
        idx++;
        float decimal = 0.1;
        while(idx<i && buff[idx]!='\n'){
            if(buff[idx]<'0' || buff[idx]>'9'){
                return ERR;
            }
            ans += decimal*(buff[idx]-'0');
            decimal /= 10;
            idx++;
        }
    }
    if(buff[idx]!='\n'){
        return ERR;
    }
    if(!positive){
        ans = -ans;
    }
    *f = ans;
    return OK;
}