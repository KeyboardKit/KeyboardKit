//
//  NextKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This button switches to the next keyboard when it is tapped
 and opens a keyboard switcher menu when it is pressed.
 */
public struct NextKeyboardButton: UIViewRepresentable {
    
    public init(
        controller: KeyboardInputViewController = .shared,
        tintColor: UIColor = .label,
        pointSize: CGFloat = 23,
        weight: UIImage.SymbolWeight = .light,
        scale: UIImage.SymbolScale = .medium) {
        self.button = NextKeyboardUIButton(
            controller: controller,
            tintColor: tintColor,
            pointSize: pointSize,
            weight: weight,
            scale: scale)
    }
    
    @available(iOS 14.0, *)
    public init(
        controller: KeyboardInputViewController = .shared,
        tintColor: Color = .primary,
        pointSize: CGFloat = 23,
        weight: UIImage.SymbolWeight = .light,
        scale: UIImage.SymbolScale = .medium) {
        self.button = NextKeyboardUIButton(
            controller: controller,
            tintColor: UIColor(tintColor),
            pointSize: pointSize,
            weight: weight,
            scale: scale)
    }
    
    private let button: UIButton
    
    public func makeUIView(context: Context) -> UIButton { button }

    public func updateUIView(_ uiView: UIButton, context: Context) {}
}
