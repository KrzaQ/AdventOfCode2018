#!/usr/bin/ruby

require 'set'

DATA = File
    .read('data.txt')

HAVE_PLANT = DATA
    .scan(/.{5} => #/)
    .map{ |s| s[0...5] }
    .to_set

BUF = '.' * 300

INPUT = DATA
    .each_line
    .first
    .scan(/[\.#]/)
    .join
    .yield_self{ |s| "#{BUF}#{s}#{BUF}" }
    .each_char
    .to_a
    .freeze

def do_round arr
    arr.each_with_index.map do |c, i|
        pattern = ((i-2)..(i+2))
            .map{ |idx| idx >= 0 ? arr.fetch(idx, '.') : '.' }
            .join
        has = HAVE_PLANT.include? pattern
        has ? '#' : '.'
    end
end

def calc_score arr
    arr.each_with_index
        .select{ |c, i| c == '#' }
        .map{ |c, i| i - BUF.size }
        .sum
end

def part1 arr
    20.times{ arr = do_round arr }
    calc_score arr
end

def part2 arr
    patterns = {}
    BUF.size.times do |i|
        arr = do_round arr
        pattern = arr.join.gsub('.', ' ').strip
        if patterns.include? pattern
            if i - 1 != patterns[pattern]
                puts "Unexpected cycle length! #{i - patterns[pattern]}"
            end

            cycles_left = 50000000000 - i - 1

            score = calc_score arr
            score_diff = calc_score(do_round arr) - score

            return score + cycles_left * score_diff
        end
        patterns[pattern] = i
    end
    raise "Buffer to small! (#{BUF.size})"
end

PART1 = part1 INPUT
PART2 = part2 INPUT

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
