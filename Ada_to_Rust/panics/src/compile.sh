gcc -O0 -c panicking.adb -gnat2022
rustc --crate-type=staticlib ../mylib/src/lib.rs -L/lib/x86_64-linux-gnu/ -lc -o mylib.a
gnatbind panicking
gnatlink panicking -pthread mylib.a