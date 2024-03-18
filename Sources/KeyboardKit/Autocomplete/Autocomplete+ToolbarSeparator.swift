//
//  Autocomplete+ToolbarSeparator.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /// This view mimics a native autocomplete separator.
    ///
    /// Style it with `.autocompleteToolbarSeparatorStyle`.
    struct ToolbarSeparator: View {
        
        /// Create an autocomplete toolbar item separator.
        public init() {
            self.initStyle = nil
        }
        
        @available(*, deprecated, message: "Style this view with .autocompleteToolbarSeparatorStyle instead.")
        public init(
            style: Autocomplete.ToolbarSeparatorStyle
        ) {
            self.initStyle = style
        }
        
        /// Deprecated: Remove this in 9.0.
        private let initStyle: Autocomplete.ToolbarSeparatorStyle?
        
        @Environment(\.autocompleteToolbarSeparatorStyle)
        private var envStyle
        
        /// Deprecated: Replace this with initStyle in 9.0.
        private var style: Autocomplete.ToolbarSeparatorStyle {
            initStyle ?? envStyle
        }
        
        public var body: some View {
            style.color
                .frame(width: style.width)
                .frame(height: style.height)
        }
    }
}

#Preview {
    
    HStack {
        Autocomplete.ToolbarSeparator()
            .autocompleteToolbarSeparatorStyle(.standard)
        Autocomplete.ToolbarSeparator()
            .autocompleteToolbarSeparatorStyle(.preview1)
        Autocomplete.ToolbarSeparator()
            .autocompleteToolbarSeparatorStyle(.preview2)
    }
    .frame(height: 50)
}
