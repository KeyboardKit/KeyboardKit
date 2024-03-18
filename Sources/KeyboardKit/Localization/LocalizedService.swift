//
//  LocalizedService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by services that are bound
 to a certain locale.
 
 This protocol simplifies aggregating services and resolve a
 service instance for a certain locale.
 */
public protocol LocalizedService {
    
    /// The unique locale key to use when looking up values.
    var localeKey: String { get }
}
