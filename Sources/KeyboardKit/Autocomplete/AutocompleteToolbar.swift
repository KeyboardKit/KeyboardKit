//
//  AutocompleteToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI

/**
 This view is a horizontal row with autocomplete buttons and
 separator lines between the buttons.
 
 You can customize the item and separator views by providing
 custom `itemView` and/or `separatorView` functions. You can
 also customize the tap `action` of a suggestion.
 
 Note that the views that are returned by `itemView` will be
 nested in a button that triggers the `action`. Therefore, a
 custom `itemView` should only return views, not buttons.
 */
public struct AutocompleteToolbar<ItemView: View, SeparatorView: View>: View {
    
    /**
     Create an autocomplete toolbar.

     - Parameters:
       - suggestions: The list of suggestions to display.
       - locale: The locale to use in the toolbar.
       - style: The style to use in the toolbar, by default ``AutocompleteToolbarStyle/standard``.
       - itemView: The function to use to build a view for each suggestion.
       - separatorView: The function to use to build a view for each separator.
       - action: The action to use when tapping a suggestion, by default ``AutocompleteToolbar/standardAction(for:)``.
     */
    public init(
        suggestions: [AutocompleteSuggestion],
        locale: Locale,
        style: AutocompleteToolbarStyle = .standard,
        itemView: @escaping ItemViewBuilder,
        separatorView: @escaping SeparatorViewBuilder,
        action: @escaping ReplacementAction = standardAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.itemView = itemView
        self.locale = locale
        self.style = style
        self.separatorView = separatorView
        self.action = action
    }
    
    private let items: [BarItem]
    private let locale: Locale
    private let style: AutocompleteToolbarStyle
    private let action: ReplacementAction
    private let itemView: ItemViewBuilder
    private let separatorView: SeparatorViewBuilder
    
    
    /**
     This typealias represents the action block that is used
     to create autocomplete item views.
     */
    public typealias ItemViewBuilder = (AutocompleteSuggestion, AutocompleteToolbarStyle, Locale) -> ItemView
    
    /**
     This typealias represents the action block that is used
     to create autocomplete item separator views.
     */
    public typealias SeparatorViewBuilder = (AutocompleteSuggestion, AutocompleteToolbarStyle) -> SeparatorView
    
    
    /**
     This internal struct is used to encapsulate item data.
     */
    struct BarItem: Identifiable {
        
        init(_ suggestion: AutocompleteSuggestion) {
            self.suggestion = suggestion
        }
        
        public let id = UUID()
        public let suggestion: AutocompleteSuggestion
    }

    /**
     This typealias represents the action block that is used
     to trigger a text replacement when tapping a suggestion.
     */
    public typealias ReplacementAction = (AutocompleteSuggestion) -> Void

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

public extension AutocompleteToolbar where ItemView == AutocompleteToolbarItem {
    
    /**
     Create an autocomplete toolbar with standard item views.

     - Parameters:
       - suggestions: The list of suggestions to display.
       - locale: The locale to use in the toolbar.
       - style: The style to use in the toolbar, by default `.standard`.
       - separatorView: The function to use to build a view for each separator.
       - action: The action to use when tapping a suggestion. By default, the static `standardReplacementAction` will be used.
     */
    init(
        suggestions: [AutocompleteSuggestion],
        locale: Locale,
        style: AutocompleteToolbarStyle = .standard,
        separatorView: @escaping SeparatorViewBuilder,
        action: @escaping ReplacementAction = standardAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.style = style
        self.action = action
        self.itemView = Self.standardItemView
        self.separatorView = separatorView
    }
    
    /**
     The standard function to use to build suggestion items.
     */
    static func standardItemView(
        suggestion: AutocompleteSuggestion,
        style: AutocompleteToolbarStyle,
        locale: Locale
    ) -> AutocompleteToolbarItem {
        AutocompleteToolbarItem(
            suggestion: suggestion,
            style: style.item,
            locale: locale)
    }
}

public extension AutocompleteToolbar where SeparatorView == AutocompleteToolbarSeparator {
    
    /**
     Create an autocomplete toolbar with standard separators.

     - Parameters:
       - suggestions: The list of suggestions to display.
       - locale: The locale to use in the toolbar.
       - style: The style to use in the toolbar, by default `.standard`.
       - itemView: The function to use to build a view for each suggestion.
       - action: The action to use when tapping a suggestion. By default, the static `standardReplacementAction` will be used.
     */
    init(
        suggestions: [AutocompleteSuggestion],
        locale: Locale,
        style: AutocompleteToolbarStyle = .standard,
        itemView: @escaping ItemViewBuilder,
        action: @escaping ReplacementAction = standardAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.style = style
        self.action = action
        self.itemView = itemView
        self.separatorView = Self.standardSeparatorView
    }
    
