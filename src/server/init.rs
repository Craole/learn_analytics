// use std::{env, path::Path, process::exit, fs};

// use crate::tools::get;

// #[derive(PartialEq)]
// enum Verbosity {
//     Verbose,
//     Normal,
//     Quiet,
// }

// struct Config {
//     db_host: String,
//     db_port: String,
//     db_user: String,
//     db_log: String,
//     db_data: String,
//     db: String,
//     verbosity: Verbosity,
// }

// /// Initializes the environment configuration by loading variables from the TOML config file.  Returns a Config struct containing the loaded values.
// fn main() -> Config {
//     //~ Load the TOML config file
//     let parsed_config = load_config_toml();

//     //~ Get the project root directory
//     let workspace = env::current_dir()
//         .map(|path| path.to_string_lossy().into_owned())
//         .unwrap_or_else(|_| {
//             eprintln!("Failed to get the project root directory. Using a default value.");
//             String::from("default_workspace")
//         });

//     //~ Load individual variables from the config file
//     let db_log_relative = load_toml_var(&parsed_config, "Server.LOG");
//     let db_log = Path::new(&workspace)
//         .join(&db_log_relative)
//         .to_string_lossy()
//         .into_owned();
//     let db_data_relative = load_toml_var(&parsed_config, "Server.DATA");
//     let db_data = Path::new(&workspace)
//         .join(&db_data_relative)
//         .to_string_lossy()
//         .into_owned();
//     let db_host = load_toml_var(&parsed_config, "Server.HOST");
//     let db_port = load_toml_var(&parsed_config, "Server.PORT");
//     let db = load_toml_var(&parsed_config, "Server.DB");

//     match tools::get::config_toml() {
//         Ok(config) => {
//     let server_data = config["Server"]["PGDATA"].as_str();
//     let server_log = config["Server"]["PGLOG"].as_str();
//     let server_host = config["Server"]["PGHOST"].as_str();
//     let server_port = config["Server"]["PGPORT"].as_integer();
//     let server_user = config["Server"]["PGDATABASE"].as_str();
//     let server_db = config["Server"]["PGDATABASE"].as_str();
//         };
//     //~ Get the current username
//     let db_user = get::username();

//     //~ Extract verbosity from config.toml
//     let verbosity = match parsed_config.get("verbosity") {
//         Some(value) => match value.get("level") {
//             Some(level) => match level.as_str() {
//                 Some("verbose") => Verbosity::Verbose,
//                 Some("normal") => Verbosity::Normal,
//                 Some("quiet") => Verbosity::Quiet,
//                 _ => {
//                     eprintln!("Invalid verbosity level in config.toml. Using normal level.");
//                     Verbosity::Normal
//                 }
//             },
//             None => {
//                 eprintln!("Missing verbosity level in config.toml. Using normal level.");
//                 Verbosity::Normal
//             }
//         },
//         None => {
//             eprintln!("Missing verbosity section in config.toml. Using normal level.");
//             Verbosity::Normal
//         }
//     };

//     //~ Export variables as environment variables
//     env::set_var("WORKSPACE", &workspace);
//     env::set_var("PGHOST", &db_host);
//     env::set_var("PGPORT", &db_port);
//     env::set_var("PGUSER", &db_user);
//     env::set_var("PGLOG", &db_log);
//     env::set_var("PGDATA", &db_data);
//     env::set_var("PGDATABASE", &db);

//     //~ Construct the Config struct with the loaded values
//     Config {
//         db_host,
//         db_port,
//         db_user,
//         db_log,
//         db_data,
//         db,
//         verbosity,
//     }
// }
