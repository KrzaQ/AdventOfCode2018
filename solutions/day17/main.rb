#!/usr/bin/ruby

require 'set'

def parse_line l
    rx = /(.)=(\d+), (.)=(\d+)\.\.(\d+)/
    m = rx.match l
    (m[4].to_i..m[5].to_i)
        .map{ |i| { m[1] => m[2].to_i, m[3] => i } }
        .map{ |h| [h['x'], h['y']] }
end

DATA = File.read('data.txt')
    .each_line
    .map{ |l| parse_line l }
    .flatten(1)

MIN_Y, MAX_Y = DATA.map(&:last).minmax
MIN_X, MAX_X = DATA.map(&:first).minmax

def make_array
    a = Array.new(MAX_Y - MIN_Y + 1) do
        '.' * (MAX_X - MIN_X + 3)
    end
    DATA.each do |x, y|
        x = x - MIN_X + 1
        y = y - MIN_Y
        a[y][x] = '#'
    end
    a
end

def fill a

    faucets = [[500 - MIN_X + 1, 0]]

    done = Set.new
    loop do
        new_faucets = []
        faucets.each do |fx, fy|
            end_idx = a[fy..-1].find_index{ |v| v[fx] !~ /[\.|]/ }
            
            if not end_idx
                (fy...a.size).each do |my|
                    a[my][fx] = '|'
                end
                next
            end

            (fy...(fy+end_idx)).each do |my|
                a[my][fx] = '|'
            end

            fully = fy + end_idx - 1
            fully -= 1 if fully == a.size - 1

            before = new_faucets.size
            loop_done = false
            while fully >= 0 and not loop_done

                row = a[fully]
                next_row = a[fully+1]

                left, right = nil, nil
                for fullx in (0..fx).to_a.reverse
                    if row[fullx] == '#'
                        left = [fullx, :wall]
                        break
                    elsif next_row[fullx] !~ /[\#X]/
                        left = [fullx, :leak]
                        break
                    end
                end
                for fullx in (fx...row.size)
                    if row[fullx] == '#'
                        right = [fullx, :wall]
                        break
                    elsif next_row[fullx] !~ /[\#X]/
                        right = [fullx, :leak]
                        break
                    end
                end

                if right.last == :leak
                    new_faucets << [right.first, fully]
                    loop_done = true
                end
                
                if left.last == :leak
                    new_faucets << [left.first, fully]
                    loop_done = true
                end

                what_do = case [left, right].map(&:last)
                when [:wall, :wall]
                    ['X', ((left.first+1)..(right.first-1))]
                when [:leak, :wall]
                    ['|', ((left.first)..(right.first-1))]
                when [:wall, :leak]
                    ['|', ((left.first+1)..(right.first))]
                when [:leak, :leak]
                    ['|', ((left.first)..(right.first))]
                end
                
                for x in what_do.last
                    row[x] = what_do.first
                end

                fully -= 1
            end
        end

        faucets.each do |f|
            done << f
        end

        new_faucets = new_faucets.sort.uniq - done.to_a
        faucets = new_faucets
        break if new_faucets.size == 0
    end

    a
end

def simulate
    a = make_array
    fill a
end

SIMULATED = simulate
# puts SIMULATED.join("\n")

PART1 = SIMULATED.join.each_char.select{ |c| ['|', 'X'].include? c }.count
PART2 = SIMULATED.join.each_char.select{ |c| ['X'].include? c }.count

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
