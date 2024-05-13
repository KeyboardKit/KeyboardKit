//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/// This class has observable, keyboard-related state.
///
/// This class syncs with ``KeyboardInputViewController`` to
/// keep itself up to date. It's extensively used within the
/// library to make state-based decisions. For instance, you
/// can check the current device type, interface orientation,
/// full access state, etc.
///
/// This class also has properties that you can actively set
/// to affect the keyboard. For instance, the ``keyboardType``
/// can be used to change what kind of keyboard to use. This
/// is e.g. automatically used by ``SystemKeyboard``.
///
/// You can use ``locale`` to get and set the current locale
/// or use ``KeyboardLocale``-based properties and functions
/// for more convenience. If ``locales`` has multiple values,
/// ``selectNextLocale()`` will toggle through these locales.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value
/// into the view hierarchy.
public class KeyboardContext: ObservableObject {

    public init() {}

    
    // MARK: - Published Properties
    
    /// Set this to override the ``autocapitalizationType``.
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

    /// The bundle ID of the keyboard host application.
    @Published
    public var hostApplicationBundleId: String?
    
    /// The current interface orientation.
    @Published
    public var interfaceOrientation: InterfaceOrientation = .portrait

    /// Whether or not autocapitalization is enabled.
    @Published
    public var isAutoCapitalizationEnabled = true

    /// Whether or not the keyboard is in floating mode.
    @Published
    public var isKeyboardFloating = false
    
    /// Whether or not a space drag gesture is active.
    @Published
    public var isSpaceDragGestureActive = false
    
    func setIsSpaceDragGestureActive(
        _ value: Bool,
        animated: Bool
    ) {
        if animated {
            withAnimation { isSpaceDragGestureActive = value }
        } else {
            isSpaceDragGestureActive = value
        }
    }

    /// An optional dictation replacement action.
    @Published
    public var keyboardDictationReplacement: KeyboardAction?

    /// The keyboard type that is currently used.
    @Published
    public var keyboardType = Keyboard.KeyboardType.alphabetic(.lowercased)

    /// The locale that is currently being used.
    @Published
    public var locale = Locale.current

    /// The locales that are currently available.
    @Published
    public var locales: [Locale] = [.current]

    /// The locale to use when displaying other locales.
    @Published
    public var localePresentationLocale: Locale?

    /// Whether or not to add an input mode switch key.
    @Published
    public var needsInputModeSwitchKey = false

    /// Whether or not the context prefers autocomplete.
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
    
    
    #if os(iOS) || os(tvOS) || os(visionOS)
    
    // MARK: - iOS/tvOS proxy properties
    
    /// The original text document proxy.
    @Published
    public var originalTextDocumentProxy: UITextDocumentProxy = .preview

    /// The text document proxy that is currently active.
    public var textDocumentProxy: UITextDocumentProxy {
        textInputProxy ?? originalTextDocumentProxy
    }
    
    /// A custom text proxy to which text can be routed.
    @Published
    public var textInputProxy: TextInputProxy?
    
    
    // MARK: - iOS/tvOS properties

    /// The text input mode of the input controller.
    @Published
    public var textInputMode: UITextInputMode?

    /// The input controller's current trait collection.
    @Published
    public var traitCollection = UITraitCollection()
    #endif
}


// MARK: - Public iOS/tvOS Properties

#if os(iOS) || os(tvOS) || os(visionOS)
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

    /// The autocapitalization type to use.
    ///
    /// This value comes from the ``textDocumentProxy``. The
    /// ``autocapitalizationTypeOverride`` value can be used
    /// to overrides this property.
    var autocapitalizationType: Keyboard.AutocapitalizationType? {
        #if os(iOS) || os(tvOS) || os(visionOS)
        autocapitalizationTypeOverride ?? textDocumentProxy.autocapitalizationType?.keyboardType
        #else
        autocapitalizationTypeOverride ?? nil
        #endif
    }

    /// Whether or not to use a dark color scheme.
    var hasDarkColorScheme: Bool {
        #if os(iOS) || os(tvOS) || os(visionOS)
        colorScheme == .dark
        #else
        false
        #endif
    }
    
    /// Whether or not the context has multiple locales.
    var hasMultipleLocales: Bool {
        locales.count > 1
    }

    /// Map the current ``locale`` to a ``KeyboardLocale``.
    var keyboardLocale: KeyboardLocale? {
        let match = KeyboardLocale.allCases.first { $0.matches(locale) }
        let fuzzy = KeyboardLocale.allCases.first { $0.matchesLanguage(in: locale) }
        return match ?? fuzzy
    }
}


