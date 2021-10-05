//
//  AutocompleteToolbarItemSubtitle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view replicates the standard autocomplete toolbar item
 subtitle text that is used in native iOS keyboards.
 
 The view will enforce a single line limit and footnote font.
 */
public struct AutocompleteToolbarItemSubtitle: View {
    
    /**
     Create an autocomplete toolbar item subtitle text view.
     
     - Parameters:
       - text: The text to display in the view.
     */
    public init(text: String) {
        self.text = text
    }
    
    private let text: String
        
    public var body: some View {
        Text(text)
            .lineLimit(1)
            .font(.footnote)
    }
}

struct AutocompleteToolbarItemSubtitle_Previews: PreviewProvider {
    
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
                    AutocompleteToolbarItemSubtitle(text: $0.element.subtitle ?? "")
                }
            }.previewBar()
        }
    }
    
    static let previewSuggestions: [AutocompleteSuggestion] = [
        StandardAutocompleteSuggestion(text: "", title: "Baz", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
