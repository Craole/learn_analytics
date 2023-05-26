// use std::collections::HashMap;

// pub struct App {
//     pub function_status: FunctionStatus,
// }

// impl App {
//     pub fn new() -> Self {
//         Self {
//             function_status: FunctionStatus::new(),
//         }
//     }

//     pub fn run(&mut self) {
//         // Run your app logic here
//         // Example usage:
//         if let Err(err) = self.status() {
//             self.function_status.add_failed("status".to_string());
//             println!("Error: {:?}", err);
//         } else {
//             self.function_status.add_successful("status".to_string());
//         }

//         // Print the function status
//         self.print_function_status();
//     }

//     pub fn status(&self) -> Result<(), Box<dyn std::error::Error>> {
//         // Implement the logic for retrieving the status
//         // and returning a Result based on the outcome.
//         // Example:
//         let status_code = 0; // Simulated status code
//         if status_code == 0 {
//             Ok(())
//         } else {
//             Err("Status code is non-zero".into())
//         }
//     }

//     pub fn print_function_status(&self) {
//         println!(
//             "Successful functions: {:?}",
//             self.function_status.get_successful()
//         );
//         println!("Failed functions: {:?}", self.function_status.get_failed());
//     }
// }

// pub struct FunctionStatus {
//     function_status_map: HashMap<String, Status>,
// }

// impl FunctionStatus {
//     pub fn new() -> Self {
//         Self {
//             function_status_map: HashMap::new(),
//         }
//     }

//     pub fn add_successful(&mut self, function_name: String) {
//         self.function_status_map
//             .entry(function_name)
//             .and_modify(|status| *status = Status::Successful)
//             .or_insert(Status::Successful);
//     }

//     pub fn add_failed(&mut self, function_name: String) {
//         self.function_status_map
//             .entry(function_name)
//             .and_modify(|status| *status = Status::Failed)
//             .or_insert(Status::Failed);
//     }

//     pub fn get_successful(&self) -> Vec<String> {
//         self.get_functions_by_status(Status::Successful)
//     }

//     pub fn get_failed(&self) -> Vec<String> {
//         self.get_functions_by_status(Status::Failed)
//     }

//     fn get_functions_by_status(&self, status: Status) -> Vec<String> {
//         self.function_status_map
//             .iter()
//             .filter(|(_, s)| **s == status)
//             .map(|(name, _)| name.clone())
//             .collect()
//     }
// }

// #[derive(Debug, PartialEq, Eq)]
// enum Status {
//     Successful,
//     Failed,
// }
