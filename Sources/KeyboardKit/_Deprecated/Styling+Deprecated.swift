//
//  Styling.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-09-25.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "This namespace is no longer used.")
public struct Styling {}

@available(*, deprecated, renamed: "KeyboardStyleService")
public typealias KeyboardStyleProvider = KeyboardStyleService

public extension KeyboardStyle {

    @available(*, deprecated, renamed: "StandardService")
    typealias StandardProvider = StandardService
}

@available(*, deprecated, renamed: "KeyboardStyle.StandardService")
public typealias StandardKeyboardStyleProvider = KeyboardStyle.StandardProvider
