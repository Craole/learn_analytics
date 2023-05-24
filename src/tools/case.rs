pub fn upper_camel(input: &str) -> String {
  let modified_input = input.replace(" ", "_");
  let words: Vec<&str> = modified_input.split('_').collect();
  let mut result = String::new();

  for word in words {
      let capitalized = word.chars().enumerate().map(|(i, c)| {
          if i == 0 {
              c.to_uppercase().collect::<String>()
          } else {
              c.to_lowercase().collect::<String>()
          }
      });

      result.push_str(&capitalized.collect::<String>());
  }

  result
}
