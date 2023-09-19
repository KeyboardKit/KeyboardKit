//
//  Autocomplete+ToolbarItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /**
     This view mimics a native autocomplete toolbar item.
     
     It will by default look like a native toolbar item, but
     can be styled using the provided `style`.
     */
    struct ToolbarItem: View {
        
        /**
         Create an autocomplete toolbar item.
         
         - Parameters:
           - suggestion: The suggestion to display in the view.
           - locale: The locale to use, by default `.current`.
           - style: The style to apply, by default `.standard`.
         */
        public init(
            suggestion: Autocomplete.Suggestion,
            locale: Locale = .current,
            style: KeyboardStyle.AutocompleteToolbarItem = .standard
        ) {
            self.suggestion = suggestion
            self.locale = locale
            self.style = style
        }
        
        private let suggestion: Suggestion
        private let locale: Locale
        private let style: KeyboardStyle.AutocompleteToolbarItem
        
        public var body: some View {
            VStack(spacing: 0) {
                text
                subtitle
            }
        }
    }
}

private extension Autocomplete.ToolbarItem {
    
    var text: some View {
        Autocomplete.ToolbarItemTitle(
            suggestion: suggestion,
            locale: locale,
            style: style
        )
    }
    
    var subtitle: some View {
        Autocomplete.ToolbarItemSubtitle(
            suggestion: suggestion,
            style: style
        )
    }
}

struct Autocomplete_ToolbarItem_Previews: PreviewProvider {
    
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
            Autocomplete.Toolbar(
                suggestions: previewSuggestions,
                locale: locale,
                style: .standard,
                suggestionAction: { _ in}
            ).previewBar()
        }
    }
    
    static let previewSuggestions: [Autocomplete.Suggestion] = [
        .init(text: "Foo", isUnknown: true),
        .init(text: "Bar", isAutocorrect: true),
        .init(text: "", title: "Baz", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.padding(5)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
