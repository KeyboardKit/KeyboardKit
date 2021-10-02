//
//  AutocompleteToolbarItemBackground.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /**
     This extension applies a background that replicates the
     autocomplete item background that is used in native iOS
     keyboards. If the suggestion `isAutocomplete` is `true`,
     the background is a semi-white, rounded rectangle, else
     a transparent, tappable one.
     */
    func autocompleteToolbarItemBackground(for suggestion: AutocompleteSuggestion) -> some View {
        self.padding(.horizontal, 4)
            .padding(.vertical, 10)
            .background(suggestion.isAutocomplete ? Color.white.opacity(0.5) : Color.clearInteractable)
            .cornerRadius(5)
    }
}
