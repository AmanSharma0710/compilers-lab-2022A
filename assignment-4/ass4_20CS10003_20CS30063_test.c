/*
    Abhinav Sen
    Aman Sharma
*/

//single line comment

inline void test(const int a){
    auto b = 2;
    _Bool a;
    _Complex d;
    _Imaginary c;
    return;
}

enum myEnum{
    var1, var2, var3, var4
};

void main() {
    static int a;
    a = sizeof(float);
    short int b = 2;
    long int c = 1;
    for(int i = 0; i<a; i++){
        //random operations
        b = b^b;
        b *=b;
        b /=b;
        b+=b;
        b-=b;
        if(b<=b) continue;
        if(b>=b) continue;
        b&=b;
        if(b<b) continue;
        else if(b>b) break;
        b%=b;
        b|=b;
        b^=b;
        c = c%b;
        c = c+1;
        c = c*1;
        c = b-2;
        c = c&4;
        c++;
        c--;
        c<<2;
        c>>2;
        if(c&&b) continue;
        else continue;
        if(c||b) continue;
        c = (c!=b)? c: c;
    }
    char s[] = "\', \", \? \\, \a \b, \f, \n, \r, \t, \v";
    int *y = {1, 2, 3};
    //myStruct z;
    //z.a = 1;
    int q = 1;
    double a1 = 1.5;
    double a2 = 1.5434e2;
    unsigned l = 12312312312;
    //myStruct *z1 = &z;
    no_reason:
    switch(q){
        case 1:
            q = 3;
            if(q==1) goto no_reason;
        default:
            break;

    }
    return;
}