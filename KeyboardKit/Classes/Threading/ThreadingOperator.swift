//
//  ThreadingOperator.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-01-20.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

/*
    The ~> operator makes it easy to run a block on
    a background thread and run a callback block on
    the main thread as soon as the background block
    finishes.

    You can either run a block with no return value,
    then run a parameterless callbacl block, or run
    a block with a return value and pass the return
    value to the callback block, as such:

    { println("hello,") } ~> { println(" world") }
    { "hello," } ~> { println("\($0) world") }

    Read more here:
    http://ijoshsmith.com/2014/07/05/custom-threading-operator-in-swift/

    Note that the line before a {} ~> {} as well as
    the {} ~> {} line itself must use SEMICOLONS to
    prevent compile errors in XCode 6.
*/

import Foundation

infix operator ~> {}


/**
Executes the lefthand closure on a background thread and,
upon completion, the righthand closure on the main thread.
*/

public func ~> (block: () -> (), callback: () -> ()) {
    dispatch_async(queue, {
        block()
        dispatch_async(dispatch_get_main_queue(), callback)
    })
}


/**
Executes the lefthand closure on a background thread and,
upon completion, the righthand closure on the main thread.
Passes the background closure's output to the main closure.
*/

public func ~> <T> (block: () -> T, callback: (result: T) -> ()) {
    dispatch_async(queue, {
        let result = block()
        dispatch_async(dispatch_get_main_queue(), { callback(result: result) })
    })
}


/** Serial dispatch queue used by the ~> operator. */

private let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)
