use clap::{App, Arg, ArgMatches};
use std::env;
use std::fs;
use std::path::PathBuf;
use tokio::fs as async_fs;

pub fn build_subcommand() -> App<'static, 'static> {
    App::new("reset").about("Resets the server")
    // Add any specific arguments or options for this subcommand
    // using the `.arg()` method
}

pub async fn reset(matches: &ArgMatches) {
    // Load environment variables from .env file
    dotenv::dotenv().ok();

    // Retrieve PGDATA and PGLOG from environment variables
    let pgdata = env::var("PGDATA").expect("PGDATA environment variable not set");
    let pglog = env::var("PGLOG").expect("PGLOG environment variable not set");

    // Delete PGDATA folder
    let pgdata_path = PathBuf::from(&pgdata);
    if pgdata_path.exists() {
        async_fs::remove_dir_all(&pgdata_path)
            .await
            .expect("Failed to delete PGDATA folder");
        println!("Deleted PGDATA folder");
    } else {
        println!("PGDATA folder does not exist");
    }

    // Delete PGLOG file
    let pglog_path = PathBuf::from(&pglog);
    if pglog_path.exists() {
        async_fs::remove_file(&pglog_path)
            .await
            .expect("Failed to delete PGLOG file");
        println!("Deleted PGLOG file");
    } else {
        println!("PGLOG file does not exist");
    }
}
