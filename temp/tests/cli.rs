// // tests/cli.rs

// use std::process::Command;

// #[test]
// fn test_cli_start_command() {
//     let output = Command::new("cargo")
//         .args(&["run", "--", "start"])
//         .output()
//         .expect("Failed to execute command");

//     assert!(output.status.success());
//     // Add assertions to verify the expected behavior of the 'start' command
// }

// #[test]
// fn test_cli_stop_command() {
//     let output = Command::new("cargo")
//         .args(&["run", "--", "stop"])
//         .output()
//         .expect("Failed to execute command");

//     assert!(output.status.success());
//     // Add assertions to verify the expected behavior of the 'stop' command
// }

// // Add more tests for other commands

// // Optionally, you can also test the loading of environment variables
// #[test]
// fn test_env_variables_loaded() {
//     assert_eq!(std::env::var("DB_HOST").unwrap(), "localhost");
//     assert_eq!(std::env::var("DB_PORT").unwrap(), "5432");
//     assert_eq!(std::env::var("DB_USER").unwrap(), "craole");
//     assert_eq!(std::env::var("DB_USER").unwrap(), "craole");
// }
