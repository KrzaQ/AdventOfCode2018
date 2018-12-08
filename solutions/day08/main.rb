#!/usr/bin/ruby

DATA = File
    .read('data.txt')
    .split
    .map(&:to_i)


def parse_node arr
    num_children = arr[0]
    num_metadata = arr[1]

    children = []
    metadata = []

    cur_offset = 2

    for n in (0...num_children)
        c = parse_node arr[cur_offset..-1]
        children << c
        cur_offset += c[:size]
    end

    for n in (0...num_metadata)
        metadata << arr[cur_offset]
        cur_offset += 1
    end

    {
        children: children,
        metadata: metadata,
        size: cur_offset,
    }
end

def sum_metadata root
    root[:metadata].sum + root[:children].map{ |c| sum_metadata c }.sum
end

PARSED = parse_node DATA


def sum_nodes root
    return root[:metadata].sum if root[:children].size == 0

    root[:metadata].map do |n|
        n > root[:children].size ? 0 : sum_nodes(root[:children][n-1])
    end.sum
end

PART1 = sum_metadata PARSED
PART2 = sum_nodes PARSED


puts 'Part 1: %s' % PART1
puts 'Part 2: %s' % PART2

