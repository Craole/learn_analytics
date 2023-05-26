use crate::{
    app::{
        config::{ConfigVars, Verbosity},
        output::FunctionOutput,
    },
    tools::get,
};
use std::process::{Command, ExitCode, Output};

/// Retrieves the status of the server by executing the "pg_ctl status" command.
///
/// # Arguments
/// - `app`: A mutable reference to the `App` struct.
///
/// # Returns
/// - `Ok(FunctionOutput)`: The output of the command if successful.
/// - `Err(Box<dyn std::error::Error>)`: An error if the command execution fails.
pub fn status() -> Result<(FunctionOutput<'static>, i32), Box<dyn std::error::Error>> {
    let config = ConfigVars::new()?; // Retrieve the configuration variables

    // Execute the "pg_ctl status" command to check server status
    let cmd_output = Command::new("pg_ctl")
        .arg("status")
        .arg("-D")
        .arg(config.pg_data.as_deref().unwrap()) // Accessing pg_data field from ConfigVars
        .output()?; // Execute the command and capture the output

    let exit_code = cmd_output.status.code().unwrap_or(0); // Get the status code

    // Determine the status message based on the status code
    let status = if exit_code == 0 {
        "🚀 Server Active"
    } else {
        "💀 Server Inactive"
    };

    // Create the appropriate FunctionOutput based on the verbosity level
    let function_output = match config.get_verbosity() {
        Verbosity::Verbose => FunctionOutput::Verbose {
            cmd_output,
            custom_msg: status,
            // exit_code,
        },
        Verbosity::Normal => FunctionOutput::Normal {
            custom_msg: status,
            // exit_code,
        },
        Verbosity::Quiet => FunctionOutput::Quiet {},
    };

    Ok((function_output, exit_code))
}

// /// Checks if the data directory exists and contains the specified file.
// ///
// /// # Arguments
// /// - `app`: A mutable reference to the `App` struct.
// ///
// /// # Returns
// /// - `Ok((0, "Data Initialized"))` if the data directory and file exist.
// /// - `Ok((1, "Data Invalid"))` if the data directory exists but the file is missing.
// /// - `Ok((2, "Data Missing"))` if the data directory does not exist.
// pub fn data_status() -> Result<(i32, Option<&'static str>), Box<dyn std::error::Error>> {
//     // Retrieve the ConfigVars instance
//     let config = ConfigVars::new()?;

//     // Get the data directory path
//     let data_dir = match config.pg_data.as_deref() {
//         Some(dir) => dir,
//         None => return Ok((2, Some("Data Missing"))), // Data directory is missing
//     };

//     // Define the file to check
//     let valid_file = "postgresql.conf";

//     // Construct the path to the target file
//     let file_path = std::path::Path::new(data_dir).join(valid_file);

//     // Check if the target file exists
//     let data_status = if file_path.exists() {
//         (0, Some("Data Initialized"))
//     } else {
//         (1, Some("Data Invalid"))
//     };

//     Ok(data_status)
// }

/// Checks if the data directory exists and contains the specified file.
///
/// # Arguments
/// - `app`: A mutable reference to the `App` struct.
///
/// # Returns
/// - `Ok(FunctionOutput)`: The output of the command if successful.
/// - `Err(Box<dyn std::error::Error>)`: An error if the command execution fails.
pub fn data_status() -> Result<(FunctionOutput<'static>, i32), Box<dyn std::error::Error>> {
    // Retrieve the ConfigVars instance
    let config = ConfigVars::new()?;

    // Get the data directory path
    let data_dir = match config.pg_data.as_deref() {
        Some(dir) => dir,
        None => {
            return Ok((
                FunctionOutput::Verbose {
                    cmd_output: Output::default(),
                    custom_msg: "Data Missing",
                },
                2,
            ))
        } // Data directory is missing
    };

    // Define the file to check
    let valid_file = "postgresql.conf";

    // Construct the path to the target file
    let file_path = std::path::Path::new(data_dir).join(valid_file);

    // Check if the target file exists
    let data_status = if file_path.exists() {
        FunctionOutput::Verbose {
            cmd_output: Output::default(),
            custom_msg: "Data Initialized",
        }
    } else {
        FunctionOutput::Verbose {
            cmd_output: Output::default(),
            custom_msg: "Data Invalid",
        }
    };

    Ok((data_status, 0))
}
