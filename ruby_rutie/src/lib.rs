#[macro_use]
extern crate rutie;

use rutie::{Boolean, Class, Object};

class!(RubyRustBridge);

methods!(
    RubyRustBridge,
    _rtself,
    fn hello() -> Boolean {
        return Boolean::new(true);
    }
);

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn Init_rutie_ruby() {
    Class::new("RubyRustBridge", None).define(|klass| {
        klass.def_self("hello", hello);
    });
}
