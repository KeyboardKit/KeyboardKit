//
//  AutocompleteSpaceState.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum represents the state a text document proxy can be
 in, when inserting and removing spaces during autocomplete.
 */
public enum AutocompleteSpaceState {
    
    case none, autoInserted, autoRemoved
}
