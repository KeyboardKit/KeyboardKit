//
//  KeyboardContext+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This fake context can be used for previews etc.
 */
public class PreviewKeyboardContext: KeyboardContext {
    
    public init() {}
    
    public var device: UIDevice = .current
    public var deviceOrientation: UIInterfaceOrientation = .portrait
    public var hasDictationKey: Bool = true
    public var hasFullAccess: Bool = false
    public var keyboardType: KeyboardType = .alphabetic(.lowercased)
    public var locale: Locale = .current
    public var needsInputModeSwitchKey: Bool = true
    public var primaryLanguage: String?
    public var textDocumentProxy: UITextDocumentProxy = PreviewTextDocumentProxy()
    public var textInputMode: UITextInputMode?
    public var traitCollection: UITraitCollection = UITraitCollection()
}
