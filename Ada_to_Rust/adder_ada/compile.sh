set -e 

gcc -O0 -c main.adb -gnat2022
rustc --crate-type=staticlib add.rs -L/lib/x86_64-linux-gnu/ -lc -o mylib.a
gnatbind main
gnatlink main -pthread mylib.a