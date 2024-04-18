use std::io::{self, BufRead};
use regex::Regex;

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

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

    loop {
        let first_line = match lines.next() {
            Some(Ok(line)) => line,
            _ => break, // Exit loop on EOF or error
        };

        let is_blue = match first_line.trim() {
            "0" => true,
            "1" => false,
            _ => {
                eprintln!("Error: First line must be '0' or '1'");
                continue;
            }
        };

        let second_line = match lines.next() {
            Some(Ok(line)) => line,
            _ => {
                eprintln!("Error: Second line is missing");
                break;
            }
        };

        let contains_color = if is_blue {
            regexps.iter().any(|r| r.find(&second_line).is_some())
        } else {
            second_line.contains("green")
        };

        println!("{}", if contains_color { "1" } else { "0" });
    }
}
