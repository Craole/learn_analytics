// use super::check;
// use crate::interface::{
//     config::{ConfigVars, Verbosity},
//     status::FunctionOutput,
// };
// use std::process::{exit, Command, Output};
// pub fn status_info() {
//     // Get the verbosity level from ConfigVars
//     let config = ConfigVars::new().unwrap();
//     let verbosity = config.get_verbosity();
//     let cmd_output = check::status().unwrap();
//     let exit_code = cmd_output.status.code().unwrap_or(-1);
//     let stdout_str = String::from_utf8_lossy(&cmd_output.stdout)
//         .trim_end()
//         .to_string();
//     let stderr_str = String::from_utf8_lossy(&cmd_output.stderr)
//         .trim_end()
//         .to_string();
//     let status = if exit_code == 0 {
//         "🚀 Active"
//     } else {
//         "💀 Inactive"
//     };

//     match verbosity {
//         Verbosity::Verbose => {
//             println!("Exit code: {}", exit_code);
//             println!("Command stdout: {}", stdout_str);
//             if !stderr_str.is_empty() {
//                 println!("Command stderr: {}", stderr_str);
//             }
//             println!("Server Status: {}", status);
//         }
//         Verbosity::Normal => {
//             println!("Server Status: {}", status);
//         }
//         Verbosity::Quiet => {
//             // Do nothing, no output
//         }
//     }
// }

// // pub fn data_info() {
// //     let config = ConfigVars::new().unwrap();
// //     let verbosity = config.get_verbosity();
// //     let (exit_code, status) = check::data_status().unwrap();

// //     match verbosity {
// //         Verbosity::Verbose => {
// //             println!("Exit code: {}", exit_code);
// //             println!("Server Data Status: {}", status);
// //         }
// //         Verbosity::Normal => {
// //             println!("Server Data Status: {}", status);
// //         }
// //         Verbosity::Quiet => {
// //             // Do nothing, no output
// //         }
// //     }

// //     exit(exit_code); // Terminate with the obtained exit code
// // }

// pub fn data_info() {
//     let config = ConfigVars::new().unwrap();
//     let verbosity = config.get_verbosity();
//     let (status_code, status) = check::data_status().unwrap();

//     // Create and update GracefulExit with the status_code if it's greater than zeroSS
//     let exit_code = FunctionOutput { code: status_code };
//     // exit_code.check_code(status_code);ok

//     match verbosity {
//         Verbosity::Verbose => {
//             println!("Exit code: {}", status_code);
//             if let Some(status_msg) = status {
//                 println!("Server Status: {}", status_msg);
//             }
//         }
//         Verbosity::Normal => {
//             if let Some(status_msg) = status {
//                 println!("Server Status: {}", status_msg);
//             }
//         }
//         Verbosity::Quiet => {
//             // Do nothing, no output
//         }
//     }
// }
