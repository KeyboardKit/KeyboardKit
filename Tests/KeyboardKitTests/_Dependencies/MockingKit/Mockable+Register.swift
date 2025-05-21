//
//  Mockable+Register.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2019-11-25.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Mockable {
    
    /// Register a result value for a mock reference.
    /// - Parameters:
    ///   - ref: The mock reference to register a result for.
    ///   - result: What to return when the function is called.
    func registerResult<Arguments, Result>(
        for ref: MockReference<Arguments, Result>,
        result: @escaping (Arguments) throws -> Result
    ) {
        mock.registeredResults[ref.id] = result
    }

    /// Register a result value for a mock reference.
    /// - Parameters:
    ///   - refKeyPath: A key path to the mock reference to register a result for.
    ///   - result: What to return when the function is called.
    func registerResult<Arguments, Result>(
        for refKeyPath: KeyPath<Self, MockReference<Arguments, Result>>,
        result: @escaping (Arguments) throws -> Result
    ) {
        registerResult(for: self[keyPath: refKeyPath], result: result)
    }

    /// Register a result value for an async mock reference.
    /// - Parameters:
    ///   - ref: The mock reference to register a result for.
    ///   - result: What to return when the function is called.
    func registerResult<Arguments, Result>(
        for ref: AsyncMockReference<Arguments, Result>,
        result: @escaping (Arguments) async throws -> Result
    ) {
        mock.registeredResults[ref.id] = result
    }

    /// Register a result value for an async mock reference.
    /// - Parameters:
    ///   - refKeyPath: A key path to the mock reference to register a result for.
    ///   - result: What to return when the function is called.
    func registerResult<Arguments, Result>(
        for refKeyPath: KeyPath<Self, AsyncMockReference<Arguments, Result>>,
        result: @escaping (Arguments) async throws -> Result
    ) {
        registerResult(for: self[keyPath: refKeyPath], result: result)
    }
}
