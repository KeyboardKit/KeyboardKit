//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

/**
 This protocol can be implemented by any classes that can be
 used to provide the keyboard extension with contextual info.
 
 `KeyboardKit` will automatically create a standard instance
 and bind it to the input view controller when the extension
 is started. It can be replaced with a custom one by setting
 the `keyboardContext` property.
 */
public protocol KeyboardContext: AnyObject {
    
    var actionHandler: KeyboardActionHandler { get set }
    
    var device: UIDevice { get }
    var deviceOrientation: UIInterfaceOrientation { get set }
    var hasDictationKey: Bool { get set }
    var hasFullAccess: Bool { get set }
    var keyboardType: KeyboardType { get set }
    var locale: Locale { get set }
    var needsInputModeSwitchKey: Bool { get set }
    var primaryLanguage: String? { get set }
    var textDocumentProxy: UITextDocumentProxy { get set }
    var textInputMode: UITextInputMode? { get set }
    var traitCollection: UITraitCollection { get set }
}


// MARK: - Public Properties

public extension KeyboardContext {
    
    /**
     The current trait collection's color scheme.
     */
    var colorScheme: ColorScheme {
        traitCollection.userInterfaceStyle == .dark ? .dark : .light
    }
    
    /**
     The current keyboard appearance, with `.light` fallback.
     */
    var keyboardAppearance: UIKeyboardAppearance {
        textDocumentProxy.keyboardAppearance ?? .light
    }
}


// MARK: - Public Functions

public extension KeyboardContext {
    
    /**
     Sync the context with the current state of the keyboard
     input view controller.
     */
    func sync(with controller: UIInputViewController) {
        self.deviceOrientation = controller.deviceOrientation
        self.hasDictationKey = controller.hasDictationKey
        self.hasFullAccess = controller.hasFullAccess
        self.needsInputModeSwitchKey = controller.needsInputModeSwitchKey
        self.primaryLanguage = controller.primaryLanguage
        self.textDocumentProxy = controller.textDocumentProxy
        self.textInputMode = controller.textInputMode
        self.traitCollection = controller.traitCollection
    }
}
