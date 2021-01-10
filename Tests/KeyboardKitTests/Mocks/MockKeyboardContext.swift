//
//  MockKeyboardContext.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit
import UIKit

class MockKeyboardContext: KeyboardContext {
    
    var controller: KeyboardInputViewController = KeyboardInputViewController()
    
    var device: UIDevice = .current
    
    var actionHandler: KeyboardActionHandler = MockKeyboardActionHandler()
    var keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior()
    lazy var keyboardAppearanceProvider: KeyboardAppearanceProvider = StandardKeyboardAppearanceProvider()
    lazy var keyboardInputSetProvider: KeyboardInputSetProvider = StaticKeyboardInputSetProvider.empty
    lazy var keyboardLayoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider()
    lazy var secondaryCalloutActionProvider: SecondaryCalloutActionProvider = StandardSecondaryCalloutActionProvider()
    
    var deviceOrientation: UIInterfaceOrientation = .portrait
    var emojiCategory: EmojiCategory = .frequent
    var hasDictationKey = false
    var hasFullAccess = false
    var keyboardAppearanceValue: UIKeyboardAppearance = .light
    var keyboardAppearance: UIKeyboardAppearance = .dark
    var keyboardType: KeyboardType = .alphabetic(.lowercased)
    var locale: Locale = .current
    var needsInputModeSwitchKey = false
    var primaryLanguage: String?
    var textDocumentProxy: UITextDocumentProxy = MockTextDocumentProxy()
    var textInputMode: UITextInputMode?
    var traitCollection: UITraitCollection = .init()
}
