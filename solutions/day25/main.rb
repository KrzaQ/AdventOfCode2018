#!/usr/bin/ruby

DATA = File.read('data.txt')
    .scan(/-?\d+/)
    .map(&:to_i)
    .each_slice(4)
    .to_a

def distance a, b
    a.zip(b).map{ |a,b| (a-b).abs }.sum
end

def get_constellations arr
    cs = []
    current = []
    while arr.size > 0
        # p [arr.size, current.size]
        if current.size == 0
            current << arr.shift
        else
            idx = arr.index{ |el| current.rindex { |c| distance(el, c) <= 3 } }
            if idx
                current << arr.delete_at(idx)
            else
                cs << current
                current = []
            end
        end
    end
    cs << current if current.size > 0
    cs
end

cs = get_constellations DATA.sort_by{ |el| distance el, [0,0,0,0] }

PART1 =  cs.size

puts 'Part 1: %s' % PART1
