#!/usr/bin/rdmd

void main()
{
    import std.algorithm, std.array, std.conv, std.file, std.range, std.stdio;
    
    const data = read("data.txt")
        .to!(char[])
        .splitter("\n")
        .map!parse_line
        .array;

    writefln("Part 1: %s", data.make_graph.solve.text);
    writefln("Part 2: %s", data.make_graph.solve(5, 60).seconds);
}

auto parse_line(R)(R r)
{
    import std.regex;
    immutable rx = ctRegex!"Step (.) must be finished before step (.) can beg";
    auto c = r.match(rx).captures;
    static struct ParseResult{ R dependant, dependee; }
    return ParseResult(c[2], c[1]);
}

auto make_graph(R)(R r)
{
    import std.container.rbtree, std.algorithm, std.conv, std.utf, std.array;
    import std.stdio, std.string;
    alias set = RedBlackTree!string;
    set[string] g;

    foreach(c; r.map!(pr => pr.dependee ~ pr.dependant)
                .joiner
                .to!string
                .representation
                .dup
                .sort
                .uniq
                .map!(to!char)
                .map!(to!string)) {
        g[c] = new set;
    }


    foreach(a; r) {
        g[a.dependant].insert(a.dependee.to!string);
    }

    return g;
}

auto solve(G)(G g, int worker_count = 1, int base_time = 0)
in(worker_count > 0)
{
    import std.container.rbtree, std.algorithm, std.array, std.string;
    alias set = RedBlackTree!string;
    auto get_ready = delegate string[]() {
        auto r = g
            .byKeyValue
            .filter!(p => p.value.length == 0)
            .map!(p => p.key)
            .array;
        foreach(s; r)
            g.remove(s);
        return r;
    };

    set todo = new set;

    struct Worker
    {
        string what;
        int seconds;
    }

    Worker*[] workers = new Worker*[worker_count];

    struct SolveResult
    {
        string text;
        int seconds;
    }
    SolveResult sr;

    while(true) {
        todo.insert(get_ready());

        sr.seconds++;

        foreach(i, ref w; workers) {
            if(!w && todo.length) {
                auto f = todo.front;
                todo.removeFront;
                auto secs = f.representation[0] - cast(int)'A' + 1 + base_time;
                w = new Worker(f, secs);
            }

            if(w) {
                w.seconds--;
                if(!w.seconds) {
                    sr.text ~= w.what;
                    foreach(ref p; g.byKeyValue) {
                        p.value.removeKey(w.what);
                    }
                    workers[i] = null;
                }
            }
        }

        if(todo.empty && workers.all!(w => w is null) && g.empty)
            break;
    }

    return sr;
}
