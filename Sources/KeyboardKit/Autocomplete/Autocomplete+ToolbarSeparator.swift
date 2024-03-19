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
    /// You can style this component using the view modifier
    /// ``autocompleteToolbarSeparatorStyle(_:)``.
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
        
        @Environment(\.autocompleteToolbarSeparatorStyle)
        private var envStyle
        
        public var body: some View {
            style.color
                .frame(width: style.width)
                .frame(height: style.height)
        }
        
        // MARK: - Deprecated
        
        private typealias Style = Autocomplete.ToolbarSeparatorStyle
        private let initStyle: Style?
        private var style: Style { initStyle ?? envStyle }
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
