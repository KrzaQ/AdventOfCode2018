#!/usr/bin/ruby

def solve players, max
    arr = [0]
    marble = 1
    cur = 0
    scores = Array.new(players){ 0 }
    (1..max).each do |marble|
        if marble % 23 > 0
            new_cur = cur % arr.size + 1
            arr.insert(new_cur, marble)
            cur = new_cur + 1
        else
            scores[marble % players] += marble
            new_cur = cur - 8
            new_cur += arr.size if new_cur < 0
            scores[marble % players] += arr.delete_at new_cur
            cur = new_cur + 1
        end
        marble += 1
    end
    scores.max
end

puts 'Part 1: %s' % solve(403, 71920)
# puts 'Part 2: %s' % solve(403, 71920*100)

