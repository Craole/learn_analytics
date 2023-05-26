use std::process::Output;

/// Represents the output of a function with different verbosity levels.
pub enum FunctionOutput<'a> {
    Verbose {
        cmd_output: Output,
        custom_msg: &'a str,
        // exit_code: i32,
    },
    Normal {
        custom_msg: &'a str,
        // exit_code: i32,
    },
    Quiet {
        // exit_code: i32,
    },
}

impl<'a> FunctionOutput<'a> {
    // Prints the function output based on the verbosity level.
    pub fn print_output(&self) {
        match self {
            FunctionOutput::Verbose {
                cmd_output,
                custom_msg,
                // exit_code,
            } => {
                // Display the status/exit code
                // println!("Status Code: {}", exit_code);

                // Display the message from the external command
                let standard_msg = if !cmd_output.stdout.is_empty() {
                    String::from_utf8_lossy(&cmd_output.stdout)
                        .trim_end()
                        .to_string()
                } else {
                    String::from_utf8_lossy(&cmd_output.stderr)
                        .trim_end()
                        .to_string()
                };
                println!("{}", standard_msg);

                // Display a line and the custom message
                println!("{}\n{}", "-".repeat(50), custom_msg);
            }
            FunctionOutput::Normal {
                custom_msg,
                // exit_code,
            } => {
                println!("{}", custom_msg);
            }
            FunctionOutput::Quiet {
                // exit_code,
            } => {}
        }
    }
}
