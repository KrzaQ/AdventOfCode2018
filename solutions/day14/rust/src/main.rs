use std::io;

#[derive(Debug, Clone)]
struct Board
{
    buf: Vec<u8>,
    elves: [usize; 2],
}

fn main() -> Result<(), io::Error>
{
    let board = Board{ buf: vec!(3, 7, 1, 0), elves: [0, 1] };
    let input = 505961;
    println!("Part 1: {}", part1(input, board.clone()));
    println!("Part 2: {}", part2(input.to_string(), board));
    Ok(())
}

fn part1(steps: usize, mut b: Board) -> String
{
    while b.buf.len() < steps + 10 {
        do_step(&mut b)
    }
    let len = b.buf.len();

    b.buf[len-10..len].iter()
        .map(|c| (c + 0x30) as char)
        .collect()
}

fn part2(sought_str: String, mut b: Board) -> usize
{
    let sought: Vec<u8> = sought_str
        .chars()
        .map(|c| c as u8 - 0x30)
        .collect();

    b.buf.reserve(200_000_000);

    loop {
        let prev_size = b.buf.len();
        do_step(&mut b);
        let new_size = b.buf.len();
        let size_diff = new_size - prev_size;
        for i in 0..size_diff {
            if i + sought.len() > new_size {
                break
            }

            let rng = &b.buf[new_size-i-sought.len()..new_size-i];
            if rng == &sought[..] {
                return new_size - sought.len() - i;
            }
        }
    }
}

fn do_step(b: &mut Board) -> ()
{
    let new_val : u8 = b.elves
        .iter()
        .map(|e| b.buf[*e])
        .sum();

    if new_val > 9 {
        b.buf.push(new_val / 10);
    }
    b.buf.push(new_val % 10);

    for e in b.elves.iter_mut() {
        let nv = b.buf[*e] as usize + 1 + *e;
        let nv = nv % b.buf.len();
        *e = nv;
    }
}
