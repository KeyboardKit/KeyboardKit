//
//  AutocompleteToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /// This view mimics a native autocomplete toolbar.
    ///
    /// You can style this component with the style modifier
    /// ``autocompleteToolbarStyle(_:)``.
    /// 
    /// You can also pass in custom item and separator views.
    ///
    /// > Note: This view will be rebuilt in KeyboardKit 9.0,
    /// to work like SystemKeyboard, where the view builders
    /// provide you with the standard view. This will reduce
    /// the number of initializers needed and make it easier
    /// to work with this component.
    struct Toolbar<ItemView: View, SeparatorView: View>: View {
        
        /// Create a toolbar with custom views.
        ///
        /// - Parameters:
        ///   - suggestions: The suggestions to display.
        ///   - locale: The locale to use, by default `.current`.
        ///   - style: The style to apply, by default `.standard`.
        ///   - itemView: The suggestion view builder to use.
        ///   - separatorView: The separator view builder to use.
        ///   - suggestionAction: The action to trigger when tapping a suggestion.
        public init(
            suggestions: [Autocomplete.Suggestion],
            locale: Locale = .current,
            itemView: @escaping ItemViewBuilderOld,
            separatorView: @escaping SeparatorViewBuilder,
            suggestionAction: @escaping SuggestionAction
        ) {
            self.items = suggestions.map { BarItem($0) }
            self.itemView = itemView
            self.locale = locale
            self.initStyle = nil
            self.separatorView = separatorView
            self.suggestionAction = suggestionAction
        }
        
        @available(*, deprecated, message: "Use .autocompleteToolbarStyle to apply the style instead.")
        public init(
            suggestions: [Autocomplete.Suggestion],
            locale: Locale = .current,
            style: Style,
            itemView: @escaping ItemViewBuilderOld,
            separatorView: @escaping SeparatorViewBuilder,
            suggestionAction: @escaping SuggestionAction
        ) {
            self.items = suggestions.map { BarItem($0) }
            self.itemView = itemView
            self.locale = locale
            self.initStyle = style
            self.separatorView = separatorView
            self.suggestionAction = suggestionAction
        }
        
        public typealias Item = Autocomplete.ToolbarItem
        public typealias ItemViewBuilderOld = (Suggestion, Style, Locale) -> ItemView
        public typealias Separator = Autocomplete.ToolbarSeparator
        public typealias SeparatorViewBuilder = (Suggestion, Style) -> SeparatorView
        public typealias Style = Autocomplete.ToolbarStyle
        public typealias Suggestion = Autocomplete.Suggestion
        public typealias SuggestionAction = (Suggestion) -> Void
        
        private let items: [BarItem]
        private let locale: Locale
        private let suggestionAction: SuggestionAction
        private let itemView: ItemViewBuilderOld
        private let separatorView: SeparatorViewBuilder
        
        @Environment(\.autocompleteToolbarStyle)
        private var envStyle
        
        /// This internal struct is used to wrap item data.
        struct BarItem: Identifiable {
            
            init(_ suggestion: Suggestion) {
                self.suggestion = suggestion
            }
            
            public let id = UUID()
            public let suggestion: Suggestion
        }
        
        public var body: some View {
            HStack {
                ForEach(items) { item in
                    itemButton(for: item.suggestion)
                    if useSeparator(for: item) {
                        separatorView(item.suggestion, style)
                            .autocompleteToolbarSeparatorStyle(style.separator)
                    }
                }
            }
            .frame(height: style.height)
        }
        
        
        // MARK: - Deprecated
        
        private let initStyle: Style?
        private var style: Style { initStyle ?? envStyle }
    }
}

private extension Autocomplete.Toolbar {
    
    func itemButton(for suggestion: Suggestion) -> some View {
        Button {
            suggestionAction(suggestion)
        } label: {
            itemView(suggestion, style, locale)
                .autocompleteToolbarItemStyle(
                    suggestion.isAutocorrect ? style.autocorrectItem : style.item
                )
        }
        .buttonStyle(.plain)
    }
}

private extension Autocomplete.Toolbar {
    
    func isLast(_ item: BarItem) -> Bool {
        item.id == items.last?.id
    }
    
    func isNextItemAutocomplete(for item: BarItem) -> Bool {
        guard let index = (items.firstIndex { $0.id == item.id }) else { return false }
        let nextIndex = items.index(after: index)
        guard nextIndex < items.count else { return false }
        return items[nextIndex].suggestion.isAutocorrect
    }
    
    func useSeparator(for item: BarItem) -> Bool {
        if item.suggestion.isAutocorrect { return false }
        if isLast(item) { return false }
        return !isNextItemAutocomplete(for: item)
    }
}

public extension Autocomplete.Toolbar where ItemView == Item {
    
    /// Create a toolbar with standard item views.
    ///
    /// - Parameters:
    ///   - suggestions: A list of suggestions to display.
    ///   - locale: The locale to use, by default `.current`.
    ///   - separatorView: The function to use to build a view for each separator.
    ///   - suggestionAction: The action to use when tapping a suggestion.
    init(
        suggestions: [Suggestion],
        locale: Locale = .current,
        separatorView: @escaping SeparatorViewBuilder,
        suggestionAction: @escaping SuggestionAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.initStyle = nil
        self.suggestionAction = suggestionAction
        self.itemView = Self.standardItemView
        self.separatorView = separatorView
    }
    
