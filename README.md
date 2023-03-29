# ada_rust_programs

Ada/Spark and Rust programs as support of [master thesis](https://github.com/Dajamante/thesis_rust_spark_joy).


## Ada book

Those are snippets coming from [LearnAda](https://learn.adacore.com/).
Mostly to learn SPARK and Ada and not part of the thesis work.

## Ada to Rust

In Ada to Rust programs, all files are in the same source. 
A compilation script is under this form:

```
//makes the build fail if an error happens
set -e 

// -gnatRj shows the size of the object and -gnat2022 convention authorize `Img.
gcc -O0 -c -gnatRj record_access.adb -gnat2022 
rustc --crate-type=staticlib change.rs -g
gnatbind record_access
//pthread prevents a bunch of errors
gnatlink record_access -pthread -l:libchange.a -g 
```

To use ![gnatprove](gnatprove.png):
Terminal > Run Task > Prove

If GNATprove is not found despite being on the path, this seems to be working:
```
$ export PATH="/workspaces/ada_rust_programs/gnatprove-x86_64-linux-12.1.0-1/bin/:$PATH"
$ gnatprove -P  panicking.gpr 
```

It is not always usable as GNATprove will check for SPARK errors within SPARK code but can show errors:

In `Rust_to_Ada/ada_adder/adder`:
```
$ gnatprove -P  adder.gpr 
Phase 1 of 2: generation of Global contracts ...
Phase 2 of 2: flow analysis and proof ...

adder.ads:10:55: medium: pointer dereference check might fail
   10 |     Annotate => (GNATprove, Terminating), Post => (X.all'Old = X.all + 1),
      |                                                    ~~^~~
```
### Usual troubleshooting

`error: failed to run custom build command for openssl-sys v0.9.82`

Requires:
```
sudo apt-get update
sudo apt install pkg-config
sudo apt-get install libudev-dev
```

Valgrind should be installed and can be run:

`valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes ./record_access`

## Rust to Ada

Rust to Ada uses [`gpr`](https://github.com/jklmnn/gpr-rust).
The SPARK library is in an inner directory.

```
├── build.rs
├── Cargo.lock
├── Cargo.toml
├── overwriter
│   ├── ada_overwriter.gpr
│   ├── alire.toml
│   ├── config
│   ├── lib
│   ├── obj
│   ├── share
│   └── src
├── src
│   └── main.rs
```
The `lib` must be on LD_PATH_LIBRARY.

### Inspect and graphs

First a `cargo new project-name` is done, and inside we have `alr init --lib lib-name`.

`gpr` needs to be imported in `[build-dependencies]`. 

### MIR

`LD_LIBRARY_PATH=adder/lib cargo rustc -- -Z unpretty=hir,typed > output.mir`

### Graph with .dot files

To do graph files that can be visualised in [Graphviz](https://dreampuf.github.io/GraphvizOnline).

`LD_LIBRARY_PATH=adder/lib cargo rustc -- -Z unpretty=mir-cfg > output-graph.dot`

[Source](https://users.rust-lang.org/t/how-to-inspect-hir-or-mir/37135/3)


### Valgrind 

Can be run as usual:

`valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes target/debug/ada_string_overwriter`

### Assembler output:

`LD_LIBRARY_PATH=adder/lib cargo rustc -- --emit asm --emit asm-verbose`

### Objdump with its header files:

`objdump -h target/debug/ada_string_overwriter`

### Usual troubleshooting:
  

`thread 'main' panicked at 'called Result::unwrap() on an Err value: Gpr { code: CallError, name: "GPR2.PROJECT_ERROR", message: "/workspaces/ada_rust_programs/Rust_to_Ada/ada_adder/ada_adder/adder.gpr: fatal error, cannot load the project tree" }', build.rs:6:72`

^^ This means the name is wrong or the path is wrong. The `LD_LIBRARY_PATH` is not compulsory and can be set in `.vscode/` config folder:

```json
"version": "0.2.0",
"configurations": [
    {
        "type": "lldb",
        "request": "launch",
        "name": "Debug",
        "program": "${workspaceFolder}/Rust_to_Ada/ada_string_overwriter/target/debug/ada_string_overwriter",
        "env": {
            "LD_LIBRARY_PATH": "${workspaceRoot}/Rust_to_Ada/ada_string_overwriter/overwriter/lib"
        },
        "args": [],
        "cwd": "${workspaceFolder}"
    }
]
```

Compiler complains about `-fPIE` --> Try  a standalone library instead, replace contents of gpr file.

`.gpr` file:

```
project Ada_Overwriter
is

   for Source_Dirs use ("src");
   for Object_Dir use "obj";
   for Create_Missing_Dirs use "True";
   for Library_Name use "overwriter";
   for Library_Kind use "dynamic";
   for Library_Standalone use "encapsulated";
   for Library_Interface use ("overwriter");
   for Library_Dir use "lib";

end Ada_Overwriter;
```
Makind standalone libraries seems to solve it everytime.

If it is not building, try `gprbuild` inside the Ada lib folder, then `eval $(alr -q printenv --unix)` before running with cargo. 

This exports the environment that alire is using to build the project to the shell. Mainly the path to the compiler and dependency projects. So `gprbuild` will find the correct compiler and dependencies.

Alr looks at the alire.toml that specifies the required dependencies. It downloads them and sets the correct GPR_PROJECT_PATH to them. So when you use one of these dependencies in your gpr file it will be found by gprbuild (which is called by alr). If you with a package that is not specified in the alire.toml you will also get an error.

ldd checks if the dependencies of a library are met (did not use this one that much):

`ldd /workspaces/ada_rust_programs/Rust_to_Ada/ada_string_overwriter/overwriter/lib/liboverwriter.so`

Likely if it is missing, the config was already added to VSCode. 
So there is no need to provide the path. 
```vscode
{
	// Use IntelliSense to learn about possible attributes.
	// Hover to view descriptions of existing attributes.
	// For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
	"version": "0.2.0",
	"configurations": [
    	{
        	"type": "lldb",
        	"request": "launch",
        	"name": "Debug",
        	"program": "${workspaceFolder}/Rust_to_Ada/ada_string_overwriter/target/debug/ada_string_overwriter",
        	"env": {
            	"LD_LIBRARY_PATH": "${workspaceRoot}/Rust_to_Ada/ada_string_overwriter/overwriter/lib"
        	},
        	"args": [],
        	"cwd": "${workspaceFolder}"
    	}
	]
}
```

Or maybe the lib is built under another name, in that case a cleaning of the obj file.

Clean the build output directories by removing the lib and obj directories:

```
rm -rf lib obj
gprbuild ada_overwriter.gpr
find . -name "lib*.so"
// link if it is another name!
ln -s libada_overwriter.so liboverwriter.so
```