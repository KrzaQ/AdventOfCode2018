#include <iterator>
#include <vector>
#include <iostream>
#include <algorithm>
#include <list>
using namespace std;

using result_t = uint64_t;

result_t solve(int players, int last);

int main()
{
    std::cout << "Part 1: " << solve(403, 71920) << std::endl;
    std::cout << "Part 2: " << solve(403, 7192000) << std::endl;
}

result_t solve(int players, int last)
{
    list<int> arr{0};
    auto cur_it = arr.begin();

    vector<result_t> scores(players, 0);

    for(int i = 1; i <= last; i++) {
        if(i % 23) {
            if(cur_it == arr.end())
                cur_it = arr.begin();
            advance(cur_it, 1);
            cur_it = arr.insert(cur_it, i);
            if(cur_it == arr.end())
                cur_it = arr.begin();
            advance(cur_it, 1);
        } else {
            scores[i % players] += i;
            for(int dec = 8; dec > 0; dec--) {
                if(cur_it == arr.begin())
                    cur_it = arr.end();
                advance(cur_it, -1);
            }
            scores[i % players] += *cur_it;
            cur_it = arr.erase(cur_it);
            if(cur_it == arr.end())
                cur_it = arr.begin();
            advance(cur_it, 1);
        }
    }
    return *std::max_element(scores.begin(), scores.end());
}

