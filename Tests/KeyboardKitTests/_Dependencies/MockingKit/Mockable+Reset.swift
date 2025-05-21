//
//  Mockable+Reset.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2019-11-25.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Mockable {

    /// Reset all registered calls.
    func resetCalls() {
        mock.registeredCalls = [:]
    }

    /// Reset all registered calls for a mock reference.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to reset any calls for.
    func resetCalls<Arguments, Result>(
        to ref: MockReference<Arguments, Result>
    ) {
        mock.registeredCalls[ref.id] = []
    }

    /// Reset all registered calls for a mock reference.
    ///
    /// - Parameters:
    ///   - refKeyPath: A key path to the mock reference to reset any calls for.
    func resetCalls<Arguments, Result>(
        to refKeyPath: KeyPath<Self, MockReference<Arguments, Result>>
    ) {
        resetCalls(to: self[keyPath: refKeyPath])
    }

    /// Reset all registered calls for a mock reference.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to reset any calls for.
    func resetCalls<Arguments, Result>(
        to ref: AsyncMockReference<Arguments, Result>
    ) {
        mock.registeredCalls[ref.id] = []
    }

    /// Reset all registered calls for a mock reference.
    ///
    /// - Parameters:
    ///   - refKeyPath: A key path to the mock reference to reset any calls for.
    func resetCalls<Arguments, Result>(
        to refKeyPath: KeyPath<Self, AsyncMockReference<Arguments, Result>>
    ) {
        resetCalls(to: self[keyPath: refKeyPath])
    }
}
