set -e

gcc -O0 -c -g main.adb -gnat2022
rustc --crate-type=staticlib array_manip.rs -g 
gnatbind main
gnatlink main -fsanitize=address -pthread -l:libarray_manip.a -g 