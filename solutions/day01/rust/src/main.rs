use std::fs::File;
use std::io;
use std::io::prelude::*;
use std::collections::HashSet;

fn read_file(name: &str) -> Result<String, io::Error>
{
    let mut file = File::open(name)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;

    return Ok(contents);
}

fn main() -> Result<(), io::Error>
{
    let data = read_file("../data.txt")?;
    let data = data.split('\n');
    let data = data.filter_map(|l| l.parse::<i32>().ok());
    let data = data.collect::<Vec<i32>>();

    let part1 = data.iter().fold(0, |t, e| t + e);

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
    println!("Part 1: {}", part2);
    return Ok(());
}
