#include <iostream>

static void func1(int &a) {
    std::cout << &a << "\n";
}

int main()
{
    // const int a = 10;
    // int b = a;

    // const int *const p = new int(10);
    // // int *p1 = p;
    // // int *const p2 = p;
    // const int *p3 = p;

    // const int *p4 = &a;

    // const int &r1 = a;
    // int &r2 = a;
    // int &r3 = r1;
    // // int &r4 = a;
    // int c = a;
    const int aa = 10;
    // int &ref = aa;
    int bb = 10;
    int &ref1 = bb;
    const int cc = ref1; // 运行时常量 runtime
    func1(bb);
    func1(ref1);
    int m;
}