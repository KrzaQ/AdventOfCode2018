#!/usr/bin/ruby

require 'erb'
require 'json'
require 'optparse'
require 'ostruct'
require 'time'

OPTS = lambda do
    opts = {
        input: 'gen/data.json',
        template: 'gen/template.erb',
        output: 'README.md',
    }

    OptionParser.new do |o|
        o.on('--input X'){ |x| opts[:input] = x }
        o.on('--output X'){ |x| opts[:output] = x }
        o.on('--template X'){ |x| opts[:template] = x }
    end.parse!

    OpenStruct.new opts
end.call

DATA = JSON.parse(File.read(OPTS.input), symbolize_names: true)

def cze
    return 42
end

nocze = 15

t = ERB.new File.read(OPTS.template), nil, '%<>'

File.write OPTS.output, t.result
