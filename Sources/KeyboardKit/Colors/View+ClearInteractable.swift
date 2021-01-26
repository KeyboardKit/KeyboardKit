//
//  View+ClearInteractable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-18.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /**
     This color can be used instead of `.clear`, which makes
     a view stop registering touches and gestures.
     */
    func clearInteractableBackground() -> some View {
        background(Color.clearInteractable)
    }
}
