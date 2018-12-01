#!/usr/bin/ruby

require 'set'

DATA = File.read('data.txt').split.map(&:to_i)

PART1 = DATA.sum
PART2 = DATA
    .cycle
    .each_with_object([Set.new, 0])
    .take_while{ |e, o| o[-1] += e; o.first.add? o.last }
    .last.last.last

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
