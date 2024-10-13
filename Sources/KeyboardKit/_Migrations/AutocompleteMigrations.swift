public extension Autocomplete.Suggestion {

    @available(*, deprecated, renamed: "autocompleteCased", message: "Migration Deprecation, will be removed in 9.1!")
    func withAutocompleteCasing(for word: String) -> Self {
        autocompleteCased(for: word)
    }
}
