#include <iterator>
#include <vector>
#include <iostream>
#include <algorithm>
#include <list>

using result_t = uint64_t;

result_t solve(int players, int last);

int main()
{
    std::cout << "Part 1: " << solve(403, 71920) << '\n';
    std::cout << "Part 2: " << solve(403, 7192000) << '\n';
}

result_t solve(int players, int last)
{
    std::list<int> arr{0};
    auto cur_it = arr.begin();

    std::vector<result_t> scores(players, 0);

    auto cycle_next = [&](auto& it, int n) {
        for(int i = 0; i < n; i++) {
            if(it == arr.end())
                it = arr.begin();
            std::advance(it, 1);
        }
    };

    auto cycle_prev = [&](auto& it, int n) {
        for(int i = 0; i < n; i++) {
            if(it == arr.begin())
                it = arr.end();
            std::advance(it, -1);
        }
    };

    for(int i = 1; i <= last; i++) {
        if(i % 23) {
            cycle_next(cur_it, 1);
            cur_it = arr.insert(cur_it, i);
            cycle_next(cur_it, 1);
        } else {
            scores[i % players] += i;
            cycle_prev(cur_it, 8);
            scores[i % players] += *cur_it;
            cur_it = arr.erase(cur_it);
            cycle_next(cur_it, 1);
        }
    }
    return *std::max_element(scores.begin(), scores.end());
}

