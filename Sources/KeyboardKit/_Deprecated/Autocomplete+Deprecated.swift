import Foundation

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0. Until then, use AutocompleteProvider.CompletionResult.")
public typealias AutocompleteCompletion = (AutocompleteResult) -> Void

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0. Until then, use AutocompleteProvider.Completion.")
public typealias AutocompleteResult = Result<[AutocompleteSuggestion], Error>

public extension AutocompleteSuggestion {
    
    @available(*, deprecated, message: "isAutocomplete has been renamed to isAutocorrect")
    init(
        text: String,
        title: String? = nil,
        isAutocomplete: Bool,
        isUnknown: Bool = false,
        subtitle: String? = nil,
        additionalInfo: [String: Any] = [:]
    ) {
        self.text = text
        self.title = title ?? text
        self.isAutocorrect = isAutocomplete
        self.isUnknown = isUnknown
        self.subtitle = subtitle
        self.additionalInfo = additionalInfo
    }
    
    @available(*, deprecated, renamed: "isAutocorrect")
    var isAutocomplete: Bool { isAutocorrect }
}
