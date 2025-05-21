//
//  Mockable.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2019-11-25.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This class can be inherited when you want to create mock
/// classes that have to inherit other classes.
///
/// To implement this protocol, just inherit your base class
/// and provide a ``mock`` property:
///
/// ```
/// class MyMock: BaseClass, Mockable {
///     let mock = Mock()
/// }
/// ```
///
/// Implement this protocol instead of inheriting the ``Mock``
/// base class, to save some code for every mock you create.
public protocol Mockable {
    
    typealias Function = Any
    
    var mock: Mock { get }
}


// MARK: - Internal Functions

extension Mockable {

    func registerCall<Arguments, Result>(
        _ call: MockCall<Arguments, Result>,
        for ref: MockReference<Arguments, Result>
    ) {
        let calls = mock.registeredCalls[ref.id] ?? []
        mock.registeredCalls[ref.id] = calls + [call]
    }

    func registerCall<Arguments, Result>(
        _ call: MockCall<Arguments, Result>,
        for ref: AsyncMockReference<Arguments, Result>
    ) {
        let calls = mock.registeredCalls[ref.id] ?? []
        mock.registeredCalls[ref.id] = calls + [call]
    }
    
    func registeredCalls<Arguments, Result>(
        for ref: MockReference<Arguments, Result>
    ) -> [MockCall<Arguments, Result>] {
        let calls = mock.registeredCalls[ref.id]
        return (calls as? [MockCall<Arguments, Result>]) ?? []
    }

    func registeredCalls<Arguments, Result>(
        for ref: AsyncMockReference<Arguments, Result>
    ) -> [MockCall<Arguments, Result>] {
        let calls = mock.registeredCalls[ref.id]
        return (calls as? [MockCall<Arguments, Result>]) ?? []
    }

    func registeredResult<Arguments, Result>(
        for ref: MockReference<Arguments, Result>
    ) -> ((Arguments) throws -> Result)? {
        mock.registeredResults[ref.id] as? (Arguments) throws -> Result
    }

    func registeredResult<Arguments, Result>(
        for ref: AsyncMockReference<Arguments, Result>
    ) -> ((Arguments) async throws -> Result)? {
        mock.registeredResults[ref.id] as? (Arguments) async throws -> Result
    }
}
