use std::collections::HashSet;
use std::fs::File;
use std::io;
use std::io::BufReader;
use std::io::prelude::*;

fn read_file(name: &str) -> Result<Vec<String>, io::Error>
{
    let file = File::open(name)?;
    let buf_reader = BufReader::new(file);
    return buf_reader.lines().collect();
}

fn main() -> Result<(), io::Error>
{
    let data = read_file("../data.txt")?;
    let data = data.join("");

    let part1 = solve(&data, None).unwrap();

    let chars = data.chars()
        .map(|c| c.to_ascii_uppercase())
        .collect::<HashSet<_>>();

    let part2 = chars
        .iter()
        .map(|n| solve(&data, Some(*n)).unwrap())
        .min()
        .unwrap();

    println!("Part 1: {}", part1);
    println!("Part 2: {}", part2);
    return Ok(());
}

fn solve(input: &String, without: Option<char>) -> Option<u64>
{
    let mut stack = Vec::<char>::new();

    fn chars_match(a: char, b: char) -> bool {
        a != b && a.to_ascii_uppercase() == b.to_ascii_uppercase()
    }

    let input = match without {
        Some(w) => input
            .chars()
            .filter(|c| c.to_ascii_uppercase() != w.to_ascii_uppercase())
            .collect::<Vec<char>>(),
        None => input
            .chars()
            .collect::<Vec<char>>()
    };

    for c in input {
        if stack.len() > 0 && chars_match(*stack.last().unwrap(), c) {
            stack.pop();
        } else {
            stack.push(c);
        }
    }

    Some(stack.len() as u64)
}
