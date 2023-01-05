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

public extension StandardAutocompleteSuggestion {

    @available(*, deprecated, message: "Please specify text: from now on.")
    init(
        _ text: String,
        isAutocomplete: Bool = false,
        isUnknown: Bool = false
    ) {
        self.text = text
        self.title = text
        self.isAutocomplete = isAutocomplete
        self.isUnknown = isUnknown
        self.subtitle = nil
        self.additionalInfo = [:]
    }
}
