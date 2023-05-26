use std::{error::Error, path::PathBuf};
use crate::tools::get::{absolute_path, config_toml};

/// Reads the variables from the Config.toml file and prints them.
pub struct ConfigVars {
    pub verbosity_level: Option<String>,
    pub pg_data: Option<PathBuf>,
    pub pg_log: Option<PathBuf>,
    pub pg_host: Option<String>,
    pub pg_port: Option<i64>,
    pub pg_database: Option<String>,
}

impl ConfigVars {
    pub fn new() -> Result<Self, Box<dyn Error>> {
        let config = config_toml()?;

        let verbosity_level = config["verbosity"]["level"].as_str().map(|s| s.to_string());
        let pg_data = config["Server"]["PGDATA"]
            .as_str()
            .and_then(|s| absolute_path(s));
        let pg_log = config["Server"]["PGLOG"]
            .as_str()
            .and_then(|s| absolute_path(s));
        let pg_host = config["Server"]["PGHOST"].as_str().map(|s| s.to_string());
        let pg_port = config["Server"]["PGPORT"].as_integer();
        let pg_database = config["Server"]["PGDATABASE"]
            .as_str()
            .map(|s| s.to_string());

        Ok(Self {
            verbosity_level,
            pg_data,
            pg_log,
            pg_host,
            pg_port,
            pg_database,
        })
    }

    pub fn get_verbosity(&self) -> Verbosity {
        match &self.verbosity_level {
            Some(level) if level.eq_ignore_ascii_case("verbose") => Verbosity::Verbose,
            Some(level) if level.eq_ignore_ascii_case("normal") => Verbosity::Normal,
            Some(level) if level.eq_ignore_ascii_case("quiet") => Verbosity::Quiet,
            _ => panic!("Invalid verbosity level"),
        }
    }
}

#[derive(Debug, PartialEq)]
pub enum Verbosity {
    Verbose,
    Normal,
    Quiet,
}
