//
//  KeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-09-20.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, renamed: "Keyboard")
public typealias KeyboardButton = Keyboard

public extension Keyboard {
    
    @available(*, deprecated, renamed: "Keyboard.ButtonContent")
    typealias Content = Keyboard.ButtonContent
    
    @available(*, deprecated, renamed: "Keyboard.ButtonKey")
    typealias Key = Keyboard.ButtonKey
    
    @available(*, deprecated, renamed: "Keyboard.ButtonShadow")
    typealias Shadow = Keyboard.ButtonShadow
    
    @available(*, deprecated, renamed: "Keyboard.ButtonTitle")
    typealias Title = Keyboard.ButtonTitle
}

public extension View {
    
    @available(*, deprecated, renamed: "keyboardButtonStyle")
    func keyboardButton(_ style: Keyboard.ButtonStyle) -> some View {
        self.background(Keyboard.ButtonKey())
            .keyboardButtonStyle(style)
            .foregroundColor(style.foregroundColor)
            .font(style.font)
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
@available(*, deprecated, renamed: "Keyboard.NextKeyboardButton")
public typealias NextKeyboardButton = Keyboard.NextKeyboardButton
#endif
