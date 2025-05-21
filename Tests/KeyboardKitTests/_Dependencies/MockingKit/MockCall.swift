//
//  MockCall.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2019-11-11.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This struct represents function calls, with the provided
/// ``arguments`` and the returned ``result``.
///
/// Function that don't return anything have a `Void` result.
public struct MockCall<Arguments, Result>: AnyCall {
    
    public let arguments: Arguments
    public let result: Result?
}

/// This protocol represents any kind of mock function call.
/// It's used to type erase the generic `MockCall`.
public protocol AnyCall {}
