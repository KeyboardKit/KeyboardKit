//
//  AutocompleteToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /// This toolbar can be added above the keyboard to show
    /// autocomplete suggestions as the user types.
    ///
    /// You can style this component with the style modifier
    /// ``autocompleteToolbarStyle(_:)``.
    struct Toolbar<ItemView: View, SeparatorView: View>: View {

        /// Create a toolbar with standard views.
        ///
        /// - Parameters:
        ///   - suggestions: The suggestions to display.
        ///   - emojiSuggestions: The emoji suggestions to display, if any.
        ///   - suggestionAction: The action to run when tapping a suggestion.
        public init(
            suggestions: [Autocomplete.Suggestion],
            emojiSuggestions: [Autocomplete.Suggestion] = [],
            suggestionAction: @escaping SuggestionAction
        ) where ItemView == StandardItem, SeparatorView == StandardSeparator {
            self.init(
                suggestions: suggestions,
                itemView: { $0.view },
                separatorView: { $0.view },
                suggestionAction: suggestionAction
            )
        }

        /// Create a toolbar with custom views.
        ///
        /// Just return `{ $0.view }` in any view builder to
        /// return the standard view.
        ///
        /// - Parameters:
        ///   - suggestions: The suggestions to display.
        ///   - emojiSuggestions: The emoji suggestions to display, if any.
        ///   - itemView: The suggestion view builder to use.
        ///   - separatorView: The separator view builder to use.
        ///   - suggestionAction: The action to run when tapping a suggestion.
        public init(
            suggestions: [Autocomplete.Suggestion],
            emojiSuggestions emojis: [Autocomplete.Suggestion] = [],
            itemView: @escaping ItemViewBuilder,
            separatorView: @escaping SeparatorViewBuilder,
            suggestionAction: @escaping SuggestionAction
        ) {
            let drop = emojis.isEmpty ? 0 : 1
            let useAllEmojis = suggestions.count - drop < 3
            self.suggestions = suggestions.dropLast(drop)
            self.emojiSuggestions = useAllEmojis ? emojis : Array(emojis.prefix(1))
            self.itemView = itemView
            self.separatorView = separatorView
            self.suggestionAction = suggestionAction
        }

        public typealias Item = Autocomplete.ToolbarItem
        public typealias ItemViewBuilder = (ItemParams) -> ItemView
        public typealias Separator = Autocomplete.ToolbarSeparator
        public typealias SeparatorViewBuilder = (SeparatorParams) -> SeparatorView
        public typealias Suggestion = Autocomplete.Suggestion
        public typealias SuggestionAction = (Suggestion) -> Void

        public struct ItemParams {
            let suggestion: Suggestion
            let style: Style
            let view: StandardItem
        }

        public struct SeparatorParams {
            let suggestion: Suggestion
            let style: Style
            let view: StandardSeparator
        }

        public typealias StandardItem = Autocomplete.ToolbarItem
        public typealias StandardSeparator = Autocomplete.ToolbarSeparator

        private let suggestions: [Suggestion]
        private let emojiSuggestions: [Suggestion]
        private let suggestionAction: SuggestionAction
        private let itemView: ItemViewBuilder
        private let separatorView: SeparatorViewBuilder

        public typealias Style = Autocomplete.ToolbarStyle

        @Environment(\.autocompleteToolbarStyle)
        private var style
        
        public var body: some View {
            HStack {
                ForEach(Array(suggestions.enumerated()), id: \.offset) { item in
                    toolbarItem(for: item.element, at: item.offset)
                }
                HStack {
                    ForEach(Array(emojiSuggestions.enumerated()), id: \.offset) { item in
                        toolbarItemButton(for: item.element)
                    }
                }
            }
            .padding(style.padding)
            .frame(height: style.height)
        }
    }

    /// This style can be used to modify the visual style of
    /// the ``Autocomplete/Toolbar`` component.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/autocompleteToolbarStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ToolbarStyle: Codable, Equatable, Sendable {

        /// Create a custom autocomplete toolbar style.
        ///
        /// - Parameters:
        ///   - height: An optional, fixed height, by default `48`.
        ///   - padding: An optional, fixed edge padding, by default `4`.
        ///   - item: The style to apply to the toolbar items, by default `.standard`.
        ///   - separator: The style to apply to autocorrect items `.standardAutocorrect`.
        ///   - autocorrectItem: The autocorrect background style, by default `.standard`.
        public init(
            height: CGFloat = 48,
            padding: CGFloat = 4,
            item: Autocomplete.ToolbarItemStyle = .standard,
            autocorrectItem: Autocomplete.ToolbarItemStyle = .standardAutocorrect,
            separator: Autocomplete.ToolbarSeparatorStyle = .standard
        ) {
            self.height = height
            self.padding = padding
            self.item = item
            self.autocorrectItem = autocorrectItem
            self.separator = separator
        }

        /// An optional, fixed toolbar height.
        public var height: CGFloat?

        /// The toolbar's edge padding.
        public var padding: CGFloat

        /// The style to apply to the toolbar items.
        public var item: Autocomplete.ToolbarItemStyle

        /// The style to apply to autocorrect toolbar items.
        public var autocorrectItem: Autocomplete.ToolbarItemStyle

        /// The style to apply to toolbar separators.
        public var separator: Autocomplete.ToolbarSeparatorStyle
    }
}

