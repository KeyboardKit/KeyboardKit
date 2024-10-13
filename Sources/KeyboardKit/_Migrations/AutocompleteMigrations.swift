public extension Autocomplete.Suggestion {

    @available(*, deprecated, renamed: "autocompleteCased", message: "Migration Deprecation, will be removed in 9.1!")
    func withAutocompleteCasing(for word: String) -> Self {
        autocompleteCased(for: word)
    }
}

public extension AutocompleteService {

    @available(*, deprecated, renamed: "autocomplete", message: "Migration Deprecation, will be removed in 9.1!")
    func autocompleteSuggestions(
        for text: String
    ) async throws -> [Autocomplete.Suggestion] {
        try await autocomplete(text).suggestions
    }

    @available(*, deprecated, renamed: "autocomplete", message: "Migration Deprecation, will be removed in 9.1!")
    func nextCharacterPredictions(
        forText text: String,
        suggestions: [Autocomplete.Suggestion]
    ) async throws -> [Character: Double] {
        try await autocomplete(text).nextCharacterPredictions ?? [:]
    }
}
