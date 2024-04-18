use lazy_static::lazy_static;
use magnus::{function, Error, Ruby};
use regex::Regex;

lazy_static! {
    static ref REGEXPS: Vec<regex::Regex> = vec![
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
}

fn rust_regex_matches(input_string: String) -> bool {
    return REGEXPS.iter().any(|r| r.find(&input_string).is_some());
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    ruby.define_global_function("rust_regex_matches", function!(rust_regex_matches, 1));
    Ok(())
}
