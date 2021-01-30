//
//  FakeKeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This fake context can be used for previews etc.
 */
public class FakeKeyboardContext: KeyboardContext {
    
    public init() {}
    
    @available(*, deprecated, message: "This property will be removed in KK 4.0. Usage is strongly discouraged.")
    public var emojiCategory: EmojiCategory = .smileys

    public var actionHandler: KeyboardActionHandler = FakeKeyboardActionHandler()
    
    public var device: UIDevice = .current
    public var deviceOrientation: UIInterfaceOrientation = .portrait
    public var hasDictationKey: Bool = true
    public var hasFullAccess: Bool = false
    public var keyboardType: KeyboardType = .alphabetic(.lowercased)
    public var locale: Locale = .current
    public var needsInputModeSwitchKey: Bool = true
    public var primaryLanguage: String?
    public var textDocumentProxy: UITextDocumentProxy = FakeTextDocumentProxy()
    public var textInputMode: UITextInputMode?
    public var traitCollection: UITraitCollection = UITraitCollection()
}
