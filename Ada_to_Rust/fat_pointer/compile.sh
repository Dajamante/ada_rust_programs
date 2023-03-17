set -e 

gcc -O0 -c cstr.adb -gnat2022
rustc --crate-type=staticlib change.rs -g
gnatbind cstr
gnatlink cstr -pthread -l:libchange.a -g