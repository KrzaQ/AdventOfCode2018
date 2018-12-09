#!/usr/bin/rdmd

void main()
{
    import std.stdio;

    "Part 1: %s".writefln(solve(403, 71920));
    "Part 2: %s".writefln(solve(403, 71920*100));
}

ulong solve(int players, int marbles)
{
    import std.container.dlist, std.algorithm;
    auto board = new DList!ulong();
    board.insertBack(0);

    ulong[] scores = new ulong[players];

    auto rotate = delegate void(int n) {
        if(n > 0) {
            for(int i = 0; i < n; ++i) {
                board.insertBack(board.front());
                board.removeFront();
            }
        } else {
            for(int i = 0; i < -n; ++i) {
                board.insertFront(board.back());
                board.removeBack();
            }
        }
    };

    for(int i = 1; i <= marbles; i++) {
        if(i % 23) {
            rotate(1);
            board.insertFront(i);
            rotate(1);
        } else {
            rotate(-8);
            scores[i % players] += i + board.front();
            board.removeFront();
            rotate(1);
        }
    }

    return scores.maxElement;
}
