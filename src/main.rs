#![no_std]
#![no_main]
#![feature(custom_test_frameworks)]
#![test_runner(osdev::test_runner)]
#![reexport_test_harness_main = "test_main"]

use core::panic::PanicInfo;
use osdev::println;

#[no_mangle]
pub extern "C" fn _start() -> ! {
    println!("Hello World{}", "!");

    osdev::init();

    fn stack_overflow() {
        stack_overflow(); // for each recursion, the return address is pushed
    }
    // trigger a stack overflow
    stack_overflow();

    #[cfg(test)]
    test_main();

    loop {}
}

/// This function is called on panic.
#[cfg(not(test))]
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    println!("{}", info);
    loop {}
}

#[cfg(test)]
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    osdev::test_panic_handler(info)
}
