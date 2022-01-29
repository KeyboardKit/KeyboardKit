//
//  SystemKeyboard+Init.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import CoreGraphics
import Foundation
import SwiftUI

public extension SystemKeyboard {
    
    /**
     Create a system keyboard for the `controller` that uses
     a `buttonViewBuilder` to generate an entire button view
     for each layout item.
     */
    init(
        controller: KeyboardInputViewController = .shared,
        width: CGFloat = standardKeyboardWidth,
        @ViewBuilder buttonViewBuilder: @escaping ButtonViewBuilder) {
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            appearance: controller.keyboardAppearance,
            actionHandler: controller.keyboardActionHandler,
            keyboardContext: controller.keyboardContext,
            actionCalloutContext: controller.actionCalloutContext,
            inputCalloutContext: controller.inputCalloutContext,
            width: width,
            buttonView: buttonViewBuilder)
    }
}

public extension SystemKeyboard where ButtonView == SystemKeyboardButtonRowItem<AnyView> {
    
    /**
     Create a system keyboard for the `controller` that uses
     a `buttonContentBuilder` to customize the internal view
     content of each button.
     */
    init<ButtonContentView: View>(
        controller: KeyboardInputViewController = .shared,
        width: CGFloat = standardKeyboardWidth,
        @ViewBuilder buttonContent: @escaping (KeyboardLayoutItem) -> ButtonContentView) {
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            appearance: controller.keyboardAppearance,
            actionHandler: controller.keyboardActionHandler,
            keyboardContext: controller.keyboardContext,
            actionCalloutContext: controller.actionCalloutContext,
            inputCalloutContext: controller.inputCalloutContext,
            width: width,
            buttonContent: buttonContent)
    }
}

public extension SystemKeyboard where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardActionButtonContent> {
    
    /**
     Create a system keyboard for the `controller` that uses
     standard button views.
     */
    init(
        controller: KeyboardInputViewController = .shared,
        width: CGFloat = standardKeyboardWidth) {
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            appearance: controller.keyboardAppearance,
            actionHandler: controller.keyboardActionHandler,
            keyboardContext: controller.keyboardContext,
            actionCalloutContext: controller.actionCalloutContext,
            inputCalloutContext: controller.inputCalloutContext,
            width: width)
    }
}
#endif
