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
    while arr.size > 0
        elem = arr.shift
        cons = cs
            .each_with_index
            .select{ |cons, _| cons.any? { |c| distance(c, elem) <= 3 } }
        if cons.size
            cs << cons.map(&:first).inject([elem], :+)
            cons.reverse.each{ |_, i| cs.delete_at i }
        else
            cs << [elem]
        end
    end
    cs
end

cs = get_constellations DATA

PART1 =  cs.size

puts 'Part 1: %s' % PART1
