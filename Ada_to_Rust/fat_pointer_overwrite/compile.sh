set -e 

gcc -O0 -c ruststr.adb -gnat2022
rustc --crate-type=staticlib change.rs -g
gnatbind ruststr
gnatlink ruststr -pthread -l:libchange.a -g