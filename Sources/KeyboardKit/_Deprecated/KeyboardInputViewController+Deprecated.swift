import Foundation

public extension KeyboardInputViewController {
    
    @available(*, deprecated, renamed: "autocompleteProvider")
    var autocompleteSuggestionProvider: AutocompleteProvider {
        get { autocompleteProvider }
        set { autocompleteProvider = newValue }
    }
}
