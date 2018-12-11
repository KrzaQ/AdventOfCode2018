#!/usr/bin/ruby

SERIAL = File
    .read('data.txt')
    .to_i

def calc_cell x, y, serial
    rack = x + 10
    power_lvl = rack * y
    power_lvl += serial
    power_lvl *= rack
    power_lvl = (power_lvl/100).to_i % 10
    power_lvl - 5
end

GRID = (0..300).map do |y|
        (0..300).map{ |x| calc_cell x, y, SERIAL }
    end


def calc_grid_p1 x, y
    (0...3).to_a
        .product((0...3).to_a)
        .map{ |ox, oy| calc_cell(x+ox, y+oy, SERIAL) }
        .sum
        .yield_self do |s|
            {
                sum: s,
                x: x,
                y: y,
            }
        end
end

def calc_grid_p2 x, y
    max_size = 300-[x,y].max
    prev = 0
    r = (1..max_size).map do |max|

        added = (0...max).map do |oz|
            GRID[y+max-1][x+oz] +
            GRID[y+oz][x+max-1]
        end.sum
        added -= GRID[y+max-1][x+max-1]

        prev += added

        {
            sum: prev,
            size: max,
        }
    end.sort_by{ |x| x[:sum] }.last
    r.merge(x: x, y: y)
end

PART1 = (1..300).to_a.product((1..300).to_a)
    .map{ |x, y| calc_grid_p1 x, y }
    .sort_by{ |r| r[:sum] }
    .last

PART2 = (1...300).to_a.product((1...300).to_a)
    .map{ |x, y| calc_grid_p2 x, y }
    .sort_by{ |r| r[:sum] }
    .last

puts 'Part 1: %{x},%{y}' % PART1
puts 'Part 2: %{x},%{y},%{size}' % PART2

