//
//  Autocomplete+ToolbarItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /// This view mimics a native autocomplete toolbar item.
    ///
    /// You can style this component with the style modifier
    /// ``autocompleteToolbarItemStyle(_:)``.
    struct ToolbarItem: View {
        
        /// Create an autocomplete toolbar item.
        ///
        /// - Parameters:
        ///   - suggestion: The suggestion to display.
        ///   - locale: The locale to use, by default `.current`.
        public init(
            suggestion: Autocomplete.Suggestion,
            locale: Locale = .current
        ) {
            self.suggestion = suggestion
            self.locale = locale
            self.initStyle = nil
        }
        
        private let suggestion: Suggestion
        private let locale: Locale
        
        @Environment(\.autocompleteToolbarItemStyle)
        private var envStyle
        
        public var body: some View {
            VStack(spacing: 0) {
                title
                subtitle
            }
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
            .background(style.backgroundColor)
            .background(Color.clearInteractable)
            .cornerRadius(style.backgroundCornerRadius)
            .autocompleteToolbarItemStyle(style)    // Deprecated: Remove in 9.0
        }
        
        // MARK: - Deprecated
        
        @available(*, deprecated, message: "Use .autocompleteToolbarItemStyle to apply the style instead.")
        public init(
            suggestion: Autocomplete.Suggestion,
            locale: Locale = .current,
            style: Autocomplete.ToolbarItemStyle
        ) {
            self.suggestion = suggestion
            self.locale = locale
            self.initStyle = style
        }
        
        private typealias Style = Autocomplete.ToolbarItemStyle
        private let initStyle: Style?
        private var style: Style { initStyle ?? envStyle }
    }
}

private extension Autocomplete.ToolbarItem {
    
    var title: some View {
        Text(suggestion.title)
            .lineLimit(1)
            .font(style.titleFont.font)
            .foregroundColor(style.titleColor)
            .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    var subtitle: some View {
        if let subtitle = suggestion.subtitle {
            Text(subtitle)
                .lineLimit(1)
                .font(style.subtitleFont.font)
                .foregroundColor(style.subtitleColor)
        }
    }
}

#Preview {
    
    let suggestions: [Autocomplete.Suggestion] = [
        .init(text: "Foo", isUnknown: true),
        .init(text: "Bar", isAutocorrect: true),
        .init(text: "", title: "Baz", subtitle: "Recommended")]
    
    return HStack {
        HStack {
            ForEach(suggestions, id: \.text) {
                Autocomplete.ToolbarItem(suggestion: $0)
            }
        }
    }
    .padding(5)
    .background(Color.gray.opacity(0.3))
    .cornerRadius(10)
    .padding()
}
