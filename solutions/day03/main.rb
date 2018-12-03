#!/usr/bin/ruby

def arr_to_claim arr
    ret = []
    (arr[1]...(arr[1]+arr[3])).each do |x|
        (arr[2]...(arr[2]+arr[4])).each do |y|
            ret.push [[x, y], [1, [arr[0]]]]
        end
    end
    return ret.to_h
end

$overlaps = {}
DATA = File.read('data.txt')
    .scan(/\#(\d+) \@ (\d+),(\d+): (\d+)x(\d+)/)
    .map{ |n| n.map(&:to_i) }
    .reduce({}) do |t, e|
        if not $overlaps.include? e[0]
            $overlaps[e[0]] = false
        end
        t.merge(arr_to_claim e) do |k, o, n|
            r = [o.first + n.first, o.last + n.last]
            r.last.each{ |x| $overlaps[x] = r.last.size > 1 }
            r
        end
    end

PART1 = DATA.select{|k, v| v.first > 1 }.count
PART2 = $overlaps.select{|k, v| v == false }.map{ |k, v| k }.join(", ")

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
