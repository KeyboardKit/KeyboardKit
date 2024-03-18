//
//  Autocomplete+ToolbarItemTitle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    @available(*, deprecated, message: "Just use Autocomplete.ToolbarItem.")
    struct ToolbarItemTitle: View {
        
        public init(
            suggestion: Autocomplete.Suggestion,
            locale: Locale = .current,
            style: Autocomplete.ToolbarItemStyle = .standard
        ) {
            self.suggestion = suggestion
            self.locale = locale
            self.initStyle = style
        }
        
        private let suggestion: Autocomplete.Suggestion
        private let locale: Locale
        
        /// Deprecated: Remove this in 9.0.
        private let initStyle: Autocomplete.ToolbarItemStyle?
        
        @Environment(\.autocompleteToolbarStyle)
        private var envStyle
        
        /// Deprecated: Replace this with initStyle in 9.0.
        private var style: Autocomplete.ToolbarStyle {
            guard let initStyle else { return envStyle }
            return .init(item: initStyle)
        }
        
        public var body: some View {
            Text(displayTitle)
                .lineLimit(1)
                .font(style.item.titleFont.font)
                .foregroundColor(style.item.titleColor)
                .frame(maxWidth: .infinity)
        }
        
        var displayTitle: String {
            if !suggestion.isUnknown { return suggestion.title }
            let beginDelimiter = locale.quotationBeginDelimiter ?? "\""
            let endDelimiter = locale.quotationEndDelimiter ?? "\""
            return "\(beginDelimiter)\(suggestion.title)\(endDelimiter)"
        }
    }
}
