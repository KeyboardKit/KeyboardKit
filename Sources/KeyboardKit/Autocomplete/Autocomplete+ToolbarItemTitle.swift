//
//  Autocomplete+ToolbarItemTitle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /**
     This view mimics a native autocomplete toolbar title.

     This view enforces a single line limit and a title font,
     but can be styled using the provided `style`.
     */
    struct ToolbarItemTitle: View {
        
        /**
         Create an autocomplete toolbar item title.
         
         - Parameters:
           - suggestions: The suggestion to display title for.
           - locale: The locale to use, by default `.current`.
           - style: The style to apply, by default `.standard`.
         */
        public init(
            suggestion: Autocomplete.Suggestion,
            locale: Locale = .current,
            style: KeyboardStyle.AutocompleteToolbarItem = .standard
        ) {
            self.suggestion = suggestion
            self.style = style
            self.locale = locale
        }
        
        private let suggestion: Autocomplete.Suggestion
        private let locale: Locale
        private let style: KeyboardStyle.AutocompleteToolbarItem
        
        public var body: some View {
            Text(displayTitle)
                .lineLimit(1)
                .font(style.titleFont.font)
                .foregroundColor(style.titleColor)
                .frame(maxWidth: .infinity)
        }
    }
}

private extension Autocomplete.ToolbarItemTitle {
    
    var displayTitle: String {
        if !suggestion.isUnknown { return suggestion.title }
        let beginDelimiter = locale.quotationBeginDelimiter ?? "\""
        let endDelimiter = locale.quotationEndDelimiter ?? "\""
        return "\(beginDelimiter)\(suggestion.title)\(endDelimiter)"
    }
}

struct Autocomplete_ToolbarItemTitle_Previews: PreviewProvider {
    
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
                    Autocomplete.ToolbarItemTitle(
                        suggestion: $0.element,
                        locale: locale.locale,
                        style: .standard
                    )
                }
            }.previewBar()
        }
    }
    
    static let previewSuggestions: [Autocomplete.Suggestion] = [
        .init(text: "Foo", isUnknown: true),
        .init(text: "Bar", isAutocorrect: true),
        .init(text: "", title: "Baz", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
