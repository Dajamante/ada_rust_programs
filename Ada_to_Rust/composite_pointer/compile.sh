set -e 

gcc -O0 -c main.adb -gnat2022
rustc --crate-type=staticlib pointer.rs -g
gnatbind main
gnatlink main -pthread -l:libpointer.a -g
