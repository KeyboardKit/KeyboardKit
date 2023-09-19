//
//  Autocomplete+ToolbarItemSubtitle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /**
     This view mimics a native autocomplete toolbar subtitle.
     
     The view enforces a single line limit and footnote font,
     but can be styled using the provided `style`.
     */
    struct ToolbarItemSubtitle: View {
        
        /**
         Create an autocomplete toolbar item subtitle.
         
         - Parameters:
           - suggestions: The suggestion to display subtitle for.
           - style: The style to apply, by default `.standard`.
         */
        public init(
            suggestion: Autocomplete.Suggestion,
            style: KeyboardStyle.AutocompleteToolbarItem = .standard
        ) {
            self.suggestion = suggestion
            self.style = style
        }
        
        private let suggestion: Autocomplete.Suggestion
        private let style: KeyboardStyle.AutocompleteToolbarItem
        
        public var body: some View {
            if let subtitle = suggestion.subtitle {
                Text(subtitle)
                    .lineLimit(1)
                    .font(style.subtitleFont.font)
                    .foregroundColor(style.subtitleColor)
            }
        }
    }
}

struct Autocomplete_ToolbarItemSubtitle_Previews: PreviewProvider {
    
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
                    previewSubtitle(for: $0.element, style: .standard)
                    previewSubtitle(for: $0.element, style: .preview1)
                    previewSubtitle(for: $0.element, style: .preview2)
                }
            }.previewBar()
        }
    }
    
    static func previewSubtitle(
        for suggestion: Autocomplete.Suggestion,
        style: KeyboardStyle.AutocompleteToolbarItem
    ) -> some View {
        Autocomplete.ToolbarItemSubtitle(
            suggestion: suggestion,
            style: style
        )
    }
    
    static let previewSuggestions: [Autocomplete.Suggestion] = [
        .init(text: "", title: "Baz", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
