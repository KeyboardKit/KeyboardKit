//
//  ObservableKeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This observable context provides observable properties to a
 keyboard extension that targets iOS 13 or later.
 
 Whenever a `KeyboardInputViewController` uses `setup(with:)`
 to use `SwiftUI`, KeyboardKit replaces the standard context
 with an instance of this type then injects it into the view
 environment, so it can be accessed with `@EnvironmentObject`.
 */
open class ObservableKeyboardContext: KeyboardContext, ObservableObject {
    
    public init(
        locale: Locale = .current,
        device: UIDevice = .current,
        controller: KeyboardInputViewController,
        actionHandler: KeyboardActionHandler,
        keyboardAppearanceProvider: KeyboardAppearanceProvider = StandardKeyboardAppearanceProvider(),
        keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior(),
        keyboardType: KeyboardType = .alphabetic(.lowercased),
        keyboardInputSetProvider: KeyboardInputSetProvider = StandardKeyboardInputSetProvider(),
        keyboardLayoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider()) {
        self.controller = controller
        
        self.actionHandler = actionHandler
        self.keyboardAppearanceProvider = keyboardAppearanceProvider
        self.keyboardBehavior = keyboardBehavior
        self.keyboardInputSetProvider = keyboardInputSetProvider
        self.keyboardLayoutProvider = keyboardLayoutProvider
        
        self.device = device
        self.deviceOrientation = controller.deviceOrientation
        self.hasDictationKey = controller.hasDictationKey
        self.hasFullAccess = controller.hasFullAccess
        self.keyboardType = keyboardType
        self.locale = locale
        self.needsInputModeSwitchKey = controller.needsInputModeSwitchKey
        self.primaryLanguage = controller.primaryLanguage
        self.textDocumentProxy = controller.textDocumentProxy
        self.textInputMode = controller.textInputMode
        self.traitCollection = controller.traitCollection
    }
    
    unowned public var controller: KeyboardInputViewController
    
    public let device: UIDevice
    
    @Published public var actionHandler: KeyboardActionHandler
    @Published public var keyboardAppearanceProvider: KeyboardAppearanceProvider
    @Published public var keyboardBehavior: KeyboardBehavior
    @Published public var keyboardInputSetProvider: KeyboardInputSetProvider
    @Published public var keyboardLayoutProvider: KeyboardLayoutProvider
    @Published public var keyboardType: KeyboardType
    @Published public var deviceOrientation: UIInterfaceOrientation
    @Published public var hasDictationKey: Bool
    @Published public var hasFullAccess: Bool
    @Published public var locale: Locale
    @Published public var needsInputModeSwitchKey: Bool
    @Published public var primaryLanguage: String?
    @Published public var textDocumentProxy: UITextDocumentProxy
    @Published public var textInputMode: UITextInputMode?
    @Published public var traitCollection: UITraitCollection
}
