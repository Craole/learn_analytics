//! This is a regular crate doc comment, but it also contains a partial
//! Cargo manifest.  Note the use of a *fenced* code block, and the
//! `cargo` "language".
//!
//! ```cargo
//! [dependencies]
//! ```
use std::env;
use std::io::{self, Write};
use std::process::{exit, Command};

fn init_psql_data() {
    if !std::path::Path::new(&env::var("PGDATA").unwrap()).exists() {
        Command::new("pg_ctl")
            .arg("initdb")
            .output()
            .expect("Failed to initialize PostgreSQL data environment");
    }
}

fn start_psql_server() {
    if !is_psql_server_running() {
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
}

fn stop_psql_server() {
    Command::new("pg_ctl")
        .arg("--log")
        .arg(env::var("PGLOG").unwrap_or_default())
        .arg("--mode")
        .arg("smart")
        .arg("stop")
        .output()
        .expect("Failed to stop PostgreSQL server");
}

fn reset_psql_server() {
    stop_psql_server();
    Command::new("killall")
        .arg("postgres")
        .output()
        .expect("Failed to kill PostgreSQL processes");
    let pgdata = env::var("PGDATA").unwrap();
    let pglog = env::var("PGLOG").unwrap();
    std::fs::remove_dir_all(&pgdata).expect("Failed to remove PGDATA directory");
    std::fs::remove_file(&pglog).expect("Failed to remove PGLOG file");
}

fn load_psql_db(db: &str) {
    Command::new("psql")
        .arg("--dbname")
        .arg(db)
        .output()
        .expect("Failed to load database");
}

fn print_usage() {
    println!("Usage: {} [option]", env::args().next().unwrap());
    println!("Options:");
    println!("  -i, --init    />   Initialize the PostgreSQL data environment");
    println!("  -s, --start   />   Start the PostgreSQL server");
    println!("  -x, --stop    />   Stop the PostgreSQL server");
    println!("  -r, --reset   />   Stop the PostgreSQL server and remove data and log");
    println!("  -l, --db      />   Load the database");
    println!("  -h, --help    />   Print this usage information");
}

fn prompt_start_stop() {
    println!("Please select whether to start or stop the PostgreSQL server.");
    println!("  1. Start the PostgreSQL server");
    println!("  2. Stop the PostgreSQL server");

    let mut choice = String::new();
    io::stdin()
        .read_line(&mut choice)
        .expect("Failed to read user input");

    match choice.trim() {
        "1" => start_psql_server(),
        "2" => stop_psql_server(),
        _ => println!("Invalid choice. Please enter 1 or 2."),
    }
}

fn is_psql_server_running() -> bool {
    Command::new("pg_isready")
        .arg("--quiet")
        .status()
        .map(|status| status.success())
        .unwrap_or(false)
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() <= 1 {
        print_usage();

        exit(0);
    }

    let mut init = false;
    let mut start = false;
    let mut stop = false;
    let mut reset = false;
    let mut load = false;
    let mut db = "postgres".to_string();

    let mut iter = args.iter().skip(1);
    while let Some(arg) = iter.next() {
        match arg.as_str() {
            "-i" | "--init" => init = true,
            "-s" | "--start" => start = true,
            "-x" | "--stop" => stop = true,
            "-r" | "--reset" => reset = true,
            "-l" | "--db" => {
                load = true;
                if let Some(db_name) = iter.next() {
                    db = db_name.clone();
                }
            }
            "-h" | "--help" => {
                print_usage();
                exit(0);
            }
            _ => {
                println!("Invalid option: {}", arg);
                print_usage();
                exit(1);
            }
        }
    }

    if start && stop {
        prompt_start_stop();
    } else if reset {
        reset_psql_server();
        init_psql_data();
        start_psql_server();
    } else if init && start {
        init_psql_data();
        start_psql_server();
    } else if init {
        init_psql_data();
    } else if start {
        start_psql_server();
    } else if load {
        load_psql_db(&db);
    }
}