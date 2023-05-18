use clap::{App, Arg};

mod start;
mod stop;
mod reset;
mod check;
mod db;

pub fn manage() {
    let matches = App::new("Server Manager")
        .subcommand(start::build_subcommand())
        .subcommand(stop::build_subcommand())
        .subcommand(reset::build_subcommand())
        .subcommand(check::build_subcommand())
        .subcommand(db::build_subcommand())
        .get_matches();

    match matches.subcommand() {
        ("start", Some(matches)) => start::start(matches),
        ("stop", Some(matches)) => stop::stop(matches),
        ("reset", Some(matches)) => reset::reset(matches),
        ("check", Some(matches)) => check::check(matches),
        ("db", Some(matches)) => db::db(matches),
        _ => println!("Invalid command"),
    }
}
