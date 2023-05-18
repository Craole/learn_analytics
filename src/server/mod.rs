#![allow(dead_code, unused_imports)]
use crate::load_env_vars;
use clap::{App, Arg};

mod check;
mod db;
mod reset;
mod start;
mod stop;

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
