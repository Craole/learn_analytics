#[cfg(test)]
mod tests {
    use crate::app::output::FunctionOutput;

    #[test]
    fn test_function_output_verbose() {
        let function_output = FunctionOutput::Verbose {
            stdout: vec![b'H', b'e', b'l', b'l', b'o'],
            stderr: vec![b'E', b'r', b'r', b'o', b'r'],
            custom: String::from("Custom verbose message"),
            status_code: 2,
        };

        if let FunctionOutput::Verbose { status_code, .. } = function_output {
            assert_eq!(status_code, 2);
        } else {
            panic!("Unexpected enum variant");
        }
    }

    #[test]
    fn test_function_output_normal() {
        let function_output = FunctionOutput::Normal {
            custom: String::from("Custom normal message"),
            status_code: 3,
        };

        if let FunctionOutput::Normal { status_code, .. } = function_output {
            assert_eq!(status_code, 3);
        } else {
            panic!("Unexpected enum variant");
        }
    }

    #[test]
    fn test_function_output_quiet() {
        let function_output = FunctionOutput::Quiet { status_code: 4 };

        if let FunctionOutput::Quiet { status_code } = function_output {
            assert_eq!(status_code, 4);
        } else {
            panic!("Unexpected enum variant");
        }
    }

    // Add more test cases for other variants of FunctionOutput and any helper methods as needed
}
