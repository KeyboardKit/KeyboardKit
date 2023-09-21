//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/**
 This class provides keyboard extensions with contextual and
 observable information about the keyboard extension itself.

 You can use ``locale`` to get and set the raw locale of the
 keyboard or use the various `setLocale(...)` functions that
 support using both `Locale` and ``KeyboardLocale``. You can
 use ``locales`` to set all the available locales, then call
 ``selectNextLocale()`` to select the next available locale.

 KeyboardKit automatically creates an instance of this class
 and binds the created instance to the keyboard controller's
 ``KeyboardInputViewController/keyboardContext``.
 */
public class KeyboardContext: ObservableObject {

    /// Create a standard context instance.
    public init() {}

    #if os(iOS) || os(tvOS)
    /**
     Create a context instance that is initially synced with
     the provided `controller`.

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
     A manually set autocapitalization type, which overrides
     the ``autocapitalizationType`` value when it's set.
     
     This context is currently not that clear about which of
     its properties that are synced with the proxy each time
     the text changes. If it's not needed, because the proxy
     properties stay the same, we could remove this.
     */
    @Published
    public var autocapitalizationTypeOverride: Keyboard.AutocapitalizationType?

    /// The current device type.
    @Published
    public var deviceType: DeviceType = .current

    /// Whether or not the keyboard has a dictation key.
    @Published
    public var hasDictationKey: Bool = false

    /// Whether or not the extension has full access.
    @Published
    public var hasFullAccess: Bool = false

    /// The current interface orientation.
    @Published
    public var interfaceOrientation: InterfaceOrientation = .portrait

    /**
     Whether or not autocapitalization is enabled.
     
     This property can be used to disable autocapitalization
     without affecting the ``autocapitalizationType``.
     */
    @Published
    public var isAutoCapitalizationEnabled = true

    /// Whether or not the keyboard is in floating mode.
    @Published
    public var isKeyboardFloating = false

    /**
     An optional dictation replacement action, which will be
     used by some ``KeyboardLayoutProvider`` implementations.
     */
    @Published
    public var keyboardDictationReplacement: KeyboardAction?

    /// The keyboard type that is currently used.
    @Published
    public var keyboardType = Keyboard.KeyboardType.alphabetic(.lowercased)

    /**
     The locale that is currently being used.

     This uses `Locale` instead of ``KeyboardLocale``, since
     keyboards can use locales that are not in that enum.
     */
    @Published
    public var locale = Locale.current

    /**
     The locales that are currently enabled for the keyboard.
     */
    @Published
    public var locales: [Locale] = [.current]

    /**
     An custom locale to use when displaying other locales.

     If no locale is specified, the ``locale`` will be used.
     */
    @Published
    public var localePresentationLocale: Locale?

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

    /// The primary language that is currently being used.
    @Published
    public var primaryLanguage: String?

    /// The current screen size (avoid using this).
    @Published
    public var screenSize = CGSize.zero

    /// The space long press behavior to use.
    @Published
    public var spaceLongPressBehavior = Gestures.SpaceLongPressBehavior.moveInputCursor


    #if os(iOS) || os(tvOS)
    /// The main text document proxy.
    @Published
    public var mainTextDocumentProxy: UITextDocumentProxy = KeyboardPreviews.TextDocumentProxy()

    /// The text document proxy that is currently active.
    @Published
    public var textDocumentProxy: UITextDocumentProxy = KeyboardPreviews.TextDocumentProxy()

    /// The text input mode of the input controller.
    @Published
    public var textInputMode: UITextInputMode?

    /// The input controller's current trait collection.
    @Published
    public var traitCollection = UITraitCollection()
    #endif
}


// MARK: - Public iOS/tvOS Properties

#if os(iOS) || os(tvOS)
public extension KeyboardContext {

    /// The current trait collection's color scheme.
    var colorScheme: ColorScheme {
        traitCollection.userInterfaceStyle == .dark ? .dark : .light
    }

    /// The current keyboard appearance.
    var keyboardAppearance: UIKeyboardAppearance {
        textDocumentProxy.keyboardAppearance ?? .default
    }
}
#endif


