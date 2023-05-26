use std::{env, error::Error, fs::File, io::Read, path::PathBuf};

#[macro_export]
macro_rules! function_path {
    () => {{
        fn f() {}
        fn type_name_of<T>(_: T) -> &'static str {
            std::any::type_name::<T>()
        }
        let name = type_name_of(f);

        // Find and cut the rest of the path
        match &name[..name.len() - 3].rfind(':') {
            Some(pos) => &name[..pos + 1],
            None => "",
        }
    }};
}

pub fn function_path() -> &'static str {
    function_path!()
}

// macro_rules! function {
//     () => {{
//         fn f() {}
//         fn type_name_of<T>(_: T) -> &'static str {
//             std::any::type_name::<T>()
//         }
//         let name = type_name_of(f);

//         // Find and cut the rest of the path
//         match &name[..name.len() - 3].rfind(':') {
//             Some(pos) => &name[pos + 1..name.len() - 3],
//             None => &name[..name.len() - 3],
//         }
//     }};
// }

// pub fn function_path() {
//     let function_path = format!("{}::{}", module_path!(), function!());
//     println!("{}",function_path)
// }

/// Retrieves the username of the current user from the environment variables.
///
/// If the username is not found in the environment variables, it returns "Unknown User".
///
/// # Examples
///
/// ```
/// let username = username();
/// println!("Username: {}", username);
/// ```
pub fn username() -> String {
    // Retrieve the value of the "USER" or "USERNAME" environment variable
    let username = env::var("USER")
        .or_else(|_| env::var("USERNAME"))
        .unwrap_or_else(|_| "Unknown User".to_string());

    username
}

/// Retrieves the project root directory by searching for the presence of a `Cargo.toml` file.
///
/// Returns `Ok(PathBuf)` containing the project root directory if found,
/// or `Err` with an error message otherwise.
///
/// # Errors
///
/// Returns an `Err` variant with a descriptive error message if the project root directory cannot be found.
///
/// # Examples
///
/// ```
/// match project_path() {
///     Ok(path) => {
///         println!("Project root directory: {:?}", path);
///     }
///     Err(err) => {
///         eprintln!("Failed to find project root directory: {}", err);
///     }
/// }
/// ```
pub fn project_path() -> Result<PathBuf, Box<dyn Error>> {
    let top_level_project_file = "Cargo.toml";

    // Get the current directory
    let current_dir = env::current_dir()?;

    // Check if the Cargo.toml file exists in the current directory
    let manifest_path = current_dir.join(top_level_project_file);
    if manifest_path.exists() {
        Ok(current_dir)
    } else {
        // Traverse parent directories to find the project root
        let mut dir = current_dir.parent();

        while let Some(parent) = dir {
            let cargo_toml_path = parent.join(top_level_project_file);

            if cargo_toml_path.exists() {
                return Ok(parent.to_owned());
            }

            dir = parent.parent();
        }

        Err("Could not find project root directory.".into())
    }
}

/// Converts the provided path to an absolute path based on the project root.
/// If the path is already absolute, it is returned as is.
///
/// # Arguments
///
/// * `path_str` - A string slice representing the path to be converted.
///
/// # Returns
///
/// An `Option<PathBuf>` containing the absolute path if the conversion is successful and the path exists,
/// or `None` if there was an error retrieving the project root, constructing the absolute path,
/// or if the path does not exist.
///
/// # Examples
///
/// ```
/// let path = absolute_path("data/file.txt");
/// if let Some(absolute_path) = path {
///     println!("Absolute path: {:?}", absolute_path);
/// } else {
///     println!("Failed to get the absolute path or path does not exist");
/// }
/// ```
pub fn absolute_path(path_str: &str) -> Option<PathBuf> {
    // Get the project root path
    let project_root = match project_path() {
        Ok(root) => root,
        Err(err) => {
            eprintln!("Failed to get the project root: {}", err);
            return None;
        }
    };

    // Construct the absolute path by joining the project root path with the provided relative path
    let absolute_path = project_root.join(path_str);

    // Check if the path exists and return it, or None if it doesn't exist
    if absolute_path.exists() {
        Some(absolute_path)
    } else {
        None
    }
}

/// Retrieves the bin path of the project by checking for the existence of the "bin" directory.
/// Returns `Some(PathBuf)` containing the bin path if found, or `None` otherwise.
///
/// # Returns
///
/// An `Option<PathBuf>` representing the bin path if found, or `None` if the bin directory does not exist.
pub fn bin_path() -> Option<PathBuf> {
    // Check if the "bin" directory exists in the project root
    let bin_path = absolute_path("bin");

    // If the bin directory is not found in the project root, check if it's in "src" and return that path
    let src_bin_path = absolute_path("src/bin");

    // Return the first found path (either bin_path or src_bin_path)
    bin_path.or(src_bin_path)
}

/// Reads the variables from the Config.toml file.
/// Returns `Ok(Value)` containing the parsed TOML value if the file exists and is valid,
/// or `Err` with an error message otherwise.
pub fn config_toml() -> Result<toml::Value, Box<dyn Error>> {
    let project_root = project_path()?;
    let config_path = project_root.join("Config.toml");

    // Check if Config.toml file exists
    if !config_path.exists() {
        return Err("Config.toml file not found".into());
    }

    // Read the contents of the Config.toml file
    let mut file = File::open(config_path)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;

    // Parse the contents as TOML
    let config: toml::Value = toml::from_str(&contents)?;

    Ok(config)
}

// /// Reads the variables from the Config.toml file and prints them.
// pub struct ConfigVars {
//     pub verbosity_level: Option<String>,
//     pub pg_data: Option<PathBuf>,
//     pub pg_log: Option<PathBuf>,
//     pub pg_host: Option<String>,
//     pub pg_port: Option<i64>,
//     pub pg_database: Option<String>,
// }

// impl ConfigVars {
//     pub fn new() -> Result<Self, Box<dyn Error>> {
//         let config = config_toml()?;

//         let verbosity_level = config["verbosity"]["level"].as_str().map(|s| s.to_string());
//         let pg_data = config["Server"]["PGDATA"]
//             .as_str()
//             .and_then(|s| absolute_path(s));
//         let pg_log = config["Server"]["PGLOG"]
//             .as_str()
//             .and_then(|s| absolute_path(s));
//         let pg_host = config["Server"]["PGHOST"].as_str().map(|s| s.to_string());
//         let pg_port = config["Server"]["PGPORT"].as_integer();
//         let pg_database = config["Server"]["PGDATABASE"]
//             .as_str()
//             .map(|s| s.to_string());

//         Ok(Self {
//             verbosity_level,
//             pg_data,
//             pg_log,
//             pg_host,
//             pg_port,
//             pg_database,
//         })
//     }
// }

// #[derive(PartialEq)]
// pub enum Verbosity {
//     Verbose,
//     Normal,
//     Quiet,
// }
