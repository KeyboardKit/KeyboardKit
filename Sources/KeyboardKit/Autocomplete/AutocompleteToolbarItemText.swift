//
//  AutocompleteToolbarItemText.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view replicates the standard autocomplete toolbar item
 text is used in native iOS keyboards.
 */
public struct AutocompleteToolbarItemText: View {
    
    public init(suggestion: AutocompleteSuggestion) {
        self.suggestion = suggestion
    }
    
    private let suggestion: AutocompleteSuggestion
    
    @EnvironmentObject private var context: KeyboardContext
    
    public var body: some View {
        Text(displayTitle)
            .lineLimit(1)
            .frame(maxWidth: .infinity)
    }
}

private extension AutocompleteToolbarItemText {
    
    var displayTitle: String {
        if !suggestion.isUnknown { return suggestion.title }
        let locale = context.locale
        let beginDelimiter = locale.quotationBeginDelimiter ?? "\""
        let endDelimiter = locale.quotationEndDelimiter ?? "\""
        return "\(beginDelimiter)\(suggestion.title)\(endDelimiter)"
    }
}

struct AutocompleteToolbarItemText_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack(spacing: 20) {
            ForEach(KeyboardLocale.allCases) {
                preview(for: $0)
            }
        }.padding()
    }
    
    static func preview(for locale: KeyboardLocale) -> some View {
        VStack(spacing: 5) {
            Text(locale.localeIdentifier).font(.headline)
            HStack {
                ForEach(Array(previewSuggestions.enumerated()), id: \.offset) {
                    AutocompleteToolbarItemText(suggestion: $0.element)
                }
            }.previewBar()
        }.environmentObject(previewContext(with: locale))
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
        self.frame(height: 50)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
