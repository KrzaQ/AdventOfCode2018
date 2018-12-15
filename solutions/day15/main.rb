#!/usr/bin/ruby

DATA = File.read('data.txt')

UNITS = DATA.each_line.each_with_index.map do |line, y|
    line
        .each_char
        .each_with_index
        .select{ |c, x| c =~ /[GE]/ }
        .map{ |c, x| { type: c, x: x, y: y, hp: 200 } }
end.flatten(1).sort_by{ |c| [c[:y], c[:x]] }

MAP = DATA.gsub(/[GE]/, '.').each_line.to_a
SEARCH_ORDER = [[0, -1], [-1, 0], [1, 0], [0, 1]]

$debug = false

def find_closest_enemy u, units


    m = MAP.join.each_line.to_a
    # puts m.join
    units.each{ |u| m[u[:y]][u[:x]] = u[:type] }

    enemy = case u[:type]
    when 'G'
        'E'
    when 'E'
        'G'
    end

    # search = SEARCH_ORDER.map do |dx, dy|
    #         x = u[:x] + dx
    #         y = u[:y] + dy
    #         [x, y]
    #     end
    #     .reject{ |x, y| m[y][x] == u[:type] }
    #     .reject{ |x, y| m[y][x] == '#' }
    search = [[u[:x], u[:y]]]

    # p search
    found = []

    200.times do |n|
        new_search = []
        search.each do |sx, sy|
            # p [ 99, sx, sy]
            SEARCH_ORDER.each do |dx, dy|
                # dx, dy = a
                x = sx + dx
                y = sy + dy
                next if x >= m[0].size or y >= m.size
                next if x < 0 or y < 0
                next if m[y][x] == '#'
                next if m[y][x] == u[:type]
                next if m[y][x] == 'X'
                
                if m[y][x] == enemy
                    found << [x, y]
                else
                    m[y][x] = 'X'
                    new_search << [x, y]
                end
            end
        end
        search = new_search
        # p search
        break if found.size > 0
    end
    # puts m.join
    found = found.sort.uniq

    if found.size > 0
        # p found
        return [found.sort_by{ |x, y| [y, x] }.first]
    else
        return nil
    end
end

