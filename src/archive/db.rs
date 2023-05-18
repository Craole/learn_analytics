use crate::server::start::start_server;
use std::process::Command;

pub fn load_db(db: &str) {
    // Start the server if it's not already running
    if !start_server() {
        println!("Starting PostgreSQL server...");
        start_server();
    }

    Command::new("psql")
        .arg("--dbname")
        .arg(db)
        .output()
        .expect("Failed to load database");
}
