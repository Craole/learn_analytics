use std::process::Command;

pub fn stop_server() {
    Command::new("pg_ctl")
        .arg("stop")
        .output()
        .expect("Failed to stop PostgreSQL server");

    // Add your platform-specific code to kill all instances of the program here
}