// MARK: - Public Properties

public extension KeyboardContext {

    /**
     The autocapitalization type to use.

     This is by default fetched from the text document proxy.
     You can use ``autocapitalizationTypeOverride`` to apply
     a custom value that overrides the default one.
     */
    var autocapitalizationType: Keyboard.AutocapitalizationType? {
        #if os(iOS) || os(tvOS)
        autocapitalizationTypeOverride ?? textDocumentProxy.autocapitalizationType?.keyboardType
        #else
        autocapitalizationTypeOverride ?? nil
        #endif
    }

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
     Try to map the current ``locale`` to a keyboard locale.
     */
    var keyboardLocale: KeyboardLocale? {
        KeyboardLocale.allCases.first { $0.localeIdentifier == locale.identifier }
    }
}


// MARK: - Public Functions

public extension KeyboardContext {

    /// Whether or not the context has multiple locales.
    var hasMultipleLocales: Bool {
        locales.count > 1
    }

    /// Whether or not the context has a certain locale.
    func hasKeyboardLocale(_ locale: KeyboardLocale) -> Bool {
        self.locale.identifier == locale.localeIdentifier
    }

    /// Whether or not a certain keyboard type is selected.
    func hasKeyboardType(_ type: Keyboard.KeyboardType) -> Bool {
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

    /// Set ``keyboardType`` to the provided type.
    func setKeyboardType(_ type: Keyboard.KeyboardType) {
        keyboardType = type
    }

    /// Set ``locale`` to the provided locale.
    func setLocale(_ locale: Locale) {
        self.locale = locale
    }

    /// Set ``locale`` to the provided keyboard locale.
    func setLocale(_ locale: KeyboardLocale) {
        self.locale = locale.locale
    }

    /// Set ``locales`` to the provided locales.
    func setLocales(_ locales: [Locale]) {
        self.locales = locales
    }

    /// Set ``locales`` to the provided keyboard locales.
    func setLocales(_ locales: [KeyboardLocale]) {
        self.locales = locales.map { $0.locale }
    }
}

// MARK: - iOS/tvOS syncing

#if os(iOS) || os(tvOS)
extension KeyboardContext {

    /// Sync the context with the provided input controller.
    func sync(with controller: KeyboardInputViewController) {
        DispatchQueue.main.async {
            self.syncAfterAsync(with: controller)
        }
    }

    /**
     Perform this after an async delay, to make sure that we
     have the latest information.
     */
    func syncAfterAsync(with controller: KeyboardInputViewController) {
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

        let keyboardPrefersAutocomplete = textDocumentProxy.keyboardType?.prefersAutocomplete ?? true
        let returnKeyPrefersAutocomplete = textDocumentProxy.returnKeyType?.prefersAutocomplete ?? true
        let newPrefersAutocomplete = keyboardType.prefersAutocomplete && keyboardPrefersAutocomplete && returnKeyPrefersAutocomplete
        if prefersAutocomplete != newPrefersAutocomplete {
            prefersAutocomplete = newPrefersAutocomplete
        }

        if screenSize != controller.screenSize {
            screenSize = controller.screenSize
        }
        if mainTextDocumentProxy === controller.mainTextDocumentProxy {} else {
            mainTextDocumentProxy = controller.mainTextDocumentProxy
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
        syncIsFloating(with: controller)
        if controller.orientation == interfaceOrientation { return }
        sync(with: controller)
    }

    /// Perform a sync to check if the keyboard is floating.
    func syncIsFloating(with controller: KeyboardInputViewController) {
        let isFloating = controller.view.frame.width < screenSize.width/2
        if isKeyboardFloating == isFloating { return }
        isKeyboardFloating = isFloating
    }
}

private extension UIInputViewController {

    var orientation: InterfaceOrientation {
        view.window?.screen.interfaceOrientation ?? .portrait
    }

    var screenSize: CGSize {
        view.window?.screen.bounds.size ?? .zero
    }
}
#endif
