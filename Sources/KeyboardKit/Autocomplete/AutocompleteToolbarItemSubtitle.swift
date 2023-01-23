//
//  AutocompleteToolbarItemSubtitle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
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
       - style: The style to apply to the text, by default ``AutocompleteToolbarItemStyle/standard``.
     */
    public init(
        text: String,
        style: AutocompleteToolbarItemStyle = .standard
    ) {
        self.text = text
        self.style = style
    }
    
    private let text: String
    private let style: AutocompleteToolbarItemStyle
        
    public var body: some View {
        Text(text)
            .lineLimit(1)
            .font(style.subtitleFont)
            .foregroundColor(style.subtitleColor)
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
                    previewSubtitle(for: $0.element, style: .standard)
                    previewSubtitle(for: $0.element, style: .preview1)
                    previewSubtitle(for: $0.element, style: .preview2)
                }
            }.previewBar()
        }
    }
    
    static func previewSubtitle(
        for suggestion: AutocompleteSuggestion,
        style: AutocompleteToolbarItemStyle) -> some View {
        AutocompleteToolbarItemSubtitle(
            text: suggestion.subtitle ?? "",
            style: style
        )
    }
    
    static let previewSuggestions: [AutocompleteSuggestion] = [
        AutocompleteSuggestion(text: "", title: "Baz", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
