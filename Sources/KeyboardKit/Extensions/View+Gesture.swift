//
//  View+Gesture.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-06-20.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func optionalGesture<GestureType: Gesture>(_ gesture: GestureType?) -> some View {
        if let gesture = gesture {
            self.gesture(gesture)
        } else {
            self
        }
    }
}
