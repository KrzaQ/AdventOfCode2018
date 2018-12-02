#!/usr/bin/ruby

DATA = File.read('data.txt').split

P1 = DATA.map do |s|
    s.each_codepoint
        .group_by{ |c| c }
        .map{ |k,v| v.count }
        .select{ |v| [2,3].include? v }
end

PART1 = P1.count{ |v| v.include? 2 } * P1.count{ |v| v.include? 3 }

def each_pair
    Enumerator.new(DATA.size * (DATA.size-1)) do |out|
        DATA.each do |l|
            DATA.each do |r|
                next if l == r
                out << [l, r]
            end
        end
    end
end

def count_dist l, r
    out = l.each_codepoint.zip(r.each_codepoint).select{ |l, r| l == r }
    out.size == l.size - 1 ? out.map(&:first).map(&:chr).join : nil
end

PART2 = each_pair
    .lazy
    .map{ |l, r| count_dist l, r }
    .select{ |v| v }
    .first

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
