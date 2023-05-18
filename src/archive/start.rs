use clap::{App, ArgMatches};

pub fn build_subcommand() -> App<'static, 'static> {
    App::new("start").about("Starts the server")
    // Add any specific arguments or options for this subcommand
    // using the `.arg()` method
}

pub fn start(matches: &ArgMatches) {
    // Logic for starting the server
    println!("Starting the server...");
}
