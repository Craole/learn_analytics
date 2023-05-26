// pub enum FunctionOutput {
//     Verbose {
//         stdout: Vec<u8>,
//         stderr: Vec<u8>,
//         custom: String,
//         status_code: i32,
//     },
//     Normal {
//         custom: String,
//         status_code: i32,
//     },
//     Quiet {
//         status_code: i32,
//     },
// }

// impl FunctionOutput {
//     pub fn string_message(&mut self, stdout: Vec<u8>, stderr: Vec<u8>, custom: &str) {
//         match self {
//             FunctionOutput::Verbose {
//                 stdout: _,
//                 stderr: _,
//                 custom: _,
//                 ..
//             } => {
//                 let stdout_string = String::from_utf8_lossy(&stdout).trim_end().to_string();
//                 let stderr_string = String::from_utf8_lossy(&stderr).trim_end().to_string();
//                 let custom_string = custom.to_string();

//                 if let FunctionOutput::Verbose {
//                     stdout,
//                     stderr,
//                     custom,
//                     ..
//                 } = self
//                 {
//                     *stdout = stdout_string.into_bytes();
//                     *stderr = stderr_string.into_bytes();
//                     *custom = custom_string;
//                 }
//             }
//             FunctionOutput::Normal { custom: _, .. } => {
//                 let custom_string = custom.to_string();

//                 if let FunctionOutput::Normal { custom, .. } = self {
//                     *custom = custom_string;
//                 }
//             }
//             _ => {} // No processing needed for Quiet variant
//         }
//     }

//     pub fn print_message(&self) {
//         match self {
//             FunctionOutput::Verbose {
//                 stdout,
//                 stderr,
//                 custom,
//                 status_code,
//             } => {
//                 println!("Verbose Output:");
//                 println!("Status Code: {}", status_code);
//                 println!("Stdout: {}", String::from_utf8_lossy(stdout));
//                 println!("Stderr: {}", String::from_utf8_lossy(stderr));
//                 println!("Custom Message: {}", custom);
//             }
//             FunctionOutput::Normal {
//                 custom,
//                 status_code,
//             } => {
//                 println!("Normal Output:");
//                 println!("Status Code: {}", status_code);
//                 println!("Custom Message: {}", custom);
//             }
//             FunctionOutput::Quiet { status_code } => {
//                 println!("Quiet Output:");
//                 println!("Status Code: {}", status_code);
//             }
//         }
//     }
// }

// // enum AppStatus {
// //     StatusCode(i32),
// // }

// // impl AppStatus {
// //     fn is_error(&self) -> bool {
// //         match self {
// //             AppStatus::StatusCode(code) => *code != 0,
// //         }
// //     }
// // }
