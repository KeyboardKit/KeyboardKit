//
//  Autocomplete+Deprecated.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-12-06.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, renamed: "AutocompleteService")
public typealias AutocompleteProvider = AutocompleteService

public extension Autocomplete {

    @available(*, deprecated, renamed: "DisabledService")
    typealias DisabledProvider = DisabledService
}

@available(*, deprecated, renamed: "Autocomplete.Toolbar")
public typealias AutocompleteToolbar = Autocomplete.Toolbar

public extension AutocompleteContext {

    @available(*, deprecated, renamed: "isAutocompleteEnabled")
    var isEnabled: Bool {
        isAutocompleteEnabled
    }
}
