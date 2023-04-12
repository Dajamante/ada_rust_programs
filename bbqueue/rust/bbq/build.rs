use std::{
    path::Path,
    process::{Command, Stdio},
};
fn main() {
    let project = gpr::Project::load(Path::new("printer/printer.gpr")).unwrap();

    let output = Command::new("gprbuild")
        .args(project.gprbuild_args().unwrap())
        .stderr(Stdio::inherit())
        .output()
        .unwrap();

    if !output.status.success() {
        panic!();
    }

    println!(
        "cargo:rustc-link-search={}",
        project.library_dir().unwrap().to_str().unwrap()
    );

    println!(
        "cargo:rustc-link-lib={}={}",
        project.library_kind().unwrap(),
        project.library_name().unwrap()
    );

    for dir in project.source_dirs().unwrap() {
        println!("cargo:rerun-if-changed={}", dir.as_str());
    }

    // println!("cargo:rustc-link-search=native=/home/vscode/.config/alire/cache/dependencies/gnat_native_12.2.1_11f3b811/lib/gcc/x86_64-pc-linux-gnu/12.2.0/adalib");
    // println!("cargo:rustc-link-lib=gnat");
    // println!("cargo:rustc-link-lib=gnarl");
}
