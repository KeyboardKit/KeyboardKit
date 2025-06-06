//
//  KeyboardAction+Images.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-17.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardAction {

    /// The image to which the action refers, if any.
    var image: Image? {
        switch self {
        case .image(_, let name, _): Image(name)
        case .systemImage(_, let name, _): .symbol(name)
        default: nil
        }
    }
}
