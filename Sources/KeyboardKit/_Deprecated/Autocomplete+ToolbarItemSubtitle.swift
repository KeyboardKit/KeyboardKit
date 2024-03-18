//
//  Autocomplete+ToolbarItemSubtitle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    @available(*, deprecated, message: "Just use Autocomplete.ToolbarItem.")
    struct ToolbarItemSubtitle: View {
        
        public init(
            suggestion: Autocomplete.Suggestion,
            style: Autocomplete.ToolbarItemStyle = .standard
        ) {
            self.suggestion = suggestion
            self.style = style
        }
        
        private let suggestion: Autocomplete.Suggestion
        private let style: Autocomplete.ToolbarItemStyle
        
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
