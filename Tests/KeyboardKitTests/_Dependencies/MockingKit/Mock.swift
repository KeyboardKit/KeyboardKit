//
//  Mock.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2019-04-16.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This class can be inherited when you want to create mock
/// classes that don't have to inherit any other classes.
///
/// The class implements ``Mockable`` by returning `self` as
/// the ``mock`` property.
///
/// Inherit this type instead of implementing the ``Mockable``
/// protocol, to save some code for every mock you create.
open class Mock: Mockable {
    
    public init() {}
    
    public var mock: Mock { self }
    
    var registeredCalls: [UUID: [AnyCall]] = [:]
    var registeredResults: [UUID: Function] = [:]
}
