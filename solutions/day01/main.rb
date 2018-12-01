#!/usr/bin/ruby

require 'set'

DATA = File.read('data.txt').split.map(&:to_i)

p DATA.sum

def get_repeated
    i = 0
    s = 0
    f = Set.new
    loop do
        s += DATA[i % DATA.size]
        return s if f.include? s
        f.add s
        i += 1
    end
end
p get_repeated

