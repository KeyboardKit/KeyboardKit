//
//  Image+Demo.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension Image {
    
    static let alert = Image.symbol("exclamationmark.triangle")
    static let checkmark = Image.symbol("checkmark")
    static let clear = Image.symbol("xmark.circle")
    static let dismiss = Image.symbol("xmark")
    static let text = Image.symbol("abc")
    static let type = Image.symbol("square.and.pencil")
    static let safari = Image.symbol("safari")
    static let settings = Image.symbol("gearshape")
    
    static func file(_ name: String) -> Image {
        Image(name)
    }
    
    static func symbol(_ name: String) -> Image {
        Image(systemName: name)
    }
}
