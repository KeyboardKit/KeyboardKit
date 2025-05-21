//
//  Mockable+Inspect.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2019-11-25.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Mockable {

    /// Get all calls to a certain mock reference.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to check calls for.
    func calls<Arguments, Result>(
        to ref: MockReference<Arguments, Result>
    ) -> [MockCall<Arguments, Result>] {
        registeredCalls(for: ref)
    }

    /// Get all calls to a certain mock reference.
    ///
    /// - Parameters:
    ///   - refKeyPath: A key path to the mock reference to check calls for.
    func calls<Arguments, Result>(
        to refKeyPath: KeyPath<Self, MockReference<Arguments, Result>>
    ) -> [MockCall<Arguments, Result>] {
        calls(to: self[keyPath: refKeyPath])
    }

    /// Get all calls to a certain async mock reference.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to check calls for.
    func calls<Arguments, Result>(
        to ref: AsyncMockReference<Arguments, Result>
    ) -> [MockCall<Arguments, Result>] {
        registeredCalls(for: ref)
    }

    /// Get all calls to a certain async mock reference.
    ///
    /// - Parameters:
    ///   - refKeyPath: A key path to the mock reference to check calls for.
    func calls<Arguments, Result>(
        to refKeyPath: KeyPath<Self, AsyncMockReference<Arguments, Result>>
    ) -> [MockCall<Arguments, Result>] {
        calls(to: self[keyPath: refKeyPath])
    }

    /// Check if a mock reference has been called.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to check calls for.
    func hasCalled<Arguments, Result>(
        _ ref: MockReference<Arguments, Result>
    ) -> Bool {
        calls(to: ref).count > 0
    }

    /// Check if a mock reference has been called.
    ///
    /// - Parameters:
    ///   - refKeyPath: A key path to the mock reference to check calls for.
    func hasCalled<Arguments, Result>(
        _ refKeyPath: KeyPath<Self, MockReference<Arguments, Result>>
    ) -> Bool {
        hasCalled(self[keyPath: refKeyPath])
    }

    /// Check if an async mock reference has been called.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to check calls for.
    func hasCalled<Arguments, Result>(
        _ ref: AsyncMockReference<Arguments, Result>
    ) -> Bool {
        calls(to: ref).count > 0
    }

    /// Check if an async mock reference has been called.
    ///
    /// - Parameters:
    ///   - refKeyPath: A key path to the mock reference to check calls for.
    func hasCalled<Arguments, Result>(
        _ refKeyPath: KeyPath<Self, AsyncMockReference<Arguments, Result>>
    ) -> Bool {
        hasCalled(self[keyPath: refKeyPath])
    }

    /// Check if a mock reference has been called.
    ///
    /// For this function to return `true` the actual number
    /// of calls must match the provided `numberOfCalls`.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to check calls for.
    ///   - numberOfTimes: The expected number of calls.
    func hasCalled<Arguments, Result>(
        _ ref: MockReference<Arguments, Result>,
        numberOfTimes: Int
    ) -> Bool {
        calls(to: ref).count == numberOfTimes
    }

    /// Check if a mock reference has been called.
    ///
    /// For this function to return `true` the actual number
    /// of calls must match the provided `numberOfCalls`.
    ///
    /// - Parameters:
    ///   - refKeyPath: A key path to the mock reference to check calls for.
    ///   - numberOfTimes: The expected number of calls.
    func hasCalled<Arguments, Result>(
        _ refKeyPath: KeyPath<Self, MockReference<Arguments, Result>>,
        numberOfTimes: Int
    ) -> Bool {
        hasCalled(self[keyPath: refKeyPath], numberOfTimes: numberOfTimes)
    }

    /// Check if an async mock reference has been called.
    ///
    /// For this function to return `true` the actual number
    /// of calls must match the provided `numberOfCalls`.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to check calls for.
    func hasCalled<Arguments, Result>(
        _ ref: AsyncMockReference<Arguments, Result>,
        numberOfTimes: Int
    ) -> Bool {
        calls(to: ref).count == numberOfTimes
    }

    /// Check if an async mock reference has been called.
    ///
    /// For this function to return `true` the actual number
    /// of calls must match the provided `numberOfCalls`.
    ///
    /// - Parameters:
    ///   - refKeyPath: A key path to the mock reference to check calls for.
    func hasCalled<Arguments, Result>(
        _ refKeyPath: KeyPath<Self, AsyncMockReference<Arguments, Result>>,
        numberOfTimes: Int
    ) -> Bool {
        hasCalled(self[keyPath: refKeyPath], numberOfTimes: numberOfTimes)
    }
}
