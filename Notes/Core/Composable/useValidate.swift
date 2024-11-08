import Foundation

struct useValidate {
    static func text(_ text: String, lenght: Int = 120, chars: String = "!@#$%^&*()") -> String? {
        guard let _text = isEmpty(text) else { return nil }
        guard let _lenght = isMaxLenght(_text, max: lenght) else { return nil }
        guard let _validate = isInvalidCharacters(_lenght, chars: chars) else { return nil }
        return _validate
    }
    
    private static func isEmpty(_ value: String) -> String? {
        if !value.isEmpty { return value }
        
        print("Error: The name cannot be empty.")
        return nil
    }
    
    private static func isMaxLenght(_ value: String, max: Int) -> String? {
        if value.count < max { return value }
        
        print("Error: The name is too long, trimming to \(max) characters.")
        return String(value.prefix(max))
    }
    
    private static func isInvalidCharacters(_ value: String, chars: String) -> String? {
        if value.rangeOfCharacter(from: CharacterSet(charactersIn: chars)) == nil { return value }
        
        print("Error: The name contains invalid characters.")
        return value.replacingOccurrences(of: chars, with: "", options: .regularExpression)
    }
}