private extension Autocomplete.Toolbar {
    
    @ViewBuilder
    func toolbarItem(for suggestion: Suggestion, at index: Int) -> some View {
        toolbarItemButton(for: suggestion)
        if useSeparator(for: suggestion, at: index) {
            separatorView(for: suggestion)
        }
    }

    func toolbarItemButton(for suggestion: Suggestion) -> some View {
        Button {
            suggestionAction(suggestion)
        } label: {
            toolbarItemView(for: suggestion)
        }
        .buttonStyle(.plain)
    }

    func toolbarItemView(for suggestion: Suggestion) -> some View {
        itemView(.init(
            suggestion: suggestion,
            style: style,
            view: StandardItem(suggestion: suggestion)
        ))
        .autocompleteToolbarItemStyle(
            suggestion.isAutocorrect ? style.autocorrectItem : style.item
        )
    }

    func separatorView(for suggestion: Suggestion) -> some View {
        separatorView(.init(
            suggestion: suggestion,
            style: style,
            view: StandardSeparator()
        ))
        .autocompleteToolbarSeparatorStyle(style.separator)
    }
}

private extension Autocomplete.Toolbar {
    
    func useSeparator(for suggestion: Suggestion, at index: Int) -> Bool {
        if suggestion.isAutocorrect { return false }
        let isLast = index >= suggestions.count - 1
        if isLast { return !emojiSuggestions.isEmpty }
        return !suggestions[index+1].isAutocorrect
    }
}

public extension Autocomplete.ToolbarStyle {

    /// The standard autocomplete toolbar style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply a ``Autocomplete/ToolbarStyle``.
    func autocompleteToolbarStyle(
        _ style: Autocomplete.ToolbarStyle
    ) -> some View {
        self.environment(\.autocompleteToolbarStyle, style)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Autocomplete/ToolbarStyle``.
    @Entry var autocompleteToolbarStyle = Autocomplete
        .ToolbarStyle.standard
}

#Preview {
    
    let additional = [
        Autocomplete.Suggestion(
            text: "",
            title: "Foo",
            subtitle: "Extra"
        )
    ]
    
    let suggestions: [Autocomplete.Suggestion] = [
        .init(text: "Foo", type: .unknown),
        .init(text: "Bar", type: .autocorrect),
        .init(text: "", title: "Baz" /*, subtitle: "Recommended"*/)]
    
    let emojis: [Autocomplete.Suggestion] = [
        .init(text: "😊", type: .emoji),
        .init(text: "💡", type: .emoji),
        .init(text: "👍", type: .emoji)]
    
    return VStack {
        Group {
            Autocomplete.Toolbar(
                suggestions: suggestions,
                itemView: { $0.view },
                separatorView: { $0.view },
                suggestionAction: { _ in }
            )
            Autocomplete.Toolbar(
                suggestions: Array(suggestions.prefix(2)),
                itemView: { $0.view },
                separatorView: { $0.view },
                suggestionAction: { _ in }
            )
            Autocomplete.Toolbar(
                suggestions: suggestions + additional,
                emojiSuggestions: emojis,
                itemView: { $0.view },
                separatorView: { $0.view },
                suggestionAction: { _ in }
            )
            Autocomplete.Toolbar(
                suggestions: suggestions,
                emojiSuggestions: emojis,
                itemView: { $0.view },
                separatorView: { $0.view },
                suggestionAction: { _ in }
            )
            Autocomplete.Toolbar(
                suggestions: suggestions + additional,
                itemView: { $0.view },
                separatorView: { $0.view.clipShape(.capsule) },
                suggestionAction: { _ in }
            )
            .autocompleteToolbarStyle(.init(
                item: .init(titleColor: .blue),
                autocorrectItem: .init(
                    titleColor: .yellow,
                    backgroundColor: .blue
                ),
                separator: .init(color: .gray, width: 5)
            ))
        }
        .background(Color.keyboardBackground)
        .clipShape(.rect(cornerRadius: 10))
    }
    .padding(5)
}
