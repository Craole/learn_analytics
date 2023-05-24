use crate::config::ConfigVars;
use std::process::{Command, Output};

/// Retrieves the status of the server by executing the "pg_ctl status" command.
///
/// Returns:
/// - `Ok(Output)`: The output of the command if successful.
/// - `Err(Box<dyn std::error::Error>)`: An error if the command execution fails.
pub fn status() -> Result<Output, Box<dyn std::error::Error>> {
    // Create a ConfigVars instance
    let config_vars = ConfigVars::new()?; // Retrieve the configuration variables

    // Execute the "pg_ctl status" command to check server status
    let cmd_output = Command::new("pg_ctl")
        .arg("status")
        .arg("-D")
        .arg(config_vars.pg_data.as_deref().unwrap()) // Accessing pg_data field from ConfigVars
        .output()?; // Execute the command and capture the output

    Ok(cmd_output) // Return the command output
}

/// Checks if the server is active.
///
/// Returns:
/// - `true` if the server is active.
/// - `false` if the server is inactive or an error occurred.
pub fn is_active() -> bool {
    // Get the status output
    let result = status().unwrap();

    // Get the exit code
    let exit_code = result.status.code().unwrap_or(-1);

    // Return true if the exit code is 0 (active), false otherwise
    exit_code == 0
}

/// Checks if the data directory exists and contains the specified file.
///
/// Returns:
/// - `Ok((0, "Data Initialized"))` if the data directory and file exist.
/// - `Ok((1, "Data Invalid"))` if the data directory exists but the file is missing.
/// - `Ok((2, "Data Missing"))` if the data directory does not exist.
pub fn data_status() -> Result<(i32, Option<&'static str>), Box<dyn std::error::Error>> {
    // Retrieve the ConfigVars instance
    let config_vars = ConfigVars::new()?;

    // Get the data directory path
    let data_dir = match config_vars.pg_data.as_deref() {
        Some(dir) => dir,
        None => return Ok((2, Some("Data Missing"))), // Data directory is missing
    };

    // Define the file to check
    let valid_file = "postgresql.conf";

    // Construct the path to the target file
    let file_path = std::path::Path::new(data_dir).join(valid_file);

    // Check if the target file exists
    if file_path.exists() {
        Ok((0, Some("Data Initialized")))
    } else {
        Ok((1, Some("Data Invalid")))
    }
}

/// Checks if the data directory is initialized.
///
/// Returns:
/// - `true` if the data directory is initialized (exit code is 0).
/// - `false` if the data directory is not initialized (exit code is not 0).
pub fn is_initialized() -> bool {
    // Get the status output
    let result = status().unwrap();

    // Get the exit code
    let exit_code = result.status.code().unwrap_or(-1);

    // Return true if the exit code is 0 (active), false otherwise
    exit_code == 0
}
