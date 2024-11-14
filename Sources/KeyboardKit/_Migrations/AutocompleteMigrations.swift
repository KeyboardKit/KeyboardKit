import SwiftUI

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

public extension Autocomplete.ToolbarItemStyle {

    @available(*, deprecated, message: "color must come before font.")
    @_disfavoredOverload
    init(
        titleFont: KeyboardFont = .body,
        titleColor: Color = .primary,
        subtitleFont: KeyboardFont = .footnote,
        subtitleColor: Color = .primary,
        horizontalPadding: Double = 6,
        verticalPadding: Double = 10,
        backgroundColor: Color = .clear,
        backgroundCornerRadius: CGFloat = 4
    ) {
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.subtitleFont = subtitleFont
        self.subtitleColor = subtitleColor
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.backgroundColor = backgroundColor
        self.backgroundCornerRadius = backgroundCornerRadius
    }
}
