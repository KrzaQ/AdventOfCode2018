#!/usr/bin/ruby

DATA = File.read('data.txt')

PRX = /Before: \[\d+, \d+, \d+, \d+\]\n\d+ \d+ \d+ \d+\nAfter:  \[\d+, \d+, \d+, \d+\]/

PROG = File.read('prog.txt')
    .each_line
    .map{ |l| l.scan(/\d+/).map(&:to_i) }

FUNCTIONS = [
    :addr, :addi,
    :mulr, :muli,
    :banr, :bali,
    :borr, :bori,
    :setr, :seti,
    :gtir, :gtri, :gtrr,
    :eqir, :eqri, :eqrr,
]

def parse_function lines
    lines = lines.each_line.to_a
    before = lines[0].scan(/\d+/).map(&:to_i)
    after = lines[2].scan(/\d+/).map(&:to_i)
    op = lines[1].scan(/\d+/).map(&:to_i)

    {
        before: before,
        after: after,
        op: op[0],
        params: op[1..-1],
    }
end

PARSED_OPS = DATA
    .scan(PRX)
    .map{ |s| parse_function s }

class Machine
    attr_accessor :registers

    def initialize regs
        self.registers = regs
    end

    def addr a, b, c
        registers[c] = registers[a] + registers[b]
    end

    def addi a, b, c
        registers[c] = registers[a] + b
    end

    def mulr a, b, c
        registers[c] = registers[a] * registers[b]
    end

    def muli a, b, c
        registers[c] = registers[a] * b
    end

    def banr a, b, c
        registers[c] = registers[a] & registers[b]
    end

    def bali a, b, c
        registers[c] = registers[a] & b
    end

    def borr a, b, c
        registers[c] = registers[a] | registers[b]
    end

    def bori a, b, c
        registers[c] = registers[a] | b
    end

    def setr a, b, c
        registers[c] = registers[a]
    end

    def seti a, b, c
        registers[c] = a
    end

    def gtir a, b, c
        registers[c] = a > registers[b] ? 1 : 0
    end

    def gtri a, b, c
        registers[c] = registers[a] > b ? 1 : 0
    end

    def gtrr a, b, c
        registers[c] = registers[a] > registers[b] ? 1 : 0
    end

    def eqir a, b, c
        registers[c] = a == registers[b] ? 1 : 0
    end

    def eqri a, b, c
        registers[c] = registers[a] == b ? 1 : 0
    end

    def eqrr a, b, c
        registers[c] = registers[a] == registers[b] ? 1 : 0
    end
end

def test_opcode f, h
    m = Machine.new h[:before].clone
    m.send f, *h[:params]
    m.registers == h[:after]
end

def count_possible_functions h
    FUNCTIONS
        .select{ |f| test_opcode f, h }
        .count
end

def narrow_ops arr
    possible = FUNCTIONS.clone
    for h in arr
        possible = possible.select{ |f| test_opcode f, h }
        break if possible.size == 1
    end
    possible
end

def map_narrowed_ops kvs
    result = {}
    while kvs.size > 0 do
        kvs = kvs.sort_by{ |k, v| k.size }

        fs, hashes = kvs.first

        result[hashes.first[:op]] = fs.first

        kvs = kvs[1..-1].map{ |k, v| [k.reject{|x| x == fs.first}, v]}
    end
    result
end

def simulate ops, prog
    ops = ops
        .group_by{ |h| h[:op] }
        .map{ |k, v| [narrow_ops(v), v] }
        .yield_self{ |a| map_narrowed_ops a }

    m = Machine.new [0,0,0,0]

    prog.each do |arr|
        m.send ops[arr.first], *arr[1..-1]
    end

    m.registers.first
end

PART1 = PARSED_OPS
    .map{ |h| count_possible_functions h }
    .count{ |n| n >= 3 }

PART2 = simulate PARSED_OPS, PROG

puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2
