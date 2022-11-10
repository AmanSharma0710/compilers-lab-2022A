int main() {
    int n1, n2, n3;
    n1 = n2 << 2;
    n2 = n1 >> 2;
    float f1, f2, f3;
    n3 = n1 * n2 / f3;
    f2 = f1 + (-n2 - n3) * f1;
    n1 = n2 ^ n3;
    n2 = (n1 & n2) | n3;
    n3 = n1 & (n2 | n3);
    float *q1, **q2;
    q2 = &q1;
    q1 = *q2;
    *q1 = **q2;
    **q2 = *q1;
    ++n1;
    n2++;
    n3 = ~n2;
    n3 = +n2;
    n3 = -n2;
    return 0;
}
