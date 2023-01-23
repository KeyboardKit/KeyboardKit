//
//  AutocompleteToolbarItemTitle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view replicates the standard autocomplete toolbar item
 title text that is used in native iOS keyboards.
 
 The view will enforce a single line limit and resize itself
 to share the available horizontal space with other views.
 */
public struct AutocompleteToolbarItemTitle: View {
    
    /**
     Create an autocomplete toolbar item title text view.
     
     - Parameters:
       - suggestions: The suggestion to display in the view.
       - locale: The locale to use to resolve quotation.
       - style: The style to apply to the text, by default ``AutocompleteToolbarItemStyle/standard``.
     */
    public init(
        suggestion: AutocompleteSuggestion,
        locale: Locale,
        style: AutocompleteToolbarItemStyle = .standard
    ) {
        self.suggestion = suggestion
        self.style = style
        self.locale = locale
    }

    private let suggestion: AutocompleteSuggestion
    private let locale: Locale
    private let style: AutocompleteToolbarItemStyle
        
    public var body: some View {
        Text(displayTitle)
            .lineLimit(1)
            .font(style.titleFont)
            .foregroundColor(style.titleColor)
            .frame(maxWidth: .infinity)
    }
}

private extension AutocompleteToolbarItemTitle {
    
    var displayTitle: String {
        if !suggestion.isUnknown { return suggestion.title }
        let beginDelimiter = locale.quotationBeginDelimiter ?? "\""
        let endDelimiter = locale.quotationEndDelimiter ?? "\""
        return "\(beginDelimiter)\(suggestion.title)\(endDelimiter)"
    }
}

struct AutocompleteToolbarItemTitle_Previews: PreviewProvider {
    
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
            HStack {
                ForEach(Array(previewSuggestions.enumerated()), id: \.offset) {
                    AutocompleteToolbarItemTitle(
                        suggestion: $0.element,
                        locale: locale.locale,
                        style: .standard
                    )
                }
            }.previewBar()
        }
    }
    
    static let previewSuggestions: [AutocompleteSuggestion] = [
        AutocompleteSuggestion(text: "Foo", isUnknown: true),
        AutocompleteSuggestion(text: "Bar", isAutocomplete: true),
        AutocompleteSuggestion(text: "", title: "Baz", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
