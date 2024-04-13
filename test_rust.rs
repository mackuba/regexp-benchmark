use regex::Regex;
use std::env;
use std::fs;

fn main() {
    let text = match fs::read_to_string("posts.txt") {
        Ok(content) => content,
        Err(_) => {
            eprintln!("Error reading text file.");
            return;
        }
    };

    let lines: Vec<&str> = text.lines().collect();

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

    let args: Vec<String> = env::args().collect();
    let iterations: usize = args[1].parse().expect("Invalid number of iterations");

    // let iterations: usize = std::env::args().nth(1)
    //         .expect("Please provide the number of iterations as the first argument.")
    //         .parse()
    //         .expect("Failed to parse number of iterations");

    let mut total_matches = 0;

    for _ in 0..iterations {
        for r in &regexps {
            for line in &lines {
                match r.find(line) {
                  Some(_value) => {
                    total_matches += 1;                    
                  },
                  None => {
                  }
                }
            }
        }
    }

    println!("Total matches: {}", total_matches / iterations);
}
