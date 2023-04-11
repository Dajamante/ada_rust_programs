gcc -c main.adb
rustc --crate-type=lib --emit=obj swap.rs
gnatbind main
gnatlink main swap.o

