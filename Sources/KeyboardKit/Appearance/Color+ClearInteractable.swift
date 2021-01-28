//
//  Color+ClearInteractable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Color {

    /**
     This color can be used instead of `.clear`, which makes
     a view stop registering touches and gestures.
     */
    static var clearInteractable: Color {
        Color.white.opacity(0.001)
    }
}
