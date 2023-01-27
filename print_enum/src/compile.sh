gcc -c main.adb -pthread 
rustc --crate-type=staticlib ../mylib/src/lib.rs -L/lib/x86_64-linux-gnu/ -llibc -o mylib.a
gnatbind main
gnatlink main -pthread mylib.a