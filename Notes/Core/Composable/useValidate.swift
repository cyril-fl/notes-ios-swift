import Foundation

/// A utility struct providing text validation and sanitization methods.
struct useValidate {

    /// Validates and sanitizes the given text based on optional constraints: length and invalid characters.
    ///
    /// - Parameters:
    ///   - text: The input text to validate.
    ///   - length: An optional maximum length for the text. If specified, the text will be truncated if it exceeds this length.
    ///   - chars: A string of characters that are considered invalid. Any character found in this set will be removed from the text.
    ///
    /// - Returns: A validated and sanitized string, or `nil` if the input text is empty or cannot be processed.
    ///
    /// - Example:
    ///   ```swift
    ///   let validText = useValidate.text("Hello, World!", length: 5, chars: "!@#")
    ///   // Output: "Hello"
    ///
    ///   let validText2 = useValidate.text("Test@123", chars: "@")
    ///   // Output: "Test123"
    ///   ```
    static func text(_ text: String, length: Int? = nil, chars: String = "") -> String? {
        guard let validText = checkEmpty(text) else { return nil }
        let trimmedText = length != nil ? applyMaxLength(validText, max: length!) : validText
        guard let finalText = filterInvalidChars(trimmedText, chars: chars) else { return nil }
        return finalText
    }

    /// Checks if the input string is empty.
    ///
    /// - Parameter value: The input string to check.
    /// - Returns: The input string if it's not empty, otherwise `nil`.
    /// - Note: Prints an error message if the string is empty.
    private static func checkEmpty(_ value: String) -> String? {
        guard !value.isEmpty else {
            print("Error: The text cannot be empty.")
            return nil
        }
        return value
    }

    /// Truncates the input string if it exceeds the specified maximum length.
    ///
    /// - Parameters:
    ///   - value: The input string to check.
    ///   - max: The maximum allowed length for the string.
    /// - Returns: The truncated string if its length exceeds the maximum, otherwise the original string.
    /// - Note: Prints a warning message if the string is truncated.
    private static func applyMaxLength(_ value: String, max: Int) -> String {
        if value.count <= max { return value }
        print("Warning: The text exceeds the maximum length of \(max) characters and will be truncated.")
        return String(value.prefix(max))
    }

    /// Removes any invalid characters from the input string.
    ///
    /// - Parameters:
    ///   - value: The input string to check.
    ///   - chars: A string of characters to be removed from the input.
    /// - Returns: The sanitized string, or `nil` if invalid characters were found and removed.
    /// - Note: Prints an error message if invalid characters are found.
    private static func filterInvalidChars(_ value: String, chars: String) -> String? {
        let invalidSet = CharacterSet(charactersIn: chars)
        if value.rangeOfCharacter(from: invalidSet) == nil { return value }
        print("Error: The text contains invalid characters.")
        return value.replacingOccurrences(of: "[\(chars)]", with: "", options: .regularExpression)
    }
}
