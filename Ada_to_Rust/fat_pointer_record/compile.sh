set -e 

gcc -O0 -c -gnatRj record_access.adb -gnat2022
rustc --crate-type=staticlib change.rs -g
gnatbind record_access
gnatlink record_access -pthread -l:libchange.a -g