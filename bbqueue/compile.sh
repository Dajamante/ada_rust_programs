set -e

gcc -O0 -c -g main.adb -gnat2022
gnatbind main
gnatlink main  