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
    let data = read_file("../data.txt")?
        .iter()
        .filter_map(|l| l.parse::<i32>().ok())
        .collect::<Vec<i32>>();

    let part1 = data.iter().sum::<i32>();

    let mut i = 0;
    let mut cache :HashSet<i32> = HashSet::new();
    let mut part2 = 0;
    loop {
        part2 += data[i % data.len()];
        if cache.contains(&part2) {
            break;
        }
        cache.insert(part2);
        i += 1;
    }

    println!("Part 1: {}", part1);
    println!("Part 2: {}", part2);
    return Ok(());
}
