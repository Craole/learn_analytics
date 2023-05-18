//! ```cargo
//! [dependencies]
//! dotenv = "0.15.0"
//! clap = "2.33.0"
//! ```
fn main() {
  load_env_vars();
  manage();
}

fn load_env_vars() {
    use dotenv::dotenv;
    use std::env;
    dotenv().ok();

    // Load specific variables and set defaults if not found
    let db_host = env::var("DB_HOST").unwrap_or_else(|_| String::from("localhost"));
    let db_port = env::var("DB_PORT").unwrap_or_else(|_| String::from("5432"));
    let db_user = env::var("DB_USER").unwrap_or_else(|_| String::from("postgres"));
    let db_log = env::var("DB_LOG").unwrap_or_else(|_| String::from("true"));
    let db_data = env::var("DB_DATA").unwrap_or_else(|_| String::from("/var/lib/postgresql/data"));

    // Use the variables as needed
    println!("DB_HOST: {}", db_host);
    println!("DB_PORT: {}", db_port);
    println!("DB_USER: {}", db_user);
    println!("DB_LOG: {}", db_log);
    println!("DB_DATA: {}", db_data);
}

pub fn manage() {
  load_env_vars::main();
  let matches = App::new("My CLI")
      .version("1.0")
      .author("Your Name")
      .about("CLI to manage a PostgreSQL server")
      .subcommand(
          App::new("start").about("Start the PostgreSQL server"), // Add specific arguments or options for the 'start' command if needed
      )
      .subcommand(
          App::new("stop").about("Stop the PostgreSQL server"), // Add specific arguments or options for the 'stop' command if needed
      )
      .subcommand(
          App::new("reset").about("Reset the PostgreSQL server"), // Add specific arguments or options for the 'reset' command if needed
      )
      .subcommand(
          App::new("check").about("Check the status of the PostgreSQL server"), // Add specific arguments or options for the 'check' command if needed
      )
      .subcommand(
          App::new("db").about("Manage the PostgreSQL database"), // Add specific arguments or options for the 'db' command if needed
      )
      .get_matches();

  match matches.subcommand() {
      ("start", Some(_)) => start::main(),
      ("stop", Some(_)) => stop::main(),
      ("reset", Some(_)) => reset::main(),
      ("check", Some(_)) => check::main(),
      ("db", Some(_)) => db::main(),
      _ => println!("Invalid command. Use --help for available commands."),
  }
}