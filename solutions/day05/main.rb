#!/usr/bin/ruby

DATA = File.read('data.txt').strip

copy = [DATA.clone, true]

def make_pass input, hint
    hint = [hint-1, 0].max
    n = hint
    found = input.size

    while n < input.size-1
        e1 = input[n]
        e2 = input[n+1]
        if e1.upcase == e2.upcase and e1 != e2
            found = [found, n].min
            input[n..(n+1)] = '??'
            n += 1
        end
        n += 1
    end

    orig_size = input.size
    input.gsub!('?','')
    [input, input.size != orig_size, found]
end

def react str
    arr = [str, true, 0]
    loop do
        arr = make_pass arr.first, arr.last
        break unless arr[1]
    end
    arr.first
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
