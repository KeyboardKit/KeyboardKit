//
//  AutocompleteSpaceState.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-19.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum represents the state a text document proxy can be
 in, when inserting and removing spaces during autocomplete.
 */
public enum AutocompleteSpaceState {
    
    /// This means that the proxy is not in a certain state.
    case none
    
    /// This means that the proxy has an auto-inserted space.
    case autoInserted
    
    /// This means that the proxy has an auto-removed space.
    case autoRemoved
}
