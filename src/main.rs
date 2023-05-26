#![allow(dead_code)]
use crate::server::check::status;

mod app;
mod server;
mod tools;

// fn main() -> Result<(), Box<dyn std::error::Error>> {
//     // Call the status function and get only the status code
//     let (_, exit_code) = server::check::status()?;

//     std::process::exit(exit_code);
// }

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Call the status function and get only the status code
    let (_, exit_code) = status()?;

    // Use the status code in the ExitCode::from method
    // let exit_code = ExitCode::from(code);

    // Do something with the exit code
    println!("The exit code is: {:?}", exit_code);

    Ok(())
}
