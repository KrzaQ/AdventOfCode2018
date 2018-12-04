#!/usr/bin/ruby

def parse_multi_line(lines)
    guard = /#(\d+)/.match(lines[0])[1].to_i
    minutes = [0] * 60
    lines[1..-1].each_slice(2) do |b, e|
        ((b[15..16].to_i)...(e[15..16]).to_i).each do |n|
            minutes[n] = 1
        end
    end
    [ guard, minutes ]
end

DATA = File.read('data.txt')
    .split("\n")
    .sort_by{ |l| l[1..16] }
    .join("\n")
    .scan(/.{19}Guard[^G]*up\n/m)
    .map{ |l| parse_multi_line l.split("\n") }
    .reduce({}) do |t, e|
        old = t.fetch(e.first, [0] * 60)
        sum = old.zip(e.last).map(&:sum)
        t[e.first] = sum
        t
    end
    .to_a

PART1 = DATA
    .sort_by{ |k, v| v.sum }
    .last
    .yield_self{ |k, v| k * v.each_with_index.max[1] }

PART2 = DATA
    .sort_by{ |k, v| v.max }
    .last
    .yield_self{ |k, v| k * v.each_with_index.max[1] }

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
