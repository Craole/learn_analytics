use crate::tools::get::username;

pub fn hello() {
    let username = username();
    let capitalized_username = capitalize_first_letter(&username);
    println!("Welcome {}. Let's do this!", capitalized_username);
}

fn capitalize_first_letter(username: &str) -> String {
    let mut chars = username.chars();
    match chars.next() {
        None => String::new(),
        Some(first_char) => {
            let capitalized = first_char.to_uppercase().collect::<String>();
            capitalized + chars.as_str()
        }
    }
}

