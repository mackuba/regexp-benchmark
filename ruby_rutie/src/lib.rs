#[macro_use]
extern crate rutie;

use rutie::{Class, Object, RString, VM, Boolean};
use regex::Regex;
use lazy_static::lazy_static;

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

class!(RubyRustBridge);

methods!(
    RubyRustBridge,
    _rtself,

    fn regex_matches(input: RString) -> Boolean {
        let ruby_string = input.
            map_err(|e| VM::raise_ex(e) ).
            unwrap();

        let string = &ruby_string.to_string();

        let matches = REGEXPS.iter().any(|r| r.find(&string).is_some());
        return Boolean::new(matches);
    }
);

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn Init_rutie_ruby() {
    Class::new("RubyRustBridge", None).define(|klass| {
        klass.def_self("regex_matches", regex_matches);
    });
}
