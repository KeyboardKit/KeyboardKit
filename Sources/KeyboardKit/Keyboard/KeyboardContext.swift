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
 This class provides keyboard extensions with contextual and
 observable information.
 
 `KeyboardKit` will automatically create an instance of this
 class and bind it to the input view controller.
 */
public class KeyboardContext: ObservableObject {
    
    public init(
        locale: Locale = .current,
        device: UIDevice = .current,
        controller: KeyboardInputViewController,
        keyboardType: KeyboardType = .alphabetic(.lowercased)) {
        self.locale = locale
        self.locales = [locale]
        self.device = device
        self.keyboardType = keyboardType
        self.sync(with: controller)
    }
    
    public let device: UIDevice
    
    @Published public var activeAppBundleId: String?
    @Published public var keyboardType: KeyboardType
    @Published public var deviceOrientation: UIInterfaceOrientation = .portrait
    @Published public var hasDictationKey: Bool = false
    @Published public var hasFullAccess: Bool = false
    @Published public var locale: Locale
    @Published public var locales: [Locale]
    @Published public var needsInputModeSwitchKey: Bool = true
    @Published public var primaryLanguage: String?
    @Published public var textDocumentProxy: UITextDocumentProxy = PreviewTextDocumentProxy()
    @Published public var textInputMode: UITextInputMode?
    @Published public var traitCollection: UITraitCollection = UITraitCollection()
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
        textDocumentProxy.keyboardAppearance ?? .default
    }
}


// MARK: - Public Functions

public extension KeyboardContext {
    
    /**
     Select the next locale in the `locales` list, depending
     on the current `locale`. If `locale` is not in `locales`
     or last in the list, the first list locale is selected.
     */
    func selectNextLocale() {
        let fallback = locales.first ?? locale
        guard let currentIndex = locales.firstIndex(of: locale) else { return locale = fallback }
        let nextIndex = currentIndex.advanced(by: 1)
        guard locales.count > nextIndex else { return locale = fallback }
        locale = locales[nextIndex]
    }
    
    /**
     Sync the context with the current state of the keyboard
     input view controller.
     */
    func sync(with controller: KeyboardInputViewController) {
        self.activeAppBundleId = controller.activeAppBundleId
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
