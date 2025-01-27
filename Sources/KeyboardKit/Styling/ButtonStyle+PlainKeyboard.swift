//
//  ButtonStyle+PlainKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-11-20.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension ButtonStyle where Self == PlainKeyboardButtonStyle {

    /// This button style can be used for plain buttons that
    /// are used in keyboard extensions.
    ///
    /// This is needed because the transparent background is
    /// not responding to touches, which this style fixes.
    static var plainKeyboard: Self { .init() }

    /// This button style can be used for plain buttons that
    /// are used in keyboard extensions.
    ///
    /// This is needed because the transparent background is
    /// not responding to touches, which this style fixes.
    static func plainKeyboard(
        pressedOpacity: Double? = nil
    ) -> Self { .init(pressedOpacity: pressedOpacity) }
}

/// This button style can be used for plain buttons that are
/// used in keyboard extensions.
///
/// This is needed because the transparent background is not
/// responding to touches, which this style fixes.
public struct PlainKeyboardButtonStyle: ButtonStyle {

    init(pressedOpacity: Double? = nil) {
        self.pressedOpacity = pressedOpacity ?? 0.5
    }

    private let pressedOpacity: Double

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.clearInteractable)
            .opacity(configuration.isPressed ? pressedOpacity : 1)
    }
}

private var previewButton: some View {
    Button {
        print("Tapped!")
    } label: {
        Text("Hello, world!")
    }
}

#Preview {
    VStack {
        previewButton.buttonStyle(.plainKeyboard)
        previewButton.buttonStyle(.plainKeyboard(pressedOpacity: 0.1))
    }
}
