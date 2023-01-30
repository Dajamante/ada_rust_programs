use gpr::Project;
use std::{path::Path, process::Command};

fn main() {
    let enum_hello = Project::load(Path::new("enum_hello/enum_hello.gpr")).unwrap();
    Command::new("gprbuild")
        .args(enum_hello.gprbuild_args().unwrap())
        .spawn()
        .unwrap()
        .wait()
        .expect("Not found enum_hello/");
    println!(
        "cargo:rustc-link-search={}",
        enum_hello.library_dir().unwrap().to_str().unwrap()
    );
    println!(
        "cargo:rustc-link-lib={}={}",
        enum_hello.library_kind().unwrap(),
        enum_hello.library_name().unwrap()
    );
}
