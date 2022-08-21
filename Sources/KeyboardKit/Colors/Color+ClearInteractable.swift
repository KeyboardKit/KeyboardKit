//
//  Color+ClearInteractable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension Color {

    /**
     This color can be used instead of `.clear` if the color
     should be registering touches and gestures.
     */
    static var clearInteractable: Color {
        Color.white.opacity(0.001)
    }
}
