#!/usr/bin/ruby

DATA = File.read('data.txt').each_line.to_a.map(&:strip)

class Array
    def fetch_kq idx, default = nil
        (idx < 0 or idx >= self.size) ? default : self[idx]
    end
end

class String
    def fetch_kq idx, default = nil
        (idx < 0 or idx >= self.size) ? default : self[idx]
    end
end

def next_value map, x, y
    around =[
        map.fetch_kq(y-1,[]).fetch_kq(x-1),
        map.fetch_kq(y-1,[]).fetch_kq(x-0),
        map.fetch_kq(y-1,[]).fetch_kq(x+1),
        map.fetch_kq(y-0,[]).fetch_kq(x-1),
        map.fetch_kq(y-0,[]).fetch_kq(x+1),
        map.fetch_kq(y+1,[]).fetch_kq(x-1),
        map.fetch_kq(y+1,[]).fetch_kq(x-0),
        map.fetch_kq(y+1,[]).fetch_kq(x+1),
    ]

    around = around.select(&:itself)

    case map[y][x]
    when '.'
        around.count{ |c| c == '|' } >= 3 ? '|' : '.'
    when '|'
        around.count{ |c| c == '#' } >= 3 ? '#' : '|'
    when '#'
        lumberyards = around.count{ |c| c == '#' }
        trees = around.count{ |c| c == '|' }
        (lumberyards > 0 and trees > 0) ? '#' : '.'
    end
end


def next_step map
    (0...map.size).map do |y|
        (0...map[0].size).map do |x|
            next_value map, x, y
        end.join
    end
end

def simulate_steps map, steps
    cache = {}
    steps.times do |n|
        joined = map.join
        if cache.has_key? joined
            diff = cache[joined] - n
            if (steps-n) % diff == 0
                return map
            end
        end
        cache[map.join] = n
        map = next_step map
    end
    map
end

P1 = simulate_steps(DATA, 10).join.each_char.to_a
PART1 = P1.count{ |c| c == '|' } * P1.count{ |c| c == '#' }

P2 = simulate_steps(DATA, 1000000000).join.each_char.to_a
PART2 = P2.count{ |c| c == '|' } * P2.count{ |c| c == '#' }

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
