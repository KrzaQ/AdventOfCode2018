void main()
{
    import std.algorithm, std.array, std.conv, std.file, std.range, std.stdio;
    import std.string;

    immutable data = read("../data.txt")
        .to!(char[])
        .splitter
        .array;

    auto p1 = data
        .map!(s => s.array.sort.group)
        .filter!(a => a.count!(t => (t[1] == 2) || (t[1] == 3)) > 0)
        .map!(a => a.filter!(t => (t[1] == 2) || (t[1] == 3)).array)
        .array;

    auto part1 = p1.count!(a => a.count!(t => t[1] == 2) > 0) *
                 p1.count!(a => a.count!(t => t[1] == 3) > 0);

    import mir.combinatorics;

    auto compare = function string(string t, string u) {
        auto tmp = t
            .zip(u)
            .filter!(x => x[0] == x[1])
            .map!(x => x[0])
            .array
            .to!string;

        return tmp.length == t.length - 1 ? tmp : null;
    };

    auto part2 = data.combinations(2)
        .map!(x => compare(x[0], x[1]))
        .find!(x => x !is null)
        .front;

    "Part 1: %s".writefln(part1);
    "Part 2: %s".writefln(part2);
}

