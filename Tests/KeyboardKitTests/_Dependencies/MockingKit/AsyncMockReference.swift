//
//  AsyncTests.swift
//  MockingKit
//
//  Created by Tobias Boogh on 2022-05-04.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This type can be used to create mock function references.
///
/// Function references get unique IDs, which means that the
/// mock reference instance can be uniquely identified.
public struct AsyncMockReference<Arguments, Result>: Identifiable {

    public init(_ function: @escaping (Arguments) async throws -> Result) {
        self.id = UUID()
        self.function = function
    }

    public let id: UUID
    public let function: (Arguments) async throws -> Result
}
