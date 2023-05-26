#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_function_status() {
        let mut function_status = FunctionStatus::new();

        // Add successful and failed functions
        function_status.add_successful("function1".to_string());
        function_status.add_failed("function2".to_string());
        function_status.add_successful("function3".to_string());

        // Check the list of successful and failed functions
        let successful_functions = function_status.get_successful();
        let failed_functions = function_status.get_failed();

        assert_eq!(successful_functions, vec!["function1", "function3"]);
        assert_eq!(failed_functions, vec!["function2"]);
    }
}
