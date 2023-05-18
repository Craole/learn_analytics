// mod load_env_vars;
// use crate::env::load_env;
// mod server;

// mod load_env_vars;

mod server;
mod load_env_vars;

fn main() {
    // load_env_vars::run();
    // server::load_env_vars();

    // Call server::manage() or any other code you want to execute
    server::manage();
}

// update the clap implementation with what you think makes sense    assert_eq!(std::env::var("DB_USER").unwrap(), "craole");g
