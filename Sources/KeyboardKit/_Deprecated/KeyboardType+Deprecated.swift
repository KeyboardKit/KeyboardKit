import Foundation

public extension KeyboardType {
    
    @available(*, deprecated, message: "Use the context-based function instead")
    var standardButtonText: String? {
        switch self {
        case .alphabetic: return KKL10n.keyboardTypeAlphabetic.text
        case .numeric: return KKL10n.keyboardTypeNumeric.text
        case .symbolic: return KKL10n.keyboardTypeSymbolic.text
        default: return nil
        }
    }
}
