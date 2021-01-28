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
 a custom `buttonBuilder` and/or `separatorBuilder`. When so,
 make sure to just return the button view without any button
 behavior, since the view will be wrapped in a button.
 */
public struct AutocompleteToolbar: View {
    
    /**
     Create a new autocomplete toolbar.
     
     - Parameters:
        - buttonBuilder: An optional, custom button builder. If you don't provide one, the static `standardButton` will be used.
        - separatorBuilder: An optional, custom separator builder. If you don't provide one, the static `standardSeparator` will be used.
        - replacementAction: An optional, custom replacement action. If you don't provide one, the static `standardReplacementAction` will be used.
     */
    public init(
        buttonBuilder: @escaping ButtonBuilder = Self.standardButton,
        separatorBuilder: @escaping SeparatorBuilder = Self.standardSeparator,
        replacementAction: @escaping ReplacementAction = Self.standardReplacementAction) {
        self.buttonBuilder = buttonBuilder
        self.separatorBuilder = separatorBuilder
        self.replacementAction = replacementAction
    }
    
    private let buttonBuilder: ButtonBuilder
    private let replacementAction: ReplacementAction
    private let separatorBuilder: SeparatorBuilder
    private var proxy: UITextDocumentProxy { keyboardContext.textDocumentProxy }
    
    public typealias ButtonBuilder = (AutocompleteSuggestion) -> AnyView
    public typealias ReplacementAction = (AutocompleteSuggestion, KeyboardContext) -> Void
    public typealias ReplacementProvider = (AutocompleteSuggestion, KeyboardContext) -> String
    public typealias SeparatorBuilder = (AutocompleteSuggestion) -> AnyView
    public typealias Word = String
    
    @EnvironmentObject private var context: ObservableAutocompleteContext
    @EnvironmentObject private var keyboardContext: ObservableKeyboardContext
    
    public var body: some View {
        HStack {
            ForEach(context.suggestions, id: \.title) {
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
        AnyView(Text(suggestion.title)
            .lineLimit(1)
            .frame(maxWidth: .infinity))
    }
    
    /**
     This is the standard function that's used by default to
     build a text replacement for an autocomplete suggestion.
     */
    static func standardReplacement(for suggestion: AutocompleteSuggestion, context: KeyboardContext) -> String {
        let space = " "
        let proxy = context.textDocumentProxy
        let replacement = suggestion.replacement
        let endsWithSpace = replacement.hasSuffix(space)
        let hasNextSpace = proxy.documentContextAfterInput?.starts(with: space) ?? false
        let insertSpace = endsWithSpace || hasNextSpace
        return insertSpace ? replacement : replacement + space
    }
    
    /**
     This is the standard function that's used by default to
     replace the current word in the proxy with a suggestion.
     */
    static func standardReplacementAction(for suggestion: AutocompleteSuggestion, context: KeyboardContext) {
        let proxy = context.textDocumentProxy
        let replacement = Self.standardReplacement(for: suggestion, context: context)
        proxy.replaceCurrentWord(with: replacement)
        context.actionHandler.handle(.tap, on: .character(""))
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
    
    func isLast(_ suggestion: AutocompleteSuggestion) -> Bool {
        let replacement = suggestion.replacement
        let lastReplacement = context.suggestions.last?.replacement
        return replacement == lastReplacement
    }
    
    func view(for suggestion: AutocompleteSuggestion) -> some View {
        let action = { self.replacementAction(suggestion, keyboardContext) }
        return Group {
            Button(action: action) {
                buttonBuilder(suggestion)
            }
            .background(Color.clearInteractable)
            .buttonStyle(PlainButtonStyle())
            if !isLast(suggestion) {
                separatorBuilder(suggestion)
            }
        }
    }
}

struct AutocompleteToolbar_Previews: PreviewProvider {
    static var previews: some View {
        AutocompleteToolbar()
    }
}