// MARK: - Public Functions

public extension KeyboardContext {

    /// Whether or not the context has a certain locale.
    func hasKeyboardLocale(
        _ locale: KeyboardLocale
    ) -> Bool {
        self.locale.identifier == locale.localeIdentifier
    }

    /// Whether or not a certain keyboard type is selected.
    func hasKeyboardType(
        _ type: Keyboard.KeyboardType
    ) -> Bool {
        keyboardType == type
    }

    /// Select the next locale in ``locales``.
    ///
    /// This will loop through all locales in ``locales``.
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

#if os(iOS) || os(tvOS) || os(visionOS)
public extension KeyboardContext {
    
    /// Sync the context with the provided input controller.
    func sync(with controller: KeyboardInputViewController) {
        DispatchQueue.main.async {
            self.syncAfterAsync(with: controller)
        }
    }
    
    /// Sync the ``originalTextDocumentProxy``.
    func syncTextDocumentProxy(with controller: KeyboardInputViewController) {
        if originalTextDocumentProxy === controller.originalTextDocumentProxy { return }
        DispatchQueue.main.async {
            self.originalTextDocumentProxy = controller.originalTextDocumentProxy
        }
    }
    
    /// Sync the ``textInputProxy``.
    func syncTextInputProxy(with controller: KeyboardInputViewController) {
        if textInputProxy === controller.textInputProxy { return }
        DispatchQueue.main.async {
            self.textInputProxy = controller.textInputProxy
        }
    }
}

extension KeyboardContext {

    /// Perform a sync after an async delay.
    func syncAfterAsync(with controller: KeyboardInputViewController) {
        syncTextDocumentProxy(with: controller)
        syncTextInputProxy(with: controller)
        
        if hasDictationKey != controller.hasDictationKey {
            hasDictationKey = controller.hasDictationKey
        }
        
        if hasFullAccess != controller.hasFullAccess {
            hasFullAccess = controller.hasFullAccess
        }
        
        if hostApplicationBundleId != controller.hostApplicationBundleId {
            hostApplicationBundleId = controller.hostApplicationBundleId
        }
        
        if interfaceOrientation != controller.orientation {
            interfaceOrientation = controller.orientation
        }
        
        if needsInputModeSwitchKey != controller.needsInputModeSwitchKey {
            needsInputModeSwitchKey = controller.needsInputModeSwitchKey
        }
        
        let keyboardPrefersAutocomplete = textDocumentProxy.keyboardType?.prefersAutocomplete ?? true
        let returnKeyPrefersAutocomplete = textDocumentProxy.returnKeyType?.prefersAutocomplete ?? true
        let newPrefersAutocomplete = keyboardType.prefersAutocomplete && keyboardPrefersAutocomplete && returnKeyPrefersAutocomplete
        if prefersAutocomplete != newPrefersAutocomplete {
            prefersAutocomplete = newPrefersAutocomplete
        }
        
        if primaryLanguage != controller.primaryLanguage {
            primaryLanguage = controller.primaryLanguage
        }
        
        if screenSize != controller.screenSize {
            screenSize = controller.screenSize
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
        #if os(iOS) || os(tvOS)
        view.window?.screen.interfaceOrientation ?? .portrait
        #else
        .portrait
        #endif
    }

    var screenSize: CGSize {
        #if os(iOS) || os(tvOS)
        view.window?.screen.bounds.size ?? .zero
        #else
        .zero
        #endif
    }
}
#endif
