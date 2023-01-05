//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/**
 This class provides keyboard extensions with contextual and
 observable keyboard state.

 KeyboardKit automatically creates an instance of this class
 and sets ``KeyboardInputViewController/keyboardContext`` to
 the instance when a keyboard extension is started.
 */
public class KeyboardContext: ObservableObject {

    /**
     Create a context instance.

     - Parameters:
       - locale: The locale to use, by default `.current`.
     */
    public init(locale: Locale = .current) {
        self.locale = locale
        self.locales = [locale]
    }

    #if os(iOS) || os(tvOS)
    /**
     Create a context instance that is initially synced with
     the provided `controller` and that sets `screenSize` to
     the main screen size.

     - Parameters:
       - controller: The controller with which the context should sync, if any.
       - locale: The locale to use, by default `.current`.
     */
    convenience public init(
        controller: KeyboardInputViewController,
        locale: Locale = .current
    ) {
        self.init(locale: locale)
        self.sync(with: controller)
    }
    #endif
    
    /**
     This property can be set to `false` to stop the context
     from syncing with the vc. It is experimental and can be
     removed whenever.
     */
    public static var tempIsPreviewMode: Bool = false


    /**
     The device type that is currently used.

     By default, this is ``DeviceType/current``, but you can
     change it to anything you like.
     */
    @Published
    public var deviceType: DeviceType = .current
    
    /**
     Whether or not the input controller has a dictation key.
     */
    @Published
    public var hasDictationKey: Bool = false
    
    /**
     Whether or not the extension has been given full access.
     */
    @Published
    public var hasFullAccess: Bool = false

    /**
     An optional dictation replacement action, which will be
     used by some ``KeyboardLayoutProvider`` implementations.
     */
    @Published
    public var keyboardDictationReplacement: KeyboardAction?

    /**
     The keyboard type that is currently used.
     */
    @Published
    public var keyboardType = KeyboardType.alphabetic(.lowercased)
    
    /**
     The locale that is currently being used.
     
     This uses `Locale` instead of ``KeyboardLocale``, since
     keyboards can use locales that are not in that enum.
     */
    @Published
    public var locale: Locale
    
    /**
     The locales that are currently enabled for the keyboard.

     ``selectNextLocale()`` can be called to select the next
     locale in this list.
     */
    @Published
    public var locales: [Locale]
    
    /**
     Whether or not the keyboard should (must) have a switch
     key for selecting the next keyboard.
     */
    @Published
    public var needsInputModeSwitchKey = false

    /**
     Whether or not the context prefers autocomplete.

     The property is set every time the proxy syncs with the
     controller. You can ignore it if you want.
     */
    @Published
    public var prefersAutocomplete = true

    /**
     The primary language that is currently being used.
     */
    @Published
    public var primaryLanguage: String?


    #if os(iOS) || os(tvOS)
    /**
     The screen in which the keyboard is presented.
     */
    @Published
    @available(*, deprecated, message: "Use screenSize instead")
    public var screen = UIScreen.main
    #endif

    /**
     The screen size, which is used by some library features.
     */
    @Published
    public var screenSize = CGSize.zero
    
    #if os(iOS)
    /**
     The current screen orientation.
     */
    @Published
    public var screenOrientation: UIInterfaceOrientation = .portrait
    #endif
    
    
    #if os(iOS) || os(tvOS)
    /**
     The text document proxy that is currently active.
     */
    @Published
    public var textDocumentProxy: UITextDocumentProxy = PreviewTextDocumentProxy()
    
    /**
     The text input mode of the input controller.
     */
    @Published
    public var textInputMode: UITextInputMode?
    
    /**
     The input controller's current trait collection.
     */
    @Published
    public var traitCollection = UITraitCollection()
    #endif


    // MARK: - Deprecated

