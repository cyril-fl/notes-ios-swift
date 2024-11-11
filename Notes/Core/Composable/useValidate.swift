import Foundation

struct useValidate {
    static func text(_ text: String, length: Int? = nil, chars: String = "") -> String? {
        guard let validText = checkEmpty(text) else { return nil }
        let trimmedText = length != nil ? applyMaxLength(validText, max: length!) : validText
        guard let finalText = filterInvalidChars(trimmedText, chars: chars) else { return nil }
        return finalText
    }
    
    private static func checkEmpty(_ value: String) -> String? {
        guard !value.isEmpty else {
            print("Erreur : Le texte ne peut pas être vide.")
            return nil
        }
        return value
    }
    
    private static func applyMaxLength(_ value: String, max: Int) -> String {
        if value.count <= max { return value }
        print("Erreur : Le texte dépasse la longueur maximale de \(max) caractères, il sera tronqué.")
        return String(value.prefix(max))
    }
    
    private static func filterInvalidChars(_ value: String, chars: String) -> String? {
        let invalidSet = CharacterSet(charactersIn: chars)
        if value.rangeOfCharacter(from: invalidSet) == nil { return value }
        print("Erreur : Le texte contient des caractères non autorisés.")
        return value.replacingOccurrences(of: "[\(chars)]", with: "", options: .regularExpression)
    }
}
