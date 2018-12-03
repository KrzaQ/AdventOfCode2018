use std::collections::{HashMap, HashSet};
use std::fmt;
use std::fs::File;
use std::io;
use std::io::BufReader;
use std::io::prelude::*;

extern crate regex;
use regex::Regex;

struct Entry
{
    idx: i32,
    x: i32,
    y: i32,
    width: i32,
    height: i32
}

impl fmt::Display for Entry {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Entry({}, {}, {}, {}, {})",
            self.idx, self.x, self.y, self.width, self.height)
    }
}

fn read_file(name: &str) -> Result<Vec<String>, io::Error>
{
    let file = File::open(name)?;
    let buf_reader = BufReader::new(file);
    return buf_reader.lines().collect();
}

fn main() -> Result<(), io::Error>
{
    let data = read_file("../data.txt")?;

    // why did I have to specify the type here?
    let data : Vec<Entry> = data.iter().filter_map(parse_entry).collect();

    let mut counts = HashMap::<(i32, i32), HashSet<i32>>::new();
    let mut overlaps = HashMap::<i32, bool>::new();

    for e in data.iter() {
        overlaps.entry(e.idx).or_insert(true);
        for x in e.x..(e.x+e.width) {
            for y in e.y..(e.y+e.height) {
                let count = counts.entry((x, y)).or_insert(HashSet::new());
                count.insert(e.idx);
                if count.len() > 1 {
                    for idx in count.iter() {
                        overlaps.insert(*idx, false);
                    }
                }
            }
        }
    }

    let part1 = counts.iter().filter(|c| c.1.len() > 1).count();
    let part2 = overlaps.iter().filter(|c| *c.1).nth(0).unwrap().0;

    println!("Part 1: {}", part1);
    println!("Part 2: {}", part2);
    return Ok(());
}

fn parse_entry(e: &String) -> Option<Entry>
{
    let re = Regex::new(r"\#(\d+) @ (\d+),(\d+): (\d+)x(\d+)").unwrap();

    let cap = re.captures(&e).unwrap();

    let ret = Entry {
        idx: cap[1].parse().unwrap(),
        x: cap[2].parse().unwrap(),
        y: cap[3].parse().unwrap(),
        width: cap[4].parse().unwrap(),
        height: cap[5].parse().unwrap()
    };

    Some(ret)
}
