//
//  AutocompleteToolbarItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view replicates the standard autocomplete toolbar item
 that is used in native iOS keyboards.
 
 The item uses an `AutocompleteToolbarItemText` for the text
 view and `AutocompleteToolbarItemBackground` for background.
 These views can be used individually to create custom items.
 */
public struct AutocompleteToolbarItem: View {
    
    /**
     Create an autocomplete toolbar item.
     
     - Parameters:
       - suggestions: The suggestion to display in the view.
     */
    public init(suggestion: AutocompleteSuggestion) {
        self.suggestion = suggestion
    }
    
    private let suggestion: AutocompleteSuggestion
    
    @EnvironmentObject private var context: KeyboardContext
    
    public var body: some View {
        AutocompleteToolbarItemText(suggestion: suggestion)
            .autocompleteToolbarItemBackground(for: suggestion)
    }
}

struct AutocompleteToolbarItem_Previews: PreviewProvider {
    
    static var previews: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                ForEach(KeyboardLocale.allCases) {
                    preview(for: $0)
                }
            }.padding()
        }
    }
    
    static func preview(for locale: KeyboardLocale) -> some View {
        VStack(spacing: 5) {
            Text(locale.localeIdentifier).font(.headline)
            AutocompleteToolbar(suggestions: previewSuggestions)
                .previewBar()
                .environmentObject(previewContext(with: locale))
        }
    }
    
    static func previewContext(with locale: KeyboardLocale) -> KeyboardContext {
        let context = KeyboardContext.preview
        context.locale = locale.locale
        return context
    }
    
    static let previewSuggestions: [AutocompleteSuggestion] = [
        StandardAutocompleteSuggestion("Foo", isUnknown: true),
        StandardAutocompleteSuggestion("Bar", isAutocomplete: true),
        StandardAutocompleteSuggestion(text: "", title: "Baz", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.padding(5)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
