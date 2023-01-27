gcc -c main.adb
rustc --crate-type=lib --emit=obj swap_enum.rs 
gnatbind main
gnatlink main swap_enum.o