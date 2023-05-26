pub fn pgupdate(module_path: &'static str, function_name: &'static str) {
    let function_path = format!("{}::{}", module_path, function_name);
    println!("Resetting the server via {}", function_path);
}

pub fn main() {
    let module_path = module_path!();
    let function_name = "pgupdate";
    pgupdate(module_path, function_name);
}
