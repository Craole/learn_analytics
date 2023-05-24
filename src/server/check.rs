use std::process::{Command, Output};

use crate::config::ConfigVars;

pub fn status() -> Result<(i32, Output), Box<dyn std::error::Error>> {
    // Create a ConfigVars instance
    let config_vars = ConfigVars::new()?;

    // Execute the "pg_ctl status" command to check server status
    let cmd_output = Command::new("pg_ctl")
        .arg("status")
        .arg("-D")
        .arg(config_vars.pg_data.as_deref().unwrap()) // Accessing pg_data field from ConfigVars
        .output()?;

    Ok((cmd_output.status.code().unwrap_or(-1), cmd_output))
}

// /// Checks if the server is initialized by validating the PGDATA directory.
// /// If the path does not exist or 'postgresql.conf' missing, returns false.
// fn server_is_initialized(config: &Config) -> bool {
//     println!("Checking the data dir...");
//     let path = Path::new(&config.db_data);
//     let file = path.join("postgresql.conf");
//     file.exists()
// }
