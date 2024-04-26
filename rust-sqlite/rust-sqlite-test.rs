use regex::Regex;
use sqlite::{Connection, State};

fn main() {
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

    // Connect to the SQLite database
    let conn =
        Connection::open("../../bluefeeds/db/blueskydev.sqlite3").expect("Failed to open database");

    // Initial time for the first query
    let mut last_time: Option<String> = None;

    // Counter for posts containing "linux"
    let mut count = 0;

    loop {
        let mut stmt = match last_time {
            Some(ref time) => {
                let mut stmt = conn
                    .prepare("SELECT * FROM posts WHERE time > ? ORDER BY time LIMIT 100000")
                    .expect("Failed to prepare query");
                stmt.bind((1, time.as_str()))
                    .expect("Failed to bind parameter");
                stmt
            }
            None => {
                let mut stmt = conn
                    .prepare("SELECT * FROM posts ORDER BY time LIMIT 100000")
                    .expect("Failed to prepare query");
                stmt
            }
        };

        let mut found = false;
        let mut rows = 0;

        while stmt.next().expect("Failed to fetch next row") == State::Row {
            found = true;
            rows += 1;

            // Extract the time and content columns
            let time: String = stmt.read("time").expect("Failed to get time column");
            let text: String = stmt.read("text").expect("Failed to get content column");

            if regexps.iter().any(|r| r.find(&text).is_some()) {
                count += 1;
            }

            // Update the last_time for the next query
            last_time = Some(time);
        }

        if found {
            // println!("Found {} rows", rows);
        } else {
            // println!("No more rows");
            break;
        }
    }

    println!("Total posts matching Linux regexps: {}", count);
}
