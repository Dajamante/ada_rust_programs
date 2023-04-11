set -e 

gcc -O0 -c cstr.adb -gnat2022 -g
gcc -c get_c_string.c -o get_c_string.o
gnatbind cstr
gnatlink cstr get_c_string.o -pthread -g