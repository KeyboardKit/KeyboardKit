//
//  KeyboardViewStyleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-20.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import Testing

@testable import KeyboardKit

@MainActor
final class KeyboardViewStyleTests {

    let context = KeyboardContext()

    @Test
    func styleHasStandardValue() async throws {
        let style = KeyboardViewStyle.standard
        #expect(style.background == nil)
        #expect(style.foregroundColor == nil)
        #expect(style.edgeInsets == nil)
    }

    @Test
    func edgeInsetsHasStandardValueForContext() async throws {
        var insets: EdgeInsets { .standardKeyboardEdgeInsets(for: context) }
        context.deviceTypeForKeyboard = .phone
        #expect(insets == .init(top: 0, leading: 0, bottom: -2, trailing: 0))
        context.screenSize = .iPhoneLargeScreen
        #expect(insets == .zero)
        context.deviceTypeForKeyboard = .pad
        #expect(insets == .init(top: 0, leading: 0, bottom: 4, trailing: 0))
    }
}
