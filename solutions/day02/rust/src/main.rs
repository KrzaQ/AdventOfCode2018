use std::collections::HashMap;
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

    let part1 = data.iter().map(checksum);
    let part1 = part1.clone().filter(|x| x.0).count() *
                part1.clone().filter(|x| x.1).count();


    let part2 = compute_part2(data.clone());

    let part2 = match part2 {
        Some(s) => s,
        None => "Not found".to_string()
    };

    println!("Part 1: {}", part1);
    println!("Part 2: {}", part2);
    return Ok(());
}

fn compute_part2(data: Vec<String>) -> Option<String>
{
    for l in data.clone().iter() {
        for r in data.iter() {
            match find_match(vec![l, r]) {
                Some(s) => return Some(s),
                None => ()
            }
        }
    }
    return None;
}

fn find_match(ar: Vec<&String>) -> Option<String>
{
    let mut ret = String::new();

    for t in ar[0].chars().zip(ar[1].chars()) {
        if t.0 == t.1 {
            ret.push(t.0);
        }
    }

    return match ret.len() == ar[0].len() - 1 {
        true => Some(ret),
        false => None
    };
}

fn checksum(id: &String) -> (bool, bool)
{
    let mut counts = HashMap::<char, i32>::new();

    for c in id.chars() {
        let ptr = counts.entry(c).or_insert(0);
        *ptr += 1;
    }

    let mut ret = (false, false);

    for kv in counts.iter() {
        if *kv.1 == 2 { ret.0 = true; }
        if *kv.1 == 3 { ret.1 = true; }
        if ret.0 && ret.1 { break; }
    }

    return ret;
}
