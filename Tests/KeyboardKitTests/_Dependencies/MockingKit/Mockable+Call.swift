//
//  Mockable+Call.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2019-11-25.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Mockable {

    /// Call a mock reference with a `non-optional` result.
    ///
    /// This will return any pre-registered result, or crash
    /// if no result has been registered.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to call.
    ///   - args: The arguments to call the functions with.
    func call<Arguments, Result>(
        _ ref: MockReference<Arguments, Result>,
        args: Arguments,
        file: StaticString = #file,
        line: UInt = #line,
        functionCall: StaticString = #function
    ) -> Result {
        if Result.self == Void.self {
            let void = unsafeBitCast((), to: Result.self)
            let call = MockCall(arguments: args, result: void)
            registerCall(call, for: ref)
            return void
        }

        guard let result = try? registeredResult(for: ref)?(args) else {
            let message = "You must register a result for '\(functionCall)' with `registerResult(for:)` before calling this function."
            preconditionFailure(message, file: file, line: line)
        }
        let call = MockCall(arguments: args, result: result)
        registerCall(call, for: ref)
        return result
    }

    /// Call a mock reference with a `non-optional` result.
    ///
    /// This will return any pre-registered result, or crash
    /// if no result has been registered.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to call.
    ///   - args: The arguments to call the functions with.
    func call<Arguments, Result>(
        _ ref: AsyncMockReference<Arguments, Result>,
        args: Arguments,
        file: StaticString = #file,
        line: UInt = #line,
        functionCall: StaticString = #function
    ) async -> Result {
        if Result.self == Void.self {
            let void = unsafeBitCast((), to: Result.self)
            let call = MockCall(arguments: args, result: void)
            registerCall(call, for: ref)
            return void
        }

        guard let result = try? await registeredResult(for: ref)?(args) else {
            let message = "You must register a result for '\(functionCall)' with `registerResult(for:)` before calling this function."
            preconditionFailure(message, file: file, line: line)
        }
        let call = MockCall(arguments: args, result: result)
        registerCall(call, for: ref)
        return result
    }

    /// Call a mock reference with a `non-optional` result.
    ///
    /// This will return any pre-registered result or return
    /// a `fallback` value if no result has been registered.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to call.
    ///   - args: The arguments to call the functions with.
    ///   - fallback: The value to return if no result has been registered.
    func call<Arguments, Result>(
        _ ref: MockReference<Arguments, Result>,
        args: Arguments,
        fallback: @autoclosure () -> Result
    ) -> Result {
        let result = (try? registeredResult(for: ref)?(args)) ?? fallback()
        registerCall(MockCall(arguments: args, result: result), for: ref)
        return result
    }

    /// Call a mock reference with a `non-optional` result.
    ///
    /// This will return any pre-registered result or return
    /// a `fallback` value if no result has been registered.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to call.
    ///   - args: The arguments to call the functions with.
    ///   - fallback: The value to return if no result has been registered.
    func call<Arguments, Result>(
        _ ref: AsyncMockReference<Arguments, Result>,
        args: Arguments,
        fallback: @autoclosure () -> Result
    ) async -> Result {
        let result = (try? await registeredResult(for: ref)?(args)) ?? fallback()
        registerCall(MockCall(arguments: args, result: result), for: ref)
        return result
    }

    /// Call a mock reference with an `optional` result.
    ///
    /// This will return a pre-registered result or `nil` if
    /// no result has been registered.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to call.
    ///   - args: The arguments to call the functions with.
    func call<Arguments, Result>(
        _ ref: MockReference<Arguments, Result?>,
        args: Arguments
    ) -> Result? {
        let result = try? registeredResult(for: ref)?(args)
        registerCall(MockCall(arguments: args, result: result), for: ref)
        return result
    }

    /// Call a mock reference with an `optional` result.
    ///
    /// This will return a pre-registered result or `nil` if
    /// no result has been registered.
    ///
    /// - Parameters:
    ///   - ref: The mock reference to call.
    ///   - args: The arguments to call the functions with.
    func call<Arguments, Result>(
        _ ref: AsyncMockReference<Arguments, Result?>,
        args: Arguments
    ) async -> Result? {
        let result = try? await registeredResult(for: ref)?(args)
        registerCall(MockCall(arguments: args, result: result), for: ref)
        return result
    }
}
