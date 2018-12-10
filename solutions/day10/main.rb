#!/usr/bin/ruby

DATA = File
    .read('data.txt')
    .scan(/position=<.*?(-?\d+),.*?(-?\d+)> velocity=<.*?(-?\d+),.*?(-?\d+)>/)
    .map{ |a| a.map(&:to_i) }

def simulate_second data
    data.map do |a|
        x, y, dx, dy = *a
        [x+dx, y+dy, dx, dy]
    end
end

def make_string data
    arr = data.map{ |a| a[0...2] }
    x_offset = arr.map(&:first).min
    y_offset = arr.map(&:last).min
    to_print = arr.map{ |a| [a[0]-x_offset, a[1]-y_offset] }
    x_max = to_print.map(&:first).max + 1
    y_max = to_print.map(&:last).max + 1
    strs = Array.new(y_max){ ' ' * x_max }
    for pair in to_print
        x, y = *pair
        strs[y][x] = '#'
    end
    strs.join("\n")
end

def get_sizes data
    arr = data.map{ |a| a[0...2] }
    x_offset = arr.map(&:first).min
    y_offset = arr.map(&:last).min
    to_print = arr.map{ |a| [a[0]-x_offset, a[1]-y_offset] }
    x_max = to_print.map(&:first).max + 1
    y_max = to_print.map(&:last).max + 1
    [x_max, y_max]
end

def do_sim data
    i = 0

    last_size = get_sizes data

    loop do
        next_step = simulate_second data
        new_size = get_sizes next_step
        if new_size.zip(last_size).map{ |a| a.inject(:-) }.all?{ |n| n > 0 }
            return {
                str: make_string(data),
                time: i,
            }
        end
        i += 1
        last_size = new_size
        data = next_step
    end
end

RESULTS = do_sim DATA

puts "Part 1:\n%{str}" % RESULTS
puts 'Part 2: %{time}' % RESULTS

