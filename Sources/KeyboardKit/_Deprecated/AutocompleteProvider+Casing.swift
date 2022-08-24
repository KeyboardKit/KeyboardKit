import Foundation

public extension AutocompleteProvider {

    @available(*, deprecated, message: "Use String caseAdjusted(for:) instead")
    func caseAdjust(suggestion: String, for text: String) -> String {
        if text.count > 1 && text == text.uppercased() {
            return suggestion.uppercased()
        }
        if text.isCapitalized {
            return suggestion.capitalized
        }
        return suggestion
    }
}
