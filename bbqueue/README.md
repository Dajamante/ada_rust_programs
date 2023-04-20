# Run the BBqueue

```
cd printer/
LIBRARY_TYPE=relocatable alr build
eval $(alr -q printenv --unix)
cd ..
LD_LIBRARY_PATH=printer/lib cargo run
```