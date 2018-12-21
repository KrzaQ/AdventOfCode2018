#!/usr/bin/ruby

require 'erb'
require 'set'

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
    attr_accessor :executed

    def initialize regs, code, ip
        self.registers = regs
        self.instructions = code
        self.ip_register = ip
        self.executed = 0
    end

    def exec_one_instruction
        instruction = registers[ip_register]
        # p [instruction, registers, instructions[instruction]]
        self.send *instructions[instruction]
        registers[ip_register] += 1
        self.executed += 1
    end

    def exec
        while not is_finished
            exec_one_instruction
        end
    end

    def is_finished
        registers[ip_register] >= instructions.size
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

    def bani a, b, c
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

t = ERB.new File.read('machine.cpp.erb'), nil, '%<>'

File.write 'machine.cpp', t.result

system 'clang++ machine.cpp -std=c++17 -O3 -o machine'
system './machine'
