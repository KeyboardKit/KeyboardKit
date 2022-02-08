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
     Create a system keyboard that uses a custom `buttonView`
     to customize the entire view for each layout item.
     */
    init(
        controller: KeyboardInputViewController = .shared,
        width: CGFloat? = nil,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder) {
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            appearance: controller.keyboardAppearance,
            actionHandler: controller.keyboardActionHandler,
            keyboardContext: controller.keyboardContext,
            actionCalloutContext: controller.actionCalloutContext,
            inputCalloutContext: controller.inputCalloutContext,
            width: width,
            buttonView: buttonView)
    }
}

public extension SystemKeyboard where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardActionButtonContent> {
    
    /**
     Create a system keyboard view that uses standard button
     views. See ``SystemKeyboard/standardButtonView(item:appearance:actionHandler:keyboardContext:keyboardWidth:inputWidth:)`` for more info.
     */
    init(
        controller: KeyboardInputViewController = .shared,
        width: CGFloat? = nil) {
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

public extension SystemKeyboard where ButtonView == SystemKeyboardButtonRowItem<AnyView> {
    
    /**
     Create a system keyboard view that uses `buttonContent`
     to customize the content of each button.
     */
    init<ButtonContentView: View>(
        controller: KeyboardInputViewController = .shared,
        width: CGFloat? = nil,
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
#endif
