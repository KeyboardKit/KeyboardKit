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
 observable information. It is a central part of KeyboardKit
 and to create adaptive keyboards.
 
 KeyboardKit automatically creates an instance of this class
 and adds it to the input view controller. It will also sync
 the context with the input controller whenever needed. This
 means that significant changes are synced to a `@Published`
 property that your extension can observe.
 */
public class KeyboardContext: ObservableObject {
    
    /**
     Create a context instance.
     
     - Parameters:
       - controller: The controller to which the context should apply.
       - locale: The locale to use, by default `.current`.
       - device: The device to use, by default `.current`.
       - screen: The screen to use, by default `.main`.
       - keyboardType: The current keyboard tye, by default `.alphabetic(.lowercased)`
     */
    public init(
        controller: KeyboardInputViewController,
        locale: Locale = .current,
        device: UIDevice = .current,
        screen: UIScreen = .main,
        keyboardType: KeyboardType = .alphabetic(.lowercased)) {
        self.locale = locale
        self.locales = [locale]
        self.device = device
        self.screen = screen
        self.keyboardType = keyboardType
        self.sync(with: controller)
    }
    
    public let device: UIDevice
    
    /**
     This property can be set to `false` to stop the context
     from syncing with the vc. It is experimental and can be
     removed whenever.
     */
    public static var tempIsPreviewMode: Bool = false
    
    /**
     The bundle ID of the currently active app.
     */
    @Published public var activeAppBundleId: String?
    
    /**
     The keyboard type that is currently used.
     */
    @Published public var keyboardType: KeyboardType
    
    /**
     Whether or not the input controller has a dictation key.
     */
    @Published public var hasDictationKey: Bool = false
    
    /**
     Whether or not the extension has been given full access.
     */
    @Published public var hasFullAccess: Bool = false
    
    /**
     The locale that is currently being used.
     
     This uses `Locale` instead of `KeyboardLocale`, since a
     keyboard may have to support locales that are not built
     into the library.
     */
    @Published public var locale: Locale
    
    /**
     The locales that are currently enabled for the keyboard.
     
     The `selectNextLocale` function can be called to select
     the next locale in this list.
     
     This uses `Locale` instead of `KeyboardLocale`, since a
     keyboard may have to support locales that are not built
     into the library.
     */
    @Published public var locales: [Locale]
    
    /**
     Whether or not the keyboard should (must) have a switch
     key for selecting the next keyboard.
     */
    @Published public var needsInputModeSwitchKey: Bool = true
    
    /**
     The primary language that is currently being used.
     */
    @Published public var primaryLanguage: String?
    
    /**
     The screen in which the keyboard is presented.
     */
    @Published public var screen: UIScreen
    
    /**
     The current screen orientation.
     */
    @Published public var screenOrientation: UIInterfaceOrientation = .portrait
    
    /**
     The text document proxy that is currently active.
     */
    @Published public var textDocumentProxy: UITextDocumentProxy = PreviewTextDocumentProxy()
    
    /**
     The text input mode of the input controller.
     */
    @Published public var textInputMode: UITextInputMode?
    
    /**
     The input controller's current trait collection.
     */
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
        if Self.tempIsPreviewMode { return }
        self.activeAppBundleId = controller.activeAppBundleId
        self.hasDictationKey = controller.hasDictationKey
        self.hasFullAccess = controller.hasFullAccess
        self.needsInputModeSwitchKey = controller.needsInputModeSwitchKey
        self.primaryLanguage = controller.primaryLanguage
        self.screenOrientation = controller.screenOrientation
        self.textDocumentProxy = controller.textDocumentProxy
        self.textInputMode = controller.textInputMode
        self.traitCollection = controller.traitCollection
    }
}
