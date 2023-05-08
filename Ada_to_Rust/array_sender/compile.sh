set -e

gcc -L/usr/lib/x86_64-linux-gnu/ -O0 -c -g main.adb -gnat2022
rustc +nightly --crate-type=staticlib -L/usr/lib/x86_64-linux-gnu/ -Z sanitizer=address array_manip.rs -g 
gnatbind main
gnatlink main -L/usr/lib/x86_64-linux-gnu/ -fsanitize=address -pthread -l:libarray_manip.a -g 