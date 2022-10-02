//
//  TextDocumentProxy.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-02.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This is a platform-agnostic version of `UITextDocumentProxy`,
 which over time will be used by KeyboardKit's functionality
 that is based on a text document proxy.

 This protocol is not meant to replace the native proxy, but
 rather make the internal functionality as platform-agnostic
 as possible. As such, it will get more and more features as
 the internal documentation moves over to use this type.

 The protocol is implemented by `UITextDocumentProxy`.
 */
public protocol TextDocumentProxy {

}
