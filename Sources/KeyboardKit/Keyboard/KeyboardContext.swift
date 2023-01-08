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
     */
    public init() {}

    #if os(iOS) || os(tvOS)
    /**
     Create a context instance that is initially synced with
     the provided `controller` and that sets `screenSize` to
     the main screen size.

     - Parameters:
       - controller: The controller with which the context should sync, if any.
     */
    convenience public init(
        controller: KeyboardInputViewController?
    ) {
        self.init()
        guard let controller = controller else { return }
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
     The current interface orientation.
     */
    @Published
    public var interfaceOrientation: InterfaceOrientation = .portrait

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
    public var locale = Locale.current
    
    /**
     The locales that are currently enabled for the keyboard.

     ``selectNextLocale()`` can be called to select the next
     locale in this list.
     */
    @Published
    public var locales: [Locale] = [.current]
    
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

    /**
     The screen size, which is used by some library features.
     */
    @Published
    public var screenSize = CGSize.zero
    
    
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

    #if os(iOS) || os(tvOS)
    @available(*, deprecated, message: "Use deviceType instead.")
    public var device: UIDevice = .current
    #endif

    #if os(iOS) || os(tvOS)
    @Published
    @available(*, deprecated, message: "Use screenSize instead")
    public var screen = UIScreen.main
    #endif

    #if os(iOS)
    @available(*, deprecated, renamed: "interfaceOrientation")
    public var screenOrientation: InterfaceOrientation {
        get { interfaceOrientation }
        set { interfaceOrientation = newValue }
    }
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
        if interfaceOrientation != controller.orientation {
            interfaceOrientation = controller.orientation
        }
        let newPrefersAutocomplete = keyboardType.prefersAutocomplete && (textDocumentProxy.keyboardType?.prefersAutocomplete ?? true)
        if prefersAutocomplete != newPrefersAutocomplete {
            prefersAutocomplete = newPrefersAutocomplete
        }
        if screenSize != controller.screenSize {
            screenSize = controller.screenSize
        }
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
        if controller.orientation == interfaceOrientation { return }
        self.sync(with: controller)
        #endif
    }
    #endif
}

#if os(iOS) || os(tvOS)
private extension UIInputViewController {

    var orientation: InterfaceOrientation {
        view.window?.screen.interfaceOrientation ?? .portrait
    }

    var screenSize: CGSize {
        view.window?.screen.bounds.size ?? .zero
    }
}
#endif
