//
//  View+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-12-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /// This view modifier can be applied to a view, to make
    /// it honor `.autocorrectionDisabled()`.
    struct AutocorrectionDisabledToContextModifer: ViewModifier {
        
        /// Create a modifier instance for a certain context.
        public init(
            context: AutocompleteContext
        ) {
            self.context = context
        }
        
        private let context: AutocompleteContext
        
        #if os(iOS) || os(tvOS) || os(macOS)
        @Environment(\.autocorrectionDisabled)
        private var autocorrectionDisabled
        #else
        private let autocorrectionDisabled = false
        #endif
        
        public func body(content: Content) -> some View {
            content
                .onAppear {
                    guard autocorrectionDisabled else { return }
                    context.isAutocorrectEnabled = false
                }
        }
    }
}

public extension View {

    /// This modifier can be applied to any view, to make it
    /// honor `.autocorrectionDisabled()`.
    func autocorrectionDisabled(
        with context: AutocompleteContext
    ) -> some View {
        self.modifier(
            Autocomplete.AutocorrectionDisabledToContextModifer(
                context: context
            )
        )
    }
}
