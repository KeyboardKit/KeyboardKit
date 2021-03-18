import Foundation

public extension AutocompleteToolbar {
    
    @available(*, deprecated, message: "Use the itemBuilder initializer instead")
    init(
        suggestions: [AutocompleteSuggestion],
        buttonBuilder: @escaping ButtonBuilder,
        separatorBuilder: @escaping SeparatorBuilder = Self.standardSeparator,
        replacementAction: @escaping ReplacementAction = Self.standardReplacementAction) {
        self.init(
            suggestions: suggestions,
            itemBuilder: buttonBuilder,
            separatorBuilder: separatorBuilder,
            replacementAction: replacementAction)
    }
}