    /**
     The standard function to use to build separator views.
     */
    static func standardSeparatorView(
        suggestion: AutocompleteSuggestion,
        style: AutocompleteToolbarStyle) -> AutocompleteToolbarSeparator {
        AutocompleteToolbarSeparator(
            style: style.separator)
    }
}

public extension AutocompleteToolbar where ItemView == AutocompleteToolbarItem, SeparatorView == AutocompleteToolbarSeparator {
    
    /**
     Create an autocomplete toolbar with standard item views
     and separator views.

     - Parameters:
       - suggestions: The list of suggestions to display.
       - locale: The locale to use in the toolbar.
       - style: The style to use in the toolbar, by default `.standard`.
       - action: The action to use when tapping a suggestion. By default, the static `standardReplacementAction` will be used.
     */
    init(
        suggestions: [AutocompleteSuggestion],
        locale: Locale,
        style: AutocompleteToolbarStyle = .standard,
        action: @escaping ReplacementAction = standardAction
    ) {
        self.items = suggestions.map { BarItem($0) }
        self.locale = locale
        self.style = style
        self.action = action
        self.itemView = Self.standardItemView
        self.separatorView = Self.standardSeparatorView
    }
}

public extension AutocompleteToolbar {
    
    /**
     This is the default action that will be used to trigger
     a text replacement when a `suggestion` is tapped.
     */
    static func standardAction(
        for suggestion: AutocompleteSuggestion
    ) {
        let controller = KeyboardInputViewController.shared
        let proxy = controller.textDocumentProxy
        let actionHandler = controller.keyboardActionHandler
        proxy.insertAutocompleteSuggestion(suggestion)
        actionHandler.handle(.tap, on: .character(""))
    }
}

private extension AutocompleteToolbar {
    
    func itemButton(for suggestion: AutocompleteSuggestion) -> some View {
        Button(action: { action(suggestion) }, label: {
            itemView(suggestion, style, locale)
                .padding(.horizontal, 4)
                .padding(.vertical, 10)
                .background(suggestion.isAutocomplete ? style.autocompleteBackground.color : Color.clearInteractable)
                .cornerRadius(style.autocompleteBackground.cornerRadius)
        })
    }
}

private extension AutocompleteToolbar {
    
    func isLast(_ item: BarItem) -> Bool {
        item.id == items.last?.id
    }
    
    func isNextItemAutocomplete(for item: BarItem) -> Bool {
        guard let index = (items.firstIndex { $0.id == item.id }) else { return false }
        let nextIndex = items.index(after: index)
        guard nextIndex < items.count else { return false }
        return items[nextIndex].suggestion.isAutocomplete
    }
    
    func useSeparator(for item: BarItem) -> Bool {
        if item.suggestion.isAutocomplete { return false }
        if isLast(item) { return false }
        return !isNextItemAutocomplete(for: item)
    }
}

struct AutocompleteToolbar_Previews: PreviewProvider {
    
    static let additional = [
        StandardAutocompleteSuggestion(text: "", title: "Foo", subtitle: "Recommended")
    ]
    
    static var previews: some View {
        return VStack {
            AutocompleteToolbar(
                suggestions: previewSuggestions,
                locale: KeyboardLocale.english.locale,
                style: .standard,
                action: { _ in }).previewBar()
            AutocompleteToolbar(
                suggestions: previewSuggestions + additional,
                locale: KeyboardLocale.spanish.locale,
                style: .standard,
                action: { _ in }).previewBar()
            AutocompleteToolbar(
                suggestions: previewSuggestions + additional,
                locale: KeyboardLocale.spanish.locale,
                style: .preview1,
                action: { _ in }).previewBar()
            AutocompleteToolbar(
                suggestions: previewSuggestions + additional,
                locale: KeyboardLocale.spanish.locale,
                style: .preview2,
                action: { _ in }).previewBar()
            AutocompleteToolbar(
                suggestions: previewSuggestions,
                locale: KeyboardLocale.swedish.locale,
                style: .standard,
                itemView: previewItem,
                action: { _ in }).previewBar()
        }
        .padding()
    }
    
    static func previewItem(for suggestion: AutocompleteSuggestion, style: AutocompleteToolbarStyle, locale: Locale) -> some View {
        HStack {
            Spacer()
            VStack(spacing: 4) {
                AutocompleteToolbarItemTitle(
                    suggestion: suggestion,
                    style: style.item,
                    locale: KeyboardLocale.swedish.locale)
                    .font(Font.body.bold())
                if let subtitle = suggestion.subtitle {
                    Text(subtitle).font(.footnote)
                }
            }
            Spacer()
        }
    }
    
    static let previewSuggestions: [AutocompleteSuggestion] = [
        StandardAutocompleteSuggestion(text: "Baz", isUnknown: true),
        StandardAutocompleteSuggestion(text: "Bar", isAutocomplete: true),
        StandardAutocompleteSuggestion(text: "", title: "Foo", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
#endif