    @available(*, deprecated, message: "Use .autocompleteToolbarStyle to apply the style instead.")
    init(
        suggestions: [Suggestion],
        locale: Locale = .current,
        style: Style,
        separatorView: @escaping SeparatorViewBuilder,
        suggestionAction: @escaping SuggestionAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.initStyle = style
        self.suggestionAction = suggestionAction
        self.itemView = Self.standardItemView
        self.separatorView = separatorView
    }

    /// The standard item view builder function.
    static func standardItemView(
        suggestion: Suggestion,
        style: Style,
        locale: Locale
    ) -> Autocomplete.ToolbarItem {
        .init(
            suggestion: suggestion,
            locale: locale
        )
    }
}

public extension Autocomplete.Toolbar where SeparatorView == Separator {
    
    /// Create a toolbar with standard separator views.
    ///
    /// - Parameters:
    ///   - suggestions: A list of suggestions to display.
    ///   - locale: The locale to use, by default `.current`.
    ///   - itemView: The function to use to build a view for each suggestion.
    ///   - suggestionAction: The action to use when tapping a suggestion.
    init(
        suggestions: [Suggestion],
        locale: Locale = .current,
        itemView: @escaping ItemViewBuilderOld,
        suggestionAction: @escaping SuggestionAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.initStyle = nil
        self.suggestionAction = suggestionAction
        self.itemView = itemView
        self.separatorView = Self.standardSeparatorView
    }
    
    @available(*, deprecated, message: "Use .autocompleteToolbarStyle to apply the style instead.")
    init(
        suggestions: [Suggestion],
        locale: Locale = .current,
        style: Style,
        itemView: @escaping ItemViewBuilderOld,
        suggestionAction: @escaping SuggestionAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.initStyle = style
        self.suggestionAction = suggestionAction
        self.itemView = itemView
        self.separatorView = Self.standardSeparatorView
    }
    
    /// The standard separator view builder function.
    static func standardSeparatorView(
        suggestion: Suggestion,
        style: Style
    ) -> Separator {
        .init()
    }
}

public extension Autocomplete.Toolbar where ItemView == Item, SeparatorView == Separator {
    
    /// Create a toolbar with standard views.
    ///
    /// - Parameters:
    ///   - suggestions: A list of suggestions to display.
    ///   - locale: The locale to use, by default `.current`.
    ///   - suggestionAction: The action to use when tapping a suggestion.
    init(
        suggestions: [Suggestion],
        locale: Locale = .current,
        suggestionAction: @escaping SuggestionAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.initStyle = nil
        self.suggestionAction = suggestionAction
        self.itemView = Self.standardItemView
        self.separatorView = Self.standardSeparatorView
    }
    
    init(
        suggestions: [Suggestion],
        locale: Locale = .current,
        style: Style,
        suggestionAction: @escaping SuggestionAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.initStyle = style
        self.suggestionAction = suggestionAction
        self.itemView = Self.standardItemView
        self.separatorView = Self.standardSeparatorView
    }
}

#Preview {
    
    let additional = [
        Autocomplete.Suggestion(text: "", title: "Foo", subtitle: "Recommended")
    ]
    
    func previewItem(
        for suggestion: Autocomplete.Suggestion,
        style: Autocomplete.ToolbarStyle,
        locale: Locale
    ) -> some View {
        Color.red
    }
    
    let previewSuggestions: [Autocomplete.Suggestion] = [
        .init(text: "Baz", isUnknown: true),
        .init(text: "Bar", isAutocorrect: true),
        .init(text: "", title: "Foo", subtitle: "Recommended")]
    
    return VStack {
        Autocomplete.Toolbar(
            suggestions: previewSuggestions,
            locale: KeyboardLocale.english.locale,
            suggestionAction: { _ in }
        ).previewBar()
        
        Autocomplete.Toolbar(
            suggestions: previewSuggestions + additional,
            locale: KeyboardLocale.spanish.locale,
            suggestionAction: { _ in }
        ).previewBar()
        
        Autocomplete.Toolbar(
            suggestions: previewSuggestions + additional,
            locale: KeyboardLocale.spanish.locale,
            suggestionAction: { _ in }
        )
        .previewBar()
        .autocompleteToolbarStyle(.preview1)
        
        Autocomplete.Toolbar(
            suggestions: previewSuggestions + additional,
            locale: KeyboardLocale.spanish.locale,
            suggestionAction: { _ in }
        )
        .previewBar()
        .autocompleteToolbarStyle(.preview2)
        
        Autocomplete.Toolbar(
            suggestions: previewSuggestions,
            locale: KeyboardLocale.swedish.locale,
            itemView: previewItem,
            suggestionAction: { _ in }
        )
        .previewBar()
    }
    .padding()
}

private extension View {
    
    func previewBar() -> some View {
        self.background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
