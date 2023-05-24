use crate::server::check;

pub fn main() {
    // Logic to start the PostgreSQL server
    println!("Starting the server...");
    // check::status();
    // check::data();
}

// if server_is_active(config) {
//     match config.verbosity {
//         Verbosity::Verbose => println!("The server is already active"),
//         Verbosity::Normal => println!("🚀 Server active"),
//         Verbosity::Quiet => (), //~ Do nothing
//     }
//     return true;
// }

// /// Starts the PostgreSQL server by ensuring it is not already active initializing server data, and starting the server.
// fn start_server(config: &Config) -> bool {
//     //~ Ensure the server is not already active

//     //~ Execute the "pg_ctl stop" command to start the server
//     //~ Command: pg_ctl start \
//     //~              -D $PGDATA --log $PGLOG \
//     //~              --options "--unix_socket_directories='$PGDATA'"
//     let cmd_output = Command::new("pg_ctl")
//         .arg("start")
//         .arg("--log")
//         .arg("$PGLOG")
//         .arg("--options")
//         .arg(format!("--unix_socket_directories='{}'", config.db_data))
//         .output()
//         .expect("Failed to execute pg_ctl");

//     //~ Display the output mesasage based on the selected level og verbosity
//     if cmd_output.status.success() {
//         let success_message = String::from_utf8_lossy(&cmd_output.stdout);
//         match config.verbosity {
//             Verbosity::Verbose => {
//                 println!("Success message: {}", success_message);

//                 println!("The server has been started via:");
//                 println!("PGDATA: {}", &config.db_data);
//                 println!("PGHOST: {}", &config.db_host);
//                 println!("PGPORT: {}", &config.db_port);
//                 println!("PGUSER: {}", &config.db_user);
//             }
//             Verbosity::Normal => println!("🚀 Server activated"),
//             Verbosity::Quiet => (), //~ Do nothing
//         }
//         return true;
//     } else {
//         let error_message = String::from_utf8_lossy(&cmd_output.stderr);
//         let error_message = match config.verbosity {
//             Verbosity::Verbose => format!("Failed to start the server: {}", error_message),
//             Verbosity::Normal => format!("Failed to start the server"),
//             Verbosity::Quiet => String::new(), //~ Empty error message for quiet mode
//         };
//         if !error_message.is_empty() {
//             eprintln!("{}", error_message); //~ Print the error message if not empty
//         }
//         return false;
//     }
// }
