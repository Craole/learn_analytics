use crate::config::{ConfigVars, Verbosity};
use std::process::{exit, Output};

use super::check::status;

pub fn status_info() {
    // Get the verbosity level from ConfigVars
    let config = ConfigVars::new().unwrap();
    let verbosity = config.get_verbosity();
    let result = status();

    let (exit_code, stdout_str, stderr_str): (i32, String, String);
    match result {
        Ok((code, cmd_output)) => {
            // Convert the stdout and stderr to strings
            stdout_str = String::from_utf8_lossy(&cmd_output.stdout)
                .trim_end()
                .to_string();
            stderr_str = String::from_utf8_lossy(&cmd_output.stderr)
                .trim_end()
                .to_string();
            exit_code = code;
        }
        Err(err) => {
            eprintln!("Error: {:?}", err);
            exit(1); // Terminate with a non-zero exit code upon error
        }
    }

    let status = if exit_code == 0 { "Active" } else { "Inactive" };

    match verbosity {
        Verbosity::Verbose => {
            println!("Exit code: {}", exit_code);
            println!("Command stdout: {}", stdout_str);
            println!("Server Status: {}", status);

            if !stderr_str.is_empty() {
                println!("Command stderr:{}", stderr_str);
            }
        }
        Verbosity::Normal => {
            println!("Server Status: {}", status);
        }
        Verbosity::Quiet => {
            // Do nothing, no output
        }
    }

    exit(exit_code); // Terminate with the obtained exit code
}
