use magnus::{method, prelude::*, Error, Ruby};

#[magnus::wrap(class = "RegexMatcher")]
struct RegexMatcher {
}

impl RegexMatcher {
    fn hello(&self) -> bool {
        return true;
    }
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    let class = ruby.define_class("RegexMatcher", ruby.class_object())?;
    class.define_method("hello", method!(RegexMatcher::hello, 0))?;
    Ok(())
}
