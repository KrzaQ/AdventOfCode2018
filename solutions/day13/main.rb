#!/usr/bin/ruby

DATA = File.read('data.txt')

CARTS = DATA.each_line.each_with_index.map do |line, y|
    line
        .each_char
        .each_with_index
        .select{ |c, x| c =~ /[<>^v]/ }
        .map{ |c, x| { direction: c, x: x, y: y, changes: 0 } }
end.flatten(1).sort_by{ |c| [c[:y], c[:x]] }

MAP = DATA.gsub(/[<>]/, '-').gsub(/[v^]/, '|').each_line.to_a

def is_crashed cart
    cart[:direction] == 'X'
end

def move_cart cart, all_carts

    return cart if is_crashed cart

    dx, dy = case cart[:direction]
    when '>'
        [1, 0]
    when '<'
        [-1, 0]
    when '^'
        [0, -1]
    when 'v'
        [0, 1]
    end
    
    x = cart[:x] + dx
    y = cart[:y] + dy

    crash = all_carts.find{ |c| [c[:x], c[:y]] == [x, y] }
        
    return cart.merge(direction: 'X', x: x, y: y) if crash

    cart = cart.merge(x: x, y: y)

    case MAP[cart[:y]][cart[:x]]
    when '\\'
        cart[:direction] = {
            '>' => 'v',
            '^' => '<',
            '<' => '^',
            'v' => '>',
        }[cart[:direction]]
    when '/'
        cart[:direction] = {
            '>' => '^',
            '^' => '>',
            '<' => 'v',
            'v' => '<',
        }[cart[:direction]]
    when '+'
        dir = cart[:changes] % 3
        if dir == 0 # left
            cart[:direction] = {
                '>' => '^',
                '^' => '<',
                '<' => 'v',
                'v' => '>',
            }[cart[:direction]]
        elsif dir == 2 # right
            cart[:direction] = {
                '>' => 'v',
                '^' => '>',
                '<' => '^',
                'v' => '<',
            }[cart[:direction]]
        end
        cart[:changes] += 1
    end

    cart
end

def print_carts carts
    m = MAP.map(&:clone)
    carts.each do |c|
        m[c[:y]][c[:x]] = c[:direction]
    end
    puts m.join
end

def simulate carts
    Enumerator.new do |y|
        loop do
            carts = carts
                .sort_by{ |c| [c[:y], c[:x]] }
                .reject{ |c| is_crashed c }

            carts.size.times do |idx|
                carts[idx] = move_cart(carts[idx], carts)
                if is_crashed carts[idx]
                    carts = carts.map do |c|
                        if [c[:x], c[:y]] == [carts[idx][:x], carts[idx][:y]]
                            c[:direction] = 'X'
                        end
                        c
                    end
                end
            end

            y << carts
        end
    end
end

PART1 = simulate(CARTS)
    .lazy
    .map{ |carts| carts.find{ |c| is_crashed c } }
    .select(&:itself)
    .first
    .yield_self{ |c| '%{x},%{y}' % c }

puts 'Part 1: %s' % PART1

PART2 = simulate(CARTS)
    .lazy
    .select{ |carts| carts.count{ |c| not is_crashed c } == 1 }
    .first
    .yield_self{ |c| '%{x},%{y}' % c.find{ |c| not is_crashed c } }

puts 'Part 2: %s' % PART2
