#!/usr/bin/ruby

require 'levenshtein'

DATA = File.read('data.txt').split

P1 = DATA.map do |s|
    s.each_codepoint
        .group_by{ |c| c }
        .map{ |k,v| v.count }
        .select{ |v| [2,3].include? v }
end

PART1 = P1.count{ |v| v.include? 2 } * P1.count{ |v| v.include? 3 }

P2 = DATA
    .map{ |v| DATA.reject{ |x| x == v }.zip([v] * (DATA.size-1)) }
    .flatten(1)
    .sort_by{ |k,v| Levenshtein.normalized_distance k, v }

PART2 = P2.first
    .yield_self do |o|
        a,b = o.map(&:each_codepoint)

        a
            .zip(b)
            .reject{ |k, v| k != v}
            .map(&:first)
            .map(&:chr)
            .join
    end

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
