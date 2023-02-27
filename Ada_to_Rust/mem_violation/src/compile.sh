set -e 

gcc -O0 -c mem_violation.adb -gnat2022
rustc --crate-type=staticlib ../mylib/src/lib.rs -L/lib/x86_64-linux-gnu/ -lc -o mylib.a
gnatbind mem_violation
gnatlink mem_violation -pthread mylib.a