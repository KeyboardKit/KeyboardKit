//
//  Autocomplete+Toolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /**
     This toolbar presents autocomplete suggestions as items,
     with separators between the items.
     
     You can customize the item and separator views with the
     `itemView` and/or `separatorView` view builders.
     */
    struct Toolbar<ItemView: View, SeparatorView: View>: View {
        
        /**
         Create an autocomplete toolbar.
         
         - Parameters:
           - suggestions: The list of suggestions to display.
           - locale: The locale to use, by default `.current`.
           - style: The style to apply, by default `.standard`.
           - itemView: The function to use to build a view for each suggestion.
           - separatorView: The function to use to build a view for each separator.
           - suggestionAction: The action to use when tapping a suggestion.
         */
        public init(
            suggestions: [Autocomplete.Suggestion],
            locale: Locale = .current,
            style: Style = .standard,
            itemView: @escaping ItemViewBuilder,
            separatorView: @escaping SeparatorViewBuilder,
            suggestionAction: @escaping SuggestionAction
        ) {
            self.items = suggestions.map { BarItem($0) }
            self.itemView = itemView
            self.locale = locale
            self.style = style
            self.separatorView = separatorView
            self.suggestionAction = suggestionAction
        }
        
        public typealias Item = Autocomplete.ToolbarItem
        public typealias Separator = Autocomplete.ToolbarSeparator
        public typealias Style = KeyboardStyle.AutocompleteToolbar
        public typealias Suggestion = Autocomplete.Suggestion
        
        private let items: [BarItem]
        private let locale: Locale
        private let style: Style
        private let suggestionAction: SuggestionAction
        private let itemView: ItemViewBuilder
        private let separatorView: SeparatorViewBuilder
        
        /// This is a typealias for a suggestion tap action.
        public typealias SuggestionAction = (Suggestion) -> Void
        
        /// This view builder is used to build toolbar items.
        public typealias ItemViewBuilder = (Suggestion, Style, Locale) -> ItemView
        
        /// This view builder is used to build item separators.
        public typealias SeparatorViewBuilder = (Suggestion, Style) -> SeparatorView
        
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
                    }
                }
            }.frame(height: style.height)
        }
    }
}

public extension Autocomplete.Toolbar where ItemView == Item {
    
    /**
     Create an autocomplete toolbar with standard item views.

     - Parameters:
       - suggestions: The list of suggestions to display.
       - locale: The locale to use, by default `.current`.
       - style: The style to apply, by default `.standard`.
       - separatorView: The function to use to build a view for each separator.
       - suggestionAction: The action to use when tapping a suggestion.
     */
    init(
        suggestions: [Suggestion],
        locale: Locale = .current,
        style: Style = .standard,
        separatorView: @escaping SeparatorViewBuilder,
        suggestionAction: @escaping SuggestionAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.style = style
        self.suggestionAction = suggestionAction
        self.itemView = Self.standardItemView
        self.separatorView = separatorView
    }
    
    /**
     The standard function to use to build suggestion items.
     */
    static func standardItemView(
        suggestion: Suggestion,
        style: Style,
        locale: Locale
    ) -> Autocomplete.ToolbarItem {
        .init(
            suggestion: suggestion,
            locale: locale,
            style: style.item
        )
    }
}

public extension Autocomplete.Toolbar where SeparatorView == Separator {
    
    /**
     Create an autocomplete toolbar with standard separators.

     - Parameters:
       - suggestions: The list of suggestions to display.
       - locale: The locale to use, by default `.current`.
       - style: The style to apply, by default `.standard`.
       - itemView: The function to use to build a view for each suggestion.
       - suggestionAction: The action to use when tapping a suggestion. By default, the static `standardReplacementAction` will be used.
     */
    init(
        suggestions: [Suggestion],
        locale: Locale = .current,
        style: Style = .standard,
        itemView: @escaping ItemViewBuilder,
        suggestionAction: @escaping SuggestionAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.style = style
        self.suggestionAction = suggestionAction
        self.itemView = itemView
        self.separatorView = Self.standardSeparatorView
    }
    
    /**
     The standard function to use to build separator views.
     */
    static func standardSeparatorView(
        suggestion: Suggestion,
        style: Style
    ) -> Separator {
        .init(style: style.separator)
    }
}

public extension Autocomplete.Toolbar where ItemView == Item, SeparatorView == Separator {
    
    /**
     Create an autocomplete toolbar with standard item views
     and separator views.

     - Parameters:
       - suggestions: The list of suggestions to display.
       - locale: The locale to use, by default `.current`.
       - style: The style to apply, by default `.standard`.
       - style: The style to use in the toolbar, by default `.standard`.
       - action: The action to use when tapping a suggestion.
     */
    init(
        suggestions: [Suggestion],
        locale: Locale = .current,
        style: Style = .standard,
        suggestionAction: @escaping SuggestionAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.style = style
        self.suggestionAction = suggestionAction
        self.itemView = Self.standardItemView
        self.separatorView = Self.standardSeparatorView
    }
}

private extension Autocomplete.Toolbar {
    
    func itemButton(for suggestion: Suggestion) -> some View {
        Button(action: { suggestionAction(suggestion) }, label: {
            itemView(suggestion, style, locale)
                .padding(.horizontal, 4)
                .padding(.vertical, 10)
                .background(suggestion.isAutocorrect ? style.autocorrectBackground.color : Color.clearInteractable)
                .cornerRadius(style.autocorrectBackground.cornerRadius)
        }).buttonStyle(.plain)
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

struct Autocomplete_Toolbar_Previews: PreviewProvider {
    
    static let additional = [
        Autocomplete.Suggestion(text: "", title: "Foo", subtitle: "Recommended")
    ]
    
    static var previews: some View {
        return VStack {
            Autocomplete.Toolbar(
                suggestions: previewSuggestions,
                locale: KeyboardLocale.english.locale,
                style: .standard,
                suggestionAction: { _ in }).previewBar()
            Autocomplete.Toolbar(
                suggestions: previewSuggestions + additional,
                locale: KeyboardLocale.spanish.locale,
                style: .standard,
                suggestionAction: { _ in }).previewBar()
            Autocomplete.Toolbar(
                suggestions: previewSuggestions + additional,
                locale: KeyboardLocale.spanish.locale,
                style: .preview1,
                suggestionAction: { _ in }).previewBar()
            Autocomplete.Toolbar(
                suggestions: previewSuggestions + additional,
                locale: KeyboardLocale.spanish.locale,
                style: .preview2,
                suggestionAction: { _ in }).previewBar()
            Autocomplete.Toolbar(
                suggestions: previewSuggestions,
                locale: KeyboardLocale.swedish.locale,
                style: .standard,
                itemView: previewItem,
                suggestionAction: { _ in }).previewBar()
        }
        .padding()
    }
    
    static func previewItem(for suggestion: Autocomplete.Suggestion, style: KeyboardStyle.AutocompleteToolbar, locale: Locale) -> some View {
        HStack {
            Spacer()
            VStack(spacing: 4) {
                Autocomplete.ToolbarItemTitle(
                    suggestion: suggestion,
                    locale: KeyboardLocale.swedish.locale,
                    style: style.item
                )
                if let subtitle = suggestion.subtitle {
                    Text(subtitle).font(.footnote)
                }
            }
            Spacer()
        }
    }
    
    static let previewSuggestions: [Autocomplete.Suggestion] = [
        .init(text: "Baz", isUnknown: true),
        .init(text: "Bar", isAutocorrect: true),
        .init(text: "", title: "Foo", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
