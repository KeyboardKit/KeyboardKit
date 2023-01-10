//
//  CharacterProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-28.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "This will be removed in KK7")
public protocol CharacterProvider {

    var character: Character { get }
}
