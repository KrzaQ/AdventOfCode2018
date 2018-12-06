#!/usr/bin/ruby

DATA = File
    .read('data.txt')
    .scan(/(\d+), (\d+)/)
    .map{ |x| x.map(&:to_i) }

XMIN, XMAX = DATA.map(&:first).minmax
YMIN, YMAX = DATA.map(&:last).minmax

OBJS = DATA.each_with_index.to_a

P1 = (XMIN..XMAX).map do |x|
    (YMIN..YMAX).map do |y|
        s = OBJS
            .map{ |a, idx| [(x-a[0]).abs + (y-a[1]).abs, idx] }
            .sort_by{ |a| a[0] }
        s[0][0] == s[1][0] ? nil : s[0][1]
    end
end

PART1 = P1
    .flatten
    .group_by(&:itself)
    .map{ |k, v| [k, v.size] }
    .sort_by{ |k, v| v }
    .last.last

P2 = (XMIN..XMAX).map do |x|
    (YMIN..YMAX).map do |y|
        OBJS
            .map{ |a, idx| (x-a[0]).abs + (y-a[1]).abs }
            .sum
            .yield_self{ |n| n < 10000 }
    end
end

PART2 = P2
    .flatten
    .count(&:itself)

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
