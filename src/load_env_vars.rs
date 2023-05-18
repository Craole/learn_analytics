pub fn main() {
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
