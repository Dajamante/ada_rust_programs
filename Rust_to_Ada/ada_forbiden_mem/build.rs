use std::{
    path::Path,
    process::{Command, Stdio},
};
fn main() {
    let project = gpr::Project::load(Path::new("overwriter/ada_overwriter.gpr")).unwrap();

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
}
