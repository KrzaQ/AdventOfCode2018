// Code generated in Ruby. You've been warned.

#include <array>
#include <iostream>
#include <functional>
#include <vector>
#include <type_traits>
#include <unordered_set>

template<int IP>
struct machine
{
    std::array<int, 6> registers;
    int instruction;

    machine(int first_value):
        registers{{first_value}}
    {}

    int& ip() { return registers[IP]; }

    template<int A, int B, int C>
    void addr() { registers[C] = registers[A] + registers[B]; }

    template<int A, int B, int C>
    void addi() { registers[C] = registers[A] + B; }
    
    template<int A, int B, int C>
    void mulr() { registers[C] = registers[A] * registers[B]; }

    template<int A, int B, int C>
    void muli() { registers[C] = registers[A] * B; }
    
    template<int A, int B, int C>
    void banr() { registers[C] = registers[A] & registers[B]; }

    template<int A, int B, int C>
    void bani() { registers[C] = registers[A] & B; }
    
    template<int A, int B, int C>
    void borr() { registers[C] = registers[A] | registers[B]; }

    template<int A, int B, int C>
    void bori() { registers[C] = registers[A] | B; }
    
    template<int A, int, int C>
    void setr() { registers[C] = registers[A]; }

    template<int A, int, int C>
    void seti() { registers[C] = A; }
    
    template<int A, int B, int C>
    void gtir() { registers[C] = A > registers[B]; }
    
    template<int A, int B, int C>
    void gtri() { registers[C] = registers[A] > B; }
    
    template<int A, int B, int C>
    void gtrr() { registers[C] = registers[A] > registers[B]; }
    
    template<int A, int B, int C>
    void eqir() { registers[C] = A == registers[B]; }
    
    template<int A, int B, int C>
    void eqri() { registers[C] = registers[A] == B; }
    
    template<int A, int B, int C>
    void eqrr() { registers[C] = registers[A] == registers[B]; }
};

int main(int argc, char** argv)
{
    using m = machine<4>;

    std::unordered_set<int> found;
    int last_inserted;

    m sym{0};

    LABEL_0:
    sym.seti<123,0,2>();
    sym.ip()++;
    LABEL_1:
    sym.bani<2,456,2>();
    sym.ip()++;
    LABEL_2:
    sym.eqri<2,72,2>();
    sym.ip()++;
    LABEL_3:
    sym.addr<2,4,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_4:
    sym.seti<0,0,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_5:
    sym.seti<0,8,2>();
    sym.ip()++;
    LABEL_6:
    sym.bori<2,65536,5>();
    sym.ip()++;
    LABEL_7:
    sym.seti<2238642,0,2>();
    sym.ip()++;
    LABEL_8:
    sym.bani<5,255,3>();
    sym.ip()++;
    LABEL_9:
    sym.addr<2,3,2>();
    sym.ip()++;
    LABEL_10:
    sym.bani<2,16777215,2>();
    sym.ip()++;
    LABEL_11:
    sym.muli<2,65899,2>();
    sym.ip()++;
    LABEL_12:
    sym.bani<2,16777215,2>();
    sym.ip()++;
    LABEL_13:
    sym.gtir<256,5,3>();
    sym.ip()++;
    LABEL_14:
    sym.addr<3,4,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_15:
    sym.addi<4,1,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_16:
    sym.seti<27,3,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_17:
    sym.seti<0,8,3>();
    sym.ip()++;
    LABEL_18:
    sym.addi<3,1,1>();
    sym.ip()++;
    LABEL_19:
    sym.muli<1,256,1>();
    sym.ip()++;
    LABEL_20:
    sym.gtrr<1,5,1>();
    sym.ip()++;
    LABEL_21:
    sym.addr<1,4,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_22:
    sym.addi<4,1,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_23:
    sym.seti<25,4,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_24:
    sym.addi<3,1,3>();
    sym.ip()++;
    LABEL_25:
    sym.seti<17,2,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_26:
    sym.setr<3,9,5>();
    sym.ip()++;
    LABEL_27:
    sym.seti<7,9,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_28:
    sym.eqrr<2,0,3>();
    sym.ip()++;
    if(found.size() == 0) {
        std::cout << "Part 1: " << sym.registers[2] << "\n";
    }
    if(found.insert(sym.registers[2]).second) {
        last_inserted = sym.registers[2];
    } else {
        std::cout << "Part 2: " << last_inserted << "\n";
        return 0;
    }
    LABEL_29:
    sym.addr<3,4,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_30:
    sym.seti<5,0,4>();
    sym.ip()++;
    switch(sym.registers[4]) {
        case 0: goto LABEL_0;
        case 1: goto LABEL_1;
        case 2: goto LABEL_2;
        case 3: goto LABEL_3;
        case 4: goto LABEL_4;
        case 5: goto LABEL_5;
        case 6: goto LABEL_6;
        case 7: goto LABEL_7;
        case 8: goto LABEL_8;
        case 9: goto LABEL_9;
        case 10: goto LABEL_10;
        case 11: goto LABEL_11;
        case 12: goto LABEL_12;
        case 13: goto LABEL_13;
        case 14: goto LABEL_14;
        case 15: goto LABEL_15;
        case 16: goto LABEL_16;
        case 17: goto LABEL_17;
        case 18: goto LABEL_18;
        case 19: goto LABEL_19;
        case 20: goto LABEL_20;
        case 21: goto LABEL_21;
        case 22: goto LABEL_22;
        case 23: goto LABEL_23;
        case 24: goto LABEL_24;
        case 25: goto LABEL_25;
        case 26: goto LABEL_26;
        case 27: goto LABEL_27;
        case 28: goto LABEL_28;
        case 29: goto LABEL_29;
        case 30: goto LABEL_30;
        default: goto LABEL_31;
    }
    LABEL_31:

    std::cout << sym.registers[0] << '\n';
}

