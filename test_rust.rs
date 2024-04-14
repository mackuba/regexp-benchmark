use rayon::prelude::*;
use regex::Regex;
use std::env;
use std::error::Error;
use std::fs;

fn main() -> Result<(), Box<dyn Error>> {
    let text = fs::read_to_string("posts.txt")?;

    let regexps = vec![
        Regex::new(r"(?i)linux")?,
        Regex::new(r"(?i)debian")?,
        Regex::new(r"(?i)ubuntu")?,
        Regex::new(r#"\bredhat\b"#)?,
        Regex::new(r"\bRHEL\b")?,
        Regex::new(r"\bSUSE\b")?,
        Regex::new(r"\bCentOS\b")?,
        Regex::new(r"(?i)\bopensuse\b")?,
        Regex::new(r"(?i)\bslackware\b")?,
        Regex::new(r"\bKDE\b")?,
        Regex::new(r"\bGTK\d?\b")?,
        Regex::new(r"#GNOME\b")?,
        Regex::new(r"\bGNOME\s?\d+")?,
        Regex::new(r"(?i)\bkde plasma\b")?,
        Regex::new(r"apt-get")?,
        Regex::new(r"(?i)\bflatpak\b")?,
        Regex::new(r"\b[Xx]org\b")?,
    ];

    let iterations: usize = env::args().nth(1).unwrap_or("1".to_string()).parse()?;
    let mut total_matches = 0;

    for _ in 0..iterations {
        total_matches = text
            .par_lines()
            .map(|line| regexps.iter().filter(|r| r.is_match(line)).count())
            .sum();
    }

    println!("Total matches: {total_matches}");

    Ok(())
}
