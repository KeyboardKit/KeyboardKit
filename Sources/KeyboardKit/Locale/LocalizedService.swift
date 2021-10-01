//
//  LocalizedService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by services that are bound
 to a certain locale. It simplifies aggregating services and
 resolve the correct service for a certain locale.
 */
public protocol LocalizedService {
    
    var localeKey: String { get }
}
