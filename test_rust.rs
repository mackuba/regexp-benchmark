use rayon::prelude::*;
use regex::Regex;
use std::env;
use std::fs;

fn main() {
    let text = fs::read_to_string("posts.txt").unwrap();

    let regexps = vec![
        Regex::new(r"(?i)linux").unwrap(),
        Regex::new(r"(?i)debian").unwrap(),
        Regex::new(r"(?i)ubuntu").unwrap(),
        Regex::new(r#"\bredhat\b"#).unwrap(),
        Regex::new(r"\bRHEL\b").unwrap(),
        Regex::new(r"\bSUSE\b").unwrap(),
        Regex::new(r"\bCentOS\b").unwrap(),
        Regex::new(r"(?i)\bopensuse\b").unwrap(),
        Regex::new(r"(?i)\bslackware\b").unwrap(),
        Regex::new(r"\bKDE\b").unwrap(),
        Regex::new(r"\bGTK\d?\b").unwrap(),
        Regex::new(r"#GNOME\b").unwrap(),
        Regex::new(r"\bGNOME\s?\d+").unwrap(),
        Regex::new(r"(?i)\bkde plasma\b").unwrap(),
        Regex::new(r"apt-get").unwrap(),
        Regex::new(r"(?i)\bflatpak\b").unwrap(),
        Regex::new(r"\b[Xx]org\b").unwrap(),
    ];

    let iterations: usize = env::args()
        .nth(1)
        .unwrap()
        .parse()
        .expect("Invalid number of iterations");

    let mut total_matches = 0;

    for _ in 0..iterations {
        total_matches = text
            .par_lines()
            .map(|line| regexps.iter().filter(|r| r.is_match(line)).count())
            .sum();
    }

    println!("Total matches: {total_matches}");
}
