int mod;


int gcd(int a, int b) {
    if(b == 0)
        return a;
    return gcd(b, a % b);
}

int main() {
    int a = 9, b = 3;
    gcd(a, b);    
    return 0;
}
