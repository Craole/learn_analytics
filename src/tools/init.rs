// use std::env;

// use super::get::username;

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

// pub fn env() -> Config {
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

//     //~ Get the current username
//     let db_user = username()
//         .map(|username| username.to_string_lossy().into_owned())
//         .unwrap_or_else(|| {
//             eprintln!("Failed to get the current username. Using a default value.");
//             String::from("default_user")
//         });

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