    #if os(iOS) || os(tvOS)
    @available(*, deprecated, message: "Use initializer without device instead.")
    public init(
        controller: KeyboardInputViewController? = nil,
        locale: Locale = .current,
        device: UIDevice = .current,
        screen: UIScreen = .main,
        keyboardType: KeyboardType = .alphabetic(.lowercased)
    ) {
        self.locale = locale
        self.locales = [locale]
        self.device = device
        self.screen = screen
        self.keyboardType = keyboardType
        guard let controller = controller else { return }
        self.sync(with: controller)
    }
    #endif


    // MARK: - Deprecated

    #if os(iOS) || os(tvOS)
    @available(*, deprecated, message: "Use deviceType instead.")
    public var device: UIDevice = .current
    #endif
}


// MARK: - Public Properties

#if os(iOS) || os(tvOS)
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
#endif


// MARK: - Public Functions

public extension KeyboardContext {
    
    /**
     Whether or not the context specifies that we should use
     a dark color scheme.
     */
    var hasDarkColorScheme: Bool {
        #if os(iOS) || os(tvOS)
        colorScheme == .dark
        #else
        false
        #endif
    }

    /**
     Whether or not the context has a certain locale.
     */
    func hasKeyboardLocale(_ locale: KeyboardLocale) -> Bool {
        self.locale.identifier == locale.localeIdentifier
    }

    /**
     Whether or not the context has a certain keyboard type.
     */
    func hasKeyboardType(_ type: KeyboardType) -> Bool {
        keyboardType == type
    }
    
    /**
     Select the next locale in ``locales``, depending on the
     ``locale``. If ``locale`` is last in ``locales`` or not
     in the list, the first list locale is selected.
     */
    func selectNextLocale() {
        let fallback = locales.first ?? locale
        guard let currentIndex = locales.firstIndex(of: locale) else { return locale = fallback }
        let nextIndex = currentIndex.advanced(by: 1)
        guard locales.count > nextIndex else { return locale = fallback }
        locale = locales[nextIndex]
    }

    /**
     Set ``locale`` to the provided keyboard locale's locale.
     */
    func setLocale(_ locale: KeyboardLocale) {
        self.locale = locale.locale
    }
    
    #if os(iOS) || os(tvOS)
    /**
     Sync the context with the current state of the keyboard
     input view controller.
     */
    func sync(with controller: KeyboardInputViewController) {
        if Self.tempIsPreviewMode { return }
        DispatchQueue.main.async {
            self.syncWithControllerAfterDelay(controller)
        }
    }

    func syncWithControllerAfterDelay(_ controller: KeyboardInputViewController) {
        if hasDictationKey != controller.hasDictationKey {
            hasDictationKey = controller.hasDictationKey
        }
        if hasFullAccess != controller.hasFullAccess {
            hasFullAccess = controller.hasFullAccess
        }
        if needsInputModeSwitchKey != controller.needsInputModeSwitchKey {
            needsInputModeSwitchKey = controller.needsInputModeSwitchKey
        }
        if primaryLanguage != controller.primaryLanguage {
            primaryLanguage = controller.primaryLanguage
        }
        #if os(iOS)
        if screenOrientation != controller.screenOrientation {
            screenOrientation = controller.screenOrientation
        }
        let newPrefersAutocomplete = keyboardType.prefersAutocomplete && (textDocumentProxy.keyboardType?.prefersAutocomplete ?? true)
        if prefersAutocomplete != newPrefersAutocomplete {
            prefersAutocomplete = newPrefersAutocomplete
        }
        #else
        if prefersAutocomplete != keyboardType.prefersAutocomplete {
            prefersAutocomplete = keyboardType.prefersAutocomplete
        }
        #endif
        if textDocumentProxy === controller.textDocumentProxy {} else {
            textDocumentProxy = controller.textDocumentProxy
        }
        if textInputMode != controller.textInputMode {
            textInputMode = controller.textInputMode
        }
        if traitCollection != controller.traitCollection {
            traitCollection = controller.traitCollection
        }
    }
    
    func syncAfterLayout(with controller: KeyboardInputViewController) {
        #if os(iOS)
        if controller.screenOrientation == screenOrientation { return }
        self.sync(with: controller)
        #endif
    }
    #endif
}
