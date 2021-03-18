import SwiftUI

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
    
    @available(*, deprecated, renamed: "ItemBuilder")
    typealias ButtonBuilder = ItemBuilder
    
    @available(*, deprecated, renamed: "standardItem")
    static func standardButton(for suggestion: AutocompleteSuggestion) -> AnyView {
        standardItem(for: suggestion)
    }
    
    @available(*, deprecated, message: "This is no longer used and will be removed in 5.0.")
    static func standardReplacement(for suggestion: AutocompleteSuggestion) -> String {
        let space = " "
        let text = suggestion.text
        let proxy = KeyboardInputViewController.shared.textDocumentProxy
        let endsWithSpace = text.hasSuffix(space)
        let hasNextSpace = proxy.documentContextAfterInput?.starts(with: space) ?? false
        let insertSpace = endsWithSpace || hasNextSpace
        return insertSpace ? text : text + space
    }
}
