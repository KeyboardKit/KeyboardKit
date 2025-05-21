//
//  MockReference.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2020-07-16.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This type can be used to create mock function references.
///
/// Function references get unique IDs, which means that the
/// mock reference instance can be uniquely identified.
public struct MockReference<Arguments, Result>: Identifiable {
    
    public init(_ function: @escaping (Arguments) throws -> Result) {
        self.id = UUID()
        self.function = function
    }
    
    public let id: UUID
    public let function: (Arguments) throws -> Result
}
