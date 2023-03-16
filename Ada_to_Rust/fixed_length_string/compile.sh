set -e 

gcc -O0 -c main.adb -gnat2022
rustc --crate-type=staticlib flstring.rs -g
gnatbind main
gnatlink main -pthread -l:libflstring.a -g
