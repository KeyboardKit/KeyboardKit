//
//  View+Focus.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-01-08.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func prefersFocusable(_ bool: Bool) -> some View {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
            self.focusable(bool)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func prefersFocusEffectDisabled(_ bool: Bool) -> some View {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
            self.focusEffectDisabled(bool)
        } else {
            self
        }
    }
}