def next_step_to_closest_enemy u, units
    # p ['unit', u]
    m = MAP.join.each_line.to_a
    # puts m.join
    units.each{ |u| m[u[:y]][u[:x]] = u[:type] }

    finished = false

    enemy = case u[:type]
    when 'G'
        'E'
    when 'E'
        'G'
    end


    distances = Array.new(m.size){ Array.new(m[0].size){ 9999 } }
    # p distances
    # search = units.select{ |u| u[:type] == enemy }.map{ |u| [u[:x], u[:y]] }
    search = find_closest_enemy u, units

    return nil if not search

    if $debug
        puts 'Search: %s' % search.inspect
    end

    500.times do |n|

        # p ['s', search]
        new_search = []
        search.each do |sx, sy|
            SEARCH_ORDER.each_with_index.each do |a, i|
                dx, dy = a
                x = sx+dx
                y = sy+dy
                next if x >= m[0].size or y >= m.size
                next if x < 0 or y < 0
                next if m[y][x] != '.'
                # m[y][x] = (0x31 + n).chr
                # p [66, x, y]
                if n == 0
                    dist = i
                else
                    dist = distances[sy][sx]+4
                end
                next if distances[y][x] <= dist
                distances[y][x] = dist
                new_search << [x, y]
            end
        end
        search = new_search
        break if search.size == 0
    end
    if $debug
        puts m.join
        p u
        puts distances.map{ |a| a.map{ |x| '%5s' % x }.join(' ') }.join("\n")
    end
    arr = SEARCH_ORDER
        .map{ |x, y| m[u[:y]+y][u[:x]+x] }
        .each_with_index
        .reject{ |c, _| c =~ /[GE#\.]/ }
    
    arr = SEARCH_ORDER
        .map{ |x, y| [u[:x]+x, u[:y]+y] }
        .map{ |x, y| distances[y][x] }
        .each_with_index
        .reject{ |d, _| d > 9995 }
        .to_a

    # p arr
    idx = arr
        .reverse
        .min
        
        # .reverse
    # p idx
    return [nil, nil] unless idx
    SEARCH_ORDER[idx.last]
end

def find_enemy_to_attack u, units
    enemy = case u[:type]
    when 'G'
        'E'
    when 'E'
        'G'
    end

    available_enemies = SEARCH_ORDER
        .map{ |x, y| [u[:x]+x, u[:y]+y] }
        .map{ |x, y| units.find{ |u| [u[:x],u[:y]] == [x, y] } }
        .select(&:itself)
        .select{ |u| u[:type] == enemy }
        # .first

    return nil unless available_enemies.size > 0

    return available_enemies
        .each_with_index
        .sort_by{ |e, i| [e[:hp], i] }
        .first.first

    # p available_enemies

    enemies = units
        .each_with_index
        .map{ |u, i| [u[:hp], i] }
        .sort
        .map{ |_, i| units[i] }
        .select{ |u| u[:type] == enemy }

    puts '000'
    p [u, u.object_id]
    p enemies

    return nil if enemies.size == 0

    enemies = enemies
        .select{ |u| u[:hp] == enemies.first[:hp] }
    p enemies

    p SEARCH_ORDER
        .map{ |x, y| p [u[:x]+x, u[:y]+y] }
        .map{ |x, y| p enemies.find{ |u| [u[:x],u[:y]] == [x, y] } }
        .select(&:itself)
        .first

    # SEARCH_ORDER
    #     .select(&:itself)
    #     .reject{ |u| u[:type] != enemy }
    #     .reverse
    #     .map{ |u| [u[:hp], u] }
    #     .min
end

def do_round units, eap = 3
    idx = 0
    loop do
        # p [idx, units.size]
        break if idx >= units.size
        break if units.map{ |u| u[:type] }.sort.uniq.size == 1
        
        # p units

        enemy = find_enemy_to_attack units[idx], units

        # p enemy
        
        if not enemy
            x, y = next_step_to_closest_enemy units[idx], units
            # p [units[idx], x, y]

            if x and y
                units[idx][:x] += x
                units[idx][:y] += y
            end
        
            print_units units if $debug


            enemy = find_enemy_to_attack units[idx], units
        end

        # p units[idx]

        idx += 1
        next unless enemy

        enemy_idx = units.each_with_index
            .find{ |u, i| u.object_id == enemy.object_id }
        # p [idx-1, enemy_idx.last]
        
        if enemy_idx
            enemy_idx = enemy_idx.last
            if units[enemy_idx][:type] == 'G'
                units[enemy_idx][:hp] -= eap
            else
                units[enemy_idx][:hp] -= 3
            end

            # puts '%s[%s,%s] -> %s[%s,%s] (hp %s -> %s)' % [
            #     units[idx-1][:type],
            #     units[idx-1][:x],
            #     units[idx-1][:y],
            #     units[enemy_idx][:type],
            #     units[enemy_idx][:x],
            #     units[enemy_idx][:y],
            #     (units[enemy_idx][:hp]+3),
            #     units[enemy_idx][:hp],
            # ]

            if units[enemy_idx][:hp] < 1
                idx -= 1
                units.delete_at enemy_idx
            end
        end
    end
    units
end

def print_units units
    m = MAP.join.each_line.map(&:strip)
    units.each do |u|
        m[u[:y]][u[:x]] = u[:type]
    end

    m.each_with_index do |l, i|
        m[i] += '   ' + units
            .select{ |u| u[:y] == i }
            .sort_by{ |u| u[:x] }
            .map{ |u, i| '%{type}(%{hp})' % u }
            .join(', ')
    end
    puts m.join("\n")
end

def do_sim units
    n = 1
    units = units.sort_by{ |u| [u[:y], [u[:x]]] }
    loop do
        # $debug = true if n == 24
        # $debug = true
        # p $debug
        units = do_round units
        units = units.sort_by{ |u| [u[:y], [u[:x]]] }
        n += 1
        puts '=' * 80
        puts "Round #{n-1}"
        print_units units
        p units
        puts '=' * 80
        # break if n > 1
        break if units.map{ |u| u[:type] }.sort.uniq.size == 1
    end
    print_units units
    p units
    p [n, units.map{ |u| u[:hp] }.sum]
    (n-2) * units.map{ |u| u[:hp] }.sum
end

p do_sim UNITS

def do_sim_huj units_orig
    elves_count = units_orig.count{ |u| u[:type] == 'E' }
    (4..100).each do |eap|
        n = 1
        units = units_orig.map(&:clone).sort_by{ |u| [u[:y], [u[:x]]] }
        loop do
            # $debug = true if n == 24
            # $debug = true
            # p $debug
            units = do_round units, eap
            units = units.sort_by{ |u| [u[:y], [u[:x]]] }
            n += 1
            # puts '=' * 80
            # puts "Round #{n-1}"
            # print_units units
            # p units
            # puts '=' * 80
            # break if n > 1
            break if units.map{ |u| u[:type] }.sort.uniq.size == 1
        end
        curr = units.count{ |u| u[:type] == 'E' }
        if curr == elves_count
            puts "eap: #{eap}"
            print_units units
            p units
            p [n, units.map{ |u| u[:hp] }.sum]
            (n-2) * units.map{ |u| u[:hp] }.sum
            break
        end
    end
end

# p do_sim_huj UNITS

# p UNITS
# p do_round UNITS
# puts 'Part 1: %s' % PART1
# puts 'Part 2: %s' % PART2
