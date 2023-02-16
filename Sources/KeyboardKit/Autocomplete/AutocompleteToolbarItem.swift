//
//  AutocompleteToolbarItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
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
       - suggestion: The suggestion to display in the view.
       - locale: The locale to use to resolve quotation.
       - style: The style to apply to the item, by default ``AutocompleteToolbarItemStyle/standard``.
     */
    public init(
        suggestion: AutocompleteSuggestion,
        locale: Locale,
        style: AutocompleteToolbarItemStyle = .standard
    ) {
        self.suggestion = suggestion
        self.locale = locale
        self.style = style
    }
    
    private let suggestion: AutocompleteSuggestion
    private let locale: Locale
    private let style: AutocompleteToolbarItemStyle
        
    public var body: some View {
        VStack(spacing: 0) {
            text
            if let text = suggestion.subtitle {
                subtitle(for: text)
            }
        }
    }
}

private extension AutocompleteToolbarItem {
 
    var text: some View {
        AutocompleteToolbarItemTitle(
            suggestion: suggestion,
            locale: locale,
            style: style
        )
    }
    
    func subtitle(for text: String) -> some View {
        AutocompleteToolbarItemSubtitle(
            text: text,
            style: style
        )
    }
}

struct AutocompleteToolbarItem_Previews: PreviewProvider {
    
    static var previews: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                ForEach(KeyboardLocale.allCases) {
                    preview(for: $0.locale)
                }
            }.padding()
        }
    }
    
    static func preview(for locale: Locale) -> some View {
        VStack(spacing: 5) {
            Text(locale.identifier).font(.headline)
            AutocompleteToolbar(
                suggestions: previewSuggestions,
                locale: locale,
                style: .standard,
                suggestionAction: { _ in}
            ).previewBar()
        }
    }
    
    static let previewSuggestions: [AutocompleteSuggestion] = [
        AutocompleteSuggestion(text: "Foo", isUnknown: true),
        AutocompleteSuggestion(text: "Bar", isAutocomplete: true),
        AutocompleteSuggestion(text: "", title: "Baz", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.padding(5)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
