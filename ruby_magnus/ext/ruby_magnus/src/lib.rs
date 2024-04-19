use magnus::{function, method, prelude::*, Error, Ruby};
use regex::Regex;

#[magnus::wrap(class = "RegexMatcher")]
struct RegexMatcher {
    regexps: Vec<regex::Regex>,
}

impl RegexMatcher {
    fn new(patterns: Vec<String>) -> Self {
        let regexps = patterns
            .into_iter()
            .map(|s| Regex::new(&s).unwrap())
            .collect();

        Self { regexps }
    }

    fn matches(&self, input_string: String) -> bool {
        return self.regexps.iter().any(|r| r.find(&input_string).is_some());
    }
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    let class = ruby.define_class("RegexMatcher", ruby.class_object())?;
    class.define_singleton_method("new", function!(RegexMatcher::new, 1))?;
    class.define_method("matches", method!(RegexMatcher::matches, 1))?;
    Ok(())
}
