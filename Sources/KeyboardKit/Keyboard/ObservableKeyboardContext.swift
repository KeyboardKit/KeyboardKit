//
//  ObservableKeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This keyboard context is an `ObservableObject` and provides
 observable properties.
 */
open class ObservableKeyboardContext: KeyboardContext, ObservableObject {
    
    public init(
        locale: Locale = .current,
        device: UIDevice = .current,
        controller: KeyboardInputViewController,
        actionHandler: KeyboardActionHandler,
        keyboardType: KeyboardType = .alphabetic(.lowercased),
        keyboardInputSetProvider: KeyboardInputSetProvider = StandardKeyboardInputSetProvider(),
        keyboardLayoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider()) {
        
        self.actionHandler = actionHandler
        self.keyboardInputSetProvider = keyboardInputSetProvider
        self.keyboardLayoutProvider = keyboardLayoutProvider
        
        self.device = device
        self.keyboardType = keyboardType
        self.locale = locale
        self.sync(with: controller)
    }
    
    public let device: UIDevice
    
    @Published public var actionHandler: KeyboardActionHandler
    @Published public var keyboardInputSetProvider: KeyboardInputSetProvider
    @Published public var keyboardLayoutProvider: KeyboardLayoutProvider
    @Published public var keyboardType: KeyboardType
    @Published public var deviceOrientation: UIInterfaceOrientation = .portrait
    @Published public var hasDictationKey: Bool = false
    @Published public var hasFullAccess: Bool = false
    @Published public var locale: Locale
    @Published public var needsInputModeSwitchKey: Bool = true
    @Published public var primaryLanguage: String?
    @Published public var textDocumentProxy: UITextDocumentProxy = FakeTextDocumentProxy()
    @Published public var textInputMode: UITextInputMode?
    @Published public var traitCollection: UITraitCollection = UITraitCollection()
}
