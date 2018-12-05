#!/usr/bin/ruby

DATA = File.read('data.txt').strip

def react str
    str.each_char
        .each_with_object([' ']) do |e, s|
            if s.last != e and s.last.upcase == e.upcase
                s.pop
            else
                s.push e
            end
        end
        .drop(1)
        .join
end

PART1 = react(DATA).size

PART2 = ('a'..'z').map do |c|
        x = react DATA.gsub(/[#{c}#{c.upcase}]/, '')
        [c, x.size]
    end
    .to_a
    .sort_by{ |k, v| v }
    .first
    .last

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
