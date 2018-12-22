#!/usr/bin/ruby

DEPTH = 5355
TARGET = [14, 796]
# 
# DEPTH = 510
# TARGET = [10, 10]

class Map
    attr_accessor :cache
    attr_accessor :coords

    def initialize c
        self.coords = c
        self.cache = {}
    end

    def geologic_index x, y
        el = cache.fetch([x, y], nil)
        return el if el

        el = if [x, y] == coords
            0
        elsif y == 0
            x * 16807
        elsif x == 0
            y * 48271
        else
            erosion_level(x-1, y) * erosion_level(x, y-1)
        end
        
        cache[[x, y]] = el

        el
    end

    def erosion_level x, y
        r = geologic_index(x, y) + DEPTH
        r % 20183
    end

    def terrain_type x, y
        erosion_level(x, y) % 3
    end
end

def part1
    m = Map.new TARGET
    
    TARGET.first.succ.times.map do |x|
        TARGET.last.succ.times.map do |y|
            m.erosion_level(x, y) % 3
        end.sum
    end.sum
end

def part2
    sought = [*TARGET, :torch]

    m = Map.new TARGET

    traversed = {
        [0, 0, :torch] => 0
    }

    valid_mode = lambda do |x, y, mode|
        case m.terrain_type(x, y)
        when 0; [:torch, :gear]
        when 1; [:gear, :neither]
        when 2; [:torch, :neither]
        end.include? mode
    end

    get_neighbours = lambda do |x, y, mode|
        other_modes = [:torch, :gear, :neither].reject{ |m| m == mode }

        [
            [x - 1, y, mode],
            [x + 1, y, mode],
            [x, y - 1, mode],
            [x, y + 1, mode],
            [x, y, other_modes.first],
            [x, y, other_modes.last],
        ].reject do |nx, ny, nmode|
            nx - 25 > TARGET.first
        end.reject do |nx, ny, nmode|
            ny - 40 > TARGET.last
        end.reject do |nx, ny, nmode|
            nx < 0 or ny < 0
        end.select do |nx, ny, nmode|
            valid_mode[nx, ny, nmode]
        end
    end

    new_neighbours = lambda do |pos|
        x, y, mode, dist = pos
        result = []
        get_neighbours[*pos[0...3]].each do |n|
            nx, ny, nmode = n
            diff = mode == nmode ? 1 : 7
            if not traversed.has_key? n
                result << [*n, dist+diff]
            end
        end
        result
    end

    reachable = new_neighbours[[0, 0, :torch, 0]]

    loop do
        reachable = reachable
            .sort_by{ |a| a.last }
            .uniq
            .reject{ |a| traversed.has_key? a[0...3] }
        first_closest = reachable.shift

        raise "???" unless first_closest

        traversed[first_closest[0...3]] = first_closest.last

        new_neighbours[first_closest].each do |n|
            nx, ny, nmode, ndist = n
            reachable << n
        end

        if traversed.has_key? sought
            return traversed[sought]
        end
    end

end

PART1 = part1
PART2 = part2


puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
