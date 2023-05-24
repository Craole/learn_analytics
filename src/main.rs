mod config;
mod server;
mod tools;

fn main() {
    // Greet the current user
    // tools::say::hello();

    // Add the bin directory to PATH
    // tools::set_bin::main();
    // tools::init::env();

    server::output::status_info();

    // let result = server::check::status();

    // match result {
    //     Ok((exit_code, cmd_output)) => {
    //         // Convert the stdout and stderr to strings
    //         let stdout_str = String::from_utf8_lossy(&cmd_output.stdout);
    //         let stderr_str = String::from_utf8_lossy(&cmd_output.stderr);

    //         // Print the output
    //         println!("Exit code: {}", exit_code);
    //         println!("Command stdout:\n{}", stdout_str);
    //         println!("Command stderr:\n{}", stderr_str);
    //     }
    //     Err(err) => eprintln!("Error: {:?}", err),
    // }

    // let exit_code = 3;
    // std::process::exit(exit_code);
}
