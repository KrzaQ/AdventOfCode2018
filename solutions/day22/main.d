#!/usr/bin/rdmd

void main()
{
    import std.algorithm, std.array, std.conv, std.file, std.range, std.stdio;

    Map!(5355, 14, 796) m;
    //Map!(510, 10, 10) m;

    "Part 1: %s".writefln(m.part1);
    "Part 2: %s".writefln(m.part2);
}

auto part1(M)(ref M m)
{
    import std.algorithm, std.range;
    alias MC = M.Coords;
    return iota(M.X+1)
        .map!(x => iota(M.Y+1).map!(y => m.erosion_level(MC(x, y)) % 3).sum)
        .sum;
}

auto part2(M)(ref M m)
{
    import std.algorithm, std.container.binaryheap, std.range, std.typecons;
    import std.container.array, std.conv;

    alias TT = M.TerrainType;
    enum Tool { Neither, Torch, Gear }

    alias MC = M.Coords;
    alias C = Tuple!(int, "x", int, "y", Tool, "tool");

    int[C] known = [
        C(0, 0, Tool.Torch): 0
    ];


    alias CD = Tuple!(C, "c", int, "dist");

    auto get_neighbours = delegate Array!CD(CD cd) {
        Array!CD ret;
        ret.reserve(5);

        int[2][4] coords = [[-1, 0], [1, 0], [0, -1], [0, 1]];

        foreach(dc; coords) {
            auto ins = CD(
                C(cd.c.x + dc[0], cd.c.y + dc[1], cd.c.tool),
                cd.dist+1
            );
            
            if(ins.c.x < 0 || ins.c.x > M.X + 20)
                continue;

            if(ins.c.y < 0 || ins.c.y > M.Y + 20)
                continue;

            if(ins.c in known)
                continue;

            if(ins.c.tool.to!int == m.terrain_type(MC(ins.c.x, ins.c.y)).to!int)
                continue;

            ret.insertBack(ins);
        }

        auto tt = m.terrain_type(MC(cd.c.x, cd.c.y)).to!int;

        auto tool = 3 - tt - cd.c.tool.to!int;

        auto ins = cd;
        ins.c.tool = tool.to!Tool;
        ins.dist += 7;
        if(ins.c !in known)
            ret.insertBack(ins);
        return ret;
    };

    Array!CD buf = get_neighbours(CD(C(0, 0, Tool.Torch), 0));

    alias PQ = BinaryHeap!(Array!CD,"a.dist > b.dist");

    PQ pq;
    pq.acquire(buf);

    while(pq.length) {
        auto el = pq.front;
        pq.popFront;

        if(el.c in known)
            continue;
        known[el.c] = el.dist;

        if(el.c.x == M.X && el.c.y == M.Y && el.c.tool == Tool.Torch) {
            return el.dist;
        }

        foreach(n; get_neighbours(el)) {
            pq.insert(n);
        }
    }

    return 0;
}


struct Map(int PDepth,int PX,int PY)
{
    import std.typecons;

    alias Depth = PDepth;
    alias X = PX;
    alias Y = PY;

    enum TerrainType {
        Rocky, Wet, Narrow
    }

    alias Coords = Tuple!(int, "x", int, "y");

    int[Coords] geologic_index_cache;

    auto geologic_index(Coords c)
    {
        auto ptr = c in geologic_index_cache;
        
        if(ptr !is null)
            return *ptr;

        if(c == Coords(X, Y)) {
            return 0;
        } else if(c.y == 0) {
            return c.x * 16807;
        } else if(c.x == 0) {
            return c.y * 48271;
        } else {
            auto l = erosion_level(Coords(c.x-1, c.y)) *
                     erosion_level(Coords(c.x, c.y-1));
            geologic_index_cache[c] = l;
            return l;
        }
        return 0;
    }

    auto erosion_level(Coords c)
    {
        return (geologic_index(c) + Depth) % 20183;
    }

    TerrainType terrain_type(Coords c)
    {
        if(c.x == 0 && c.y == 0) return TerrainType.Rocky;
        return cast(TerrainType)(erosion_level(c) % 3);
    }

}

