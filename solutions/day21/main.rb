#!/usr/bin/ruby

require 'erb'

def parse_instruction line
    split = line.split
    [
        split.first.to_sym,
        *split[1..-1].map(&:to_i)
    ]
end

DATA = File.read('data.txt').each_line.to_a

IP_REGISTER = DATA[0].scan(/\d+/).map(&:to_i).first

INSTRUCTIONS = DATA[1..-1].map{ |l| parse_instruction l }

t = ERB.new File.read('machine.cpp.erb'), nil, '%<>'

File.write 'machine.cpp', t.result

system 'clang++ machine.cpp -std=c++17 -O3 -o machine'
system './machine'
