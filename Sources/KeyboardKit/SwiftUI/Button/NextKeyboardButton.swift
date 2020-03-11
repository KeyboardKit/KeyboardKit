//
//  NextKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct NextKeyboardButton: UIViewRepresentable {
    
    public init(
        controller: KeyboardInputViewController,
        pointSize: CGFloat = 25,
        weight: UIImage.SymbolWeight = .light,
        scale: UIImage.SymbolScale = .medium) {
        self.button = NextKeyboardUIButton(
            controller: controller,
            pointSize: pointSize,
            weight: weight,
            scale: scale)
    }
    
    private let button: UIButton
    
    public func makeUIView(context: Context) -> UIButton { button }

    public func updateUIView(_ uiView: UIButton, context: Context) {}
}
