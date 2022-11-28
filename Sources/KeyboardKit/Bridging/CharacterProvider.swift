//
//  CharacterProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-28.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This internal protocol is shared between protocols that use
 a character to enable their functionality.

 This approach will be used within the library to reduce the
 number of extensions, and instead rewrite them as protocols
 that are then implemented by the types we want to extend. A
 protocol is more discoverable and versatile than extensions
 and also ends up in the DocC documentation, which increases
 the discoverability of important extensions.
 */
public protocol CharacterProvider {

    var character: Character { get }
}

extension Character: CharacterProvider {

    public var character: Character { self }
}
