#!/usr/bin/ruby

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

FUNCTIONS = [
    :addr, :addi,
    :mulr, :muli,
    :banr, :bali,
    :borr, :bori,
    :setr, :seti,
    :gtir, :gtri, :gtrr,
    :eqir, :eqri, :eqrr,
]

class Machine
    attr_accessor :registers
    attr_accessor :instructions
    attr_accessor :ip_register

    def initialize regs, code, ip
        self.registers = regs
        self.instructions = code
        self.ip_register = ip
    end

    def exec_one_instruction
        instruction = registers[ip_register]
        self.send *instructions[instruction]
        registers[ip_register] += 1
    end

    def exec
        while registers[ip_register] < instructions.size
            exec_one_instruction
        end
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


def solve_for arr
    init_value = arr

    m = Machine.new init_value, INSTRUCTIONS, IP_REGISTER

    m.exec

    m.registers.first
end

PART1 = solve_for [0, 0, 0, 0, 0, 0]

puts 'Part 1: %s' % PART1

# PART2 = solve_for [1, 0, 0, 0, 0, 0]
# puts 'Part 2: %s' % PART2
