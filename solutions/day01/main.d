#!/usr/bin/rdmd

void main()
{
    import std.algorithm, std.array, std.conv, std.file, std.range, std.stdio;

    immutable data = read("data.txt")
        .to!(char[])
        .splitter
        .map!(to!int)
        .array;

    auto part2 = delegate int() {
        import std.container.rbtree;
        auto cache = redBlackTree!int;
        int sum;
        foreach(n; data.cycle) {
            sum += n;
            if(sum in cache)
                return sum;
            cache.insert(sum);
        }
    };

    "Part 1: %s".writefln(data.sum);
    "Part 2: %s".writefln(part2());
}

