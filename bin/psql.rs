//! This is a regular crate doc comment, but it also contains a partial
//! Cargo manifest.  Note the use of a *fenced* code block, and the
//! `cargo` "language".
//!
//! ```cargo
//! [dependencies]
//! sysinfo = "0.28.4"
//! ```
use std::env;
use std::io;
use std::process::{self, Command};
use sysinfo::{ProcessExt, System};

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() <= 1 {
        print_usage();
        process::exit(0);
    }

    let mut start = false;
    let mut stop = false;
    let mut reset = false;
    let mut load = false;
    let mut check = false;
    let mut db = "postgres".to_string();

    let mut iter = args.iter().skip(1);
    while let Some(arg) = iter.next() {
        match arg.as_str() {
            "-s" | "--start" => start = true,
            "-x" | "--stop" => stop = true,
            "-r" | "--reset" => reset = true,
            "-c" | "--status" => check = true,
            "-l" | "--db" => {
                load = true;
                if let Some(db_name) = iter.next() {
                    db = db_name.clone();
                }
            }
            "-h" | "--help" => {
                print_usage();
                process::exit(0);
            }
            _ => {
                println!("Invalid option: {}", arg);
                print_usage();
                process::exit(1);
            }
        }
    }

    match (start, stop, reset, load, check) {
        (true, true, _, _, _) => prompt_start_stop(),
        (_, _, true, _, _) => {
            reset_server();
            start_server();
        }
        (true, _, _, _, _) => start_server(),
        (_, _, _, true, _) => load_db(&db),
        (_, _, _, _, true) => check_server(),
        _ => {} // No matching options
    }
}

fn check_server() {
    let output = Command::new("pg_ctl")
        .arg("status")
        .output()
        .expect("Failed to execute pg_ctl status");

    if output.status.success() {
        println!("PostgreSQL server is running");
    } else {
        println!("PostgreSQL server is not running");
    }
}

fn start_server() {
    match (
        check_server_status(),
        std::path::Path::new(&env::var("PGDATA").unwrap()).exists(),
    ) {
        (false, false) => {
            let workspace = env::var("workspace").unwrap_or_default();
            Command::new("pg_ctl")
                .arg("--log")
                .arg(env::var("PGLOG").unwrap_or_default())
                .arg("--options")
                .arg(format!("--unix_socket_directories='{}'", workspace))
                .arg("start")
                .output()
                .expect("Failed to start PostgreSQL server");
        }
        _ => {} // Server is already running or PGDATA folder exists, do nothing
    }
}

fn reset_server() {
    let pgdata = env::var("PGDATA").unwrap();
    let pglog = env::var("PGLOG").unwrap();
    std::fs::remove_dir_all(&pgdata).expect("Failed to remove PGDATA directory");
    std::fs::remove_file(&pglog).expect("Failed to remove PGLOG file");
}

fn stop_server() {
    Command::new("pg_ctl")
        .arg("stop")
        .output()
        .expect("Failed to stop PostgreSQL server");

    kill_all_processes("postgres");
}

fn load_db(db: &str) {
    if !check_server_status() {
        start_server();
    }

    Command::new("psql")
        .arg("--dbname")
        .arg(db)
        .output()
        .expect("Failed to load database");
}

fn prompt_start_stop() {
    println!("Please select whether to start or stop the server.");
    println!("  1. Start the server");
    println!("  2. Stop the server");

    let mut choice = String::new();
    io::stdin()
        .read_line(&mut choice)
        .expect("Failed to read user input");

    match choice.trim() {
        "1" => start_server(),
        "2" => stop_server(),
        _ => println!("Invalid choice. Please enter 1 or 2."),
    }
}

fn kill_all_processes(program: &str) {
    let mut system = System::new_all();
    system.refresh_processes();

    let processes = system.get_process_by_name(program);
    for process in processes {
        Command::new("kill")
            .arg(process.pid().to_string())
            .output()
            .expect("Failed to kill process");
    }
}

fn print_usage() {
    println!("Usage: {} [option]", env::args().next().unwrap());
    println!("Options:");
    println!("  -c, --status  />   Check the status of the server");
    println!("  -s, --start   />   Start the server");
    println!("  -x, --stop    />   Stop the server");
    println!("  -r, --reset   />   Stop the server and remove data and log");
    println!("  -l, --db      />   Load the database");
    println!("  -h, --help    />   Print this usage information");
}
