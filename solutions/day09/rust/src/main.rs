use std::collections::{LinkedList};
use std::io;

fn main() -> Result<(), io::Error>
{
    println!("Part 1: {}", solve(403, 71920).unwrap());
    println!("Part 2: {}", solve(403, 71920*100).unwrap());
    Ok(())
}



fn solve(players: u32, marbles: u64) -> Option<u64>
{
    let mut board = LinkedList::<u64>::new();

    board.push_front(0);

    let mut scores = Vec::<u64>::new();

    for _ in 0..players {
        scores.push(0);
    }

    fn rotate(board: &mut LinkedList<u64>, n: i32) {
        if n > 0 {
            for _ in 0..n {
                let x = board.pop_front();
                board.push_back(x.unwrap());
            }
        } else {
            for _ in 0..-n {
                let x = board.pop_back();
                board.push_front(x.unwrap());
            }
        }
    };

    for m in 1..=marbles {
        if m % 23 > 0 {
            rotate(&mut board, 1);
            board.push_front(m);
            rotate(&mut board, 1);
        } else {
            let player_idx = (m % players as u64) as usize;
            scores[player_idx] += m;
            rotate(&mut board, -8);
            scores[player_idx] += board.pop_front().unwrap();
            rotate(&mut board, 1);
        }
    }

    match scores.iter().max() {
        Some(s) => Some(*s),
        None => None
    }
}
