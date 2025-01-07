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
        ///   - suggestionAction: The action to run when tapping a suggestion.
        public init(
            suggestions: [Autocomplete.Suggestion],
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
        ///   - itemView: The suggestion view builder to use.
        ///   - separatorView: The separator view builder to use.
        ///   - suggestionAction: The action to run when tapping a suggestion.
        public init(
            suggestions: [Autocomplete.Suggestion],
            itemView: @escaping ItemViewBuilder,
            separatorView: @escaping SeparatorViewBuilder,
            suggestionAction: @escaping SuggestionAction
        ) {
            self.suggestions = suggestions
            self.items = suggestions.map { BarItem($0) }
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

        private let items: [BarItem]
        private let suggestions: [Suggestion]
        private let suggestionAction: SuggestionAction
        private let itemView: ItemViewBuilder
        private let separatorView: SeparatorViewBuilder

        public typealias Style = Autocomplete.ToolbarStyle

        @Environment(\.autocompleteToolbarStyle)
        private var style

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
                        separatorView(for: item.suggestion)
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
    struct ToolbarStyle: Codable, Equatable {

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

    func itemButton(for suggestion: Suggestion) -> some View {
        Button {
            suggestionAction(suggestion)
        } label: {
            itemView(for: suggestion)
        }
        .buttonStyle(.plain)
    }

    func itemView(for suggestion: Suggestion) -> some View {
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
            subtitle: "Recommended"
        )
    ]
    
    let suggestions: [Autocomplete.Suggestion] = [
        .init(text: "Baz", type: .unknown),
        .init(text: "Bar", type: .autocorrect),
        .init(text: "", title: "Foo", subtitle: "Recommended")]
    
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
                itemView: { $0.view },
                separatorView: { $0.view },
                suggestionAction: { _ in }
            )

            Autocomplete.Toolbar(
                suggestions: suggestions + additional,
                itemView: { $0.view },
                separatorView: { $0.view },
                suggestionAction: { _ in }
            )
            .autocompleteToolbarStyle(.init(
                height: 100,
                item: .init(titleColor: .red),
                autocorrectItem: .init(backgroundColor: .red),
                separator: .init(color: .purple, width: 20)
            ))
        }
    }
    .padding(5)
    .background(Color.keyboardBackground)
}
