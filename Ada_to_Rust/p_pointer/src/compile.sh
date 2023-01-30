gcc -O0 -c main.adb -pthread -gnat2022
rustc --crate-type=staticlib ../mylib/src/lib.rs -L/lib/x86_64-linux-gnu/ -lc -o mylib.a
gnatbind main
gnatlink main -pthread mylib.a