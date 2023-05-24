use std::env;
use std::path::{Path, PathBuf};

pub fn main() {
    let project_root = get_project_root().expect("Failed to find project root");
    let bin_path = get_bin_directory(&project_root).expect("Failed to find bin directory");

    let current_path = env::var("PATH").unwrap_or_default();
    let updated_path = format!("{}:{}", bin_path.to_str().unwrap(), current_path);

    env::set_var("PATH", updated_path);

    println!("Bin directory added to PATH: {:?}", bin_path);
}

fn get_project_root() -> Option<PathBuf> {
    let current_dir = env::current_dir().ok()?;
    let manifest_path = current_dir.join("Cargo.toml");

    if manifest_path.exists() {
        Some(current_dir)
    } else {
        current_dir
            .parent()
            .and_then(|parent| get_project_root_recursive(parent))
    }
}

fn get_project_root_recursive(dir: &Path) -> Option<PathBuf> {
    if dir.join("Cargo.toml").exists() {
        Some(dir.to_owned())
    } else {
        dir.parent()
            .and_then(|parent| get_project_root_recursive(parent))
    }
}

fn get_bin_directory(project_root: &Path) -> Option<PathBuf> {
    let bin_path = project_root.join("bin");
    let src_bin_path = project_root.join("src").join("bin");

    if bin_path.is_dir() {
        Some(bin_path)
    } else if src_bin_path.is_dir() {
        Some(src_bin_path)
    } else {
        None
    }
}
