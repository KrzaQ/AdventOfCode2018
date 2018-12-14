#include <vector>
#include <cstdint>
#include <array>
#include <algorithm>
#include <iostream>

struct board
{
    std::vector<uint8_t> buf;
    std::array<size_t, 2> elves;
};

void do_step(board&);

std::string part1(board, size_t steps);
size_t part2(board, std::string_view sought);

int main()
{
    board b {
        {3,7,1,0},
        {0, 1}        
    };

    std::cout << "Part 1: " << part1(b, 505961) << '\n';
    std::cout << "Part 2: " << part2(b, "505961") << '\n';
}

std::string part1(board b, size_t steps)
{
    while(b.buf.size() < steps + 10) {
        do_step(b);
    }
    std::string ret(10,0);
    std::transform(b.buf.begin()+steps, b.buf.begin()+steps+10, ret.begin(),
        [](uint8_t x) -> char { return '0' + x; });
    return ret;
}

size_t part2(board b, std::string_view sought)
{
    std::vector<uint8_t> cmp(sought.size());
    std::transform(sought.begin(), sought.end(), cmp.begin(),
        [](char c) -> uint8_t { return c - '0'; });

    b.buf.reserve(200'000'000);

    while(true) {
        size_t prev_size = b.buf.size();
        do_step(b);
        auto diff = b.buf.size() - prev_size;

        for(size_t i = 0; i < diff; i++) {
            if(b.buf.size() > sought.size() + i) {
                if(std::equal(
                    cmp.rbegin(), cmp.rend(),
                    b.buf.rbegin() + i, b.buf.rbegin() + sought.size() + i)){
                    return b.buf.size() - sought.size() - i;
                }
            }
        }
    }
}

void do_step(board& board)
{
    auto new_value = board.buf[board.elves[0]] + board.buf[board.elves[1]];
    
    if(new_value > 9) {
        board.buf.push_back(new_value / 10);
        board.buf.push_back(new_value % 10);
    } else {
        board.buf.push_back(new_value);
    }

    for(auto& e : board.elves) {
        e = board.buf[e] + 1 + e;
        e %= board.buf.size();
    }
}


