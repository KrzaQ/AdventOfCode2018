#!/usr/bin/rdmd

void main()
{
    import std.conv, std.stdio;

    Board b = {
        [3,7,1,0],
        [0, 1]
    };

    immutable input = 505961;

    "Part 1: %s".writefln(input.part1(b));
    "Part 2: %s".writefln(input.to!string.part2(b));
}

struct Board
{
    ubyte[] buf;
    size_t[2] elves;
}

string part1(size_t steps, Board b)
{
    import std.algorithm, std.conv;
    while(b.buf.length < steps + 10)
        b.do_step;

    return b.buf[$-10..$].map!(v => (v + '0').to!char).to!string;
}

size_t part2(string sought_str, Board b)
{
    import std.algorithm, std.conv, std.array;
    const sought = sought_str.map!(c => (c - '0').to!ubyte).array;

    b.buf.reserve(200_000_000);

    while(true) {
        const prev_size = b.buf.length;
        b.do_step;
        auto size_diff = b.buf.length - prev_size;
        for(size_t i = 0; i < size_diff; i++) {
            if(i + sought.length > b.buf.length)
                continue;
            auto rng = b.buf[$-i-sought.length..$-i];
            if(rng == sought)
                return b.buf.length - sought.length - i;
        }
    }
}

void do_step(ref Board b)
{
    import std.algorithm, std.conv, std.array;
    ubyte new_val = b.elves[].map!(e => b.buf[e]).sum.to!ubyte;

    if(new_val > 9)
        b.buf ~= new_val / 10;
    b.buf ~= new_val % 10;

    foreach(ref e; b.elves) {
        e = b.buf[e] + 1 + e;
        e %= b.buf.length;
    }
}
