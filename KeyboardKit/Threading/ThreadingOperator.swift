//
//  ThreadingOperator.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-01-20.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

/*
 
 The ~> operator makes it easy to run blocks on a background
 thread, then run a completion block on the main thread.
 
 The action block will either pass nothing or a value to the
 completion block, depending on if it returns anything:

 ```
 { println("hello,") } ~> { println(" world") }
 { "hello," } ~> { println("\($0) world") }
 ```

 Read more here:
 http://ijoshsmith.com/2014/07/05/custom-threading-operator-in-swift/

 The line before and the line itself must use SEMICOLONS, to
 prevent compile errors in XCode 6.
 
*/

import Foundation

infix operator ~>

public func ~> (block: @escaping () -> (), callback: @escaping () -> ()) {
    queue.async(execute: {
        block()
        DispatchQueue.main.async(execute: callback)
    })
}

public func ~> <T> (block: @escaping () -> T, callback: @escaping (_ result: T) -> ()) {
    queue.async(execute: {
        let result = block()
        DispatchQueue.main.async(execute: { callback(result) })
    })
}

private let queue = DispatchQueue(label: "serial-worker", attributes: [])
