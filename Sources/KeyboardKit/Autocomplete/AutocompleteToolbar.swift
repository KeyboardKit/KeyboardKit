//
//  AutocompleteToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view creates a horizontal row with autocomplete button
 views and separators.
 
 You can customize the button and the separator by injecting
 a custom `buttonBuilder` and/or `separatorBuilder`. You can
 also customize the `replacementAction`.
 
 Note that the views that are returned by the `buttonBuilder`
 will be nested in a button that triggers `replacementAction`.
 You should therefore only return views and not buttons when
 you provide a custom button builder.
 */
public struct AutocompleteToolbar: View {
    
    /**
     Create a new autocomplete toolbar.
     
     - Parameters:
     - buttonBuilder: An optional, custom button builder. By default, the static `standardButton` will be used.
     - separatorBuilder: An optional, custom separator builder. By default, the static `standardSeparator` will be used.
     - replacementAction: An optional, custom replacement action. By default, the static `standardReplacementAction` will be used.
     */
    public init(
        suggestions: [AutocompleteSuggestion],
        buttonBuilder: @escaping ButtonBuilder = Self.standardButton,
        separatorBuilder: @escaping SeparatorBuilder = Self.standardSeparator,
        replacementAction: @escaping ReplacementAction = Self.standardReplacementAction) {
        self.items = suggestions.map { BarItem($0) }
        self.buttonBuilder = buttonBuilder
        self.separatorBuilder = separatorBuilder
        self.replacementAction = replacementAction
    }
    
    private let buttonBuilder: ButtonBuilder
    private let items: [BarItem]
    private let replacementAction: ReplacementAction
    private let separatorBuilder: SeparatorBuilder
    
    struct BarItem: Identifiable {
        init(_ suggestion: AutocompleteSuggestion) {
            self.suggestion = suggestion
        }
        public let id = UUID()
        public let suggestion: AutocompleteSuggestion
    }
    
    public typealias ButtonBuilder = (AutocompleteSuggestion) -> AnyView
    public typealias ReplacementAction = (AutocompleteSuggestion) -> Void
    public typealias SeparatorBuilder = (AutocompleteSuggestion) -> AnyView
    
    public var body: some View {
        HStack {
            ForEach(items) {
                self.view(for: $0)
            }
        }
    }
}

public extension AutocompleteToolbar {
    
    /**
     This is the standard function that's used by default to
     build a button for an autocomplete suggestion.
     */
    static func standardButton(for suggestion: AutocompleteSuggestion) -> AnyView {
        AnyView(
            Text(suggestion.title)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
        )
    }
    
    /**
     This is the standard function that's used by default to
     build a text replacement for an autocomplete suggestion.
     */
    static func standardReplacement(for suggestion: AutocompleteSuggestion) -> String {
        let space = " "
        let replacement = suggestion.replacement
        let proxy = KeyboardInputViewController.shared.textDocumentProxy
        let endsWithSpace = replacement.hasSuffix(space)
        let hasNextSpace = proxy.documentContextAfterInput?.starts(with: space) ?? false
        let insertSpace = endsWithSpace || hasNextSpace
        return insertSpace ? replacement : replacement + space
    }
    
    /**
     This is the standard function that's used by default to
     replace the current word in the proxy with a suggestion.
     */
    static func standardReplacementAction(for suggestion: AutocompleteSuggestion) {
        let proxy = KeyboardInputViewController.shared.textDocumentProxy
        let actionHandler = KeyboardInputViewController.shared.keyboardActionHandler
        let replacement = Self.standardReplacement(for: suggestion)
        proxy.replaceCurrentWord(with: replacement)
        actionHandler.handle(.tap, on: .character(""))
    }
    
    /**
     This is the standard button separator that will be used
     if no custom separator is provided in init.
     */
    static func standardSeparator(for suggestion: AutocompleteSuggestion) -> AnyView {
        AnyView(Color.secondary
                    .opacity(0.5)
                    .frame(width: 1)
                    .padding(.vertical, 8))
    }
}

private extension AutocompleteToolbar {
    
    func isLast(_ item: BarItem) -> Bool {
        item.id == items.last?.id
    }
    
    func view(for item: BarItem) -> some View {
        let action = { self.replacementAction(item.suggestion) }
        return Group {
            Button(action: action) {
                buttonBuilder(item.suggestion)
            }
            .background(Color.clearInteractable)
            .buttonStyle(PlainButtonStyle())
            if !isLast(item) {
                separatorBuilder(item.suggestion)
            }
        }
    }
}

struct AutocompleteToolbar_Previews: PreviewProvider {
    
    static var previews: some View {
        KeyboardInputViewController.shared = .preview
        
        return VStack {
            AutocompleteToolbar(suggestions: suggestions).previewBar()
            AutocompleteToolbar(suggestions: suggestions, buttonBuilder: preview).previewBar()
        }
    }
    
    static let suggestions: [AutocompleteSuggestion] = [
        StandardAutocompleteSuggestion(text: "", title: "Foo", subtitle: "Reccomended"),
        StandardAutocompleteSuggestion("Bar"),
        StandardAutocompleteSuggestion("Baz")]
    
    static func preview(for suggestion: AutocompleteSuggestion) -> AnyView {
        AnyView(
            HStack {
                Spacer()
                VStack(spacing: 10) {
                    Text(suggestion.title).bold()
                    if let subtitle = suggestion.subtitle {
                        Text(subtitle).font(.footnote)
                    }
                }
                Spacer()
            }
        )
    }
}

private extension View {
    
    func previewBar() -> some View {
        self.frame(height: 80)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .padding()
    }
}
