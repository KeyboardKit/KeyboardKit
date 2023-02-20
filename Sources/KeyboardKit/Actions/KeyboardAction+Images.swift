//
//  KeyboardAction+Images.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-17.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This extension defines images for various keyboard actions.
 */
public extension KeyboardAction {

    /**
     The image to which the action refers, if any.
     */
    var image: Image? {
        switch self {
        case .image(_, let imageName, _): return Image(imageName, bundle: .keyboardKit)
        case .systemImage(_, let imageName, _): return Image(systemName: imageName)
        default: return nil
        }
    }
}
