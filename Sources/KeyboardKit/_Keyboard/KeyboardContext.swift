//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/// This class has observable states and persistent settings
/// for the core keyboard functionality.
///
/// This class syncs with ``KeyboardInputViewController`` to
/// keep up to date. It's extensively used in the library to
/// make state-based decisions, and automatically update the
/// ``KeyboardView`` whenever the context changes.
///
/// You can use ``locale`` to get and set the current locale,
/// which also affects the keyboard primary language.
///
/// You can use ``locales`` to define which locales that you
/// want to enable for the keyboard. This list is used until
/// you add any locales to ``KeyboardSettings/addedLocales``,
/// which then takes precedene over ``locales``. You can use
/// ``enabledLocales`` to resolve the valid, underlying list.
/// If ``enabledLocales`` has multiple locales, you can loop
/// through the collection with ``selectNextLocale()``.
///
/// This class also has observable auto-persisted ``settings``
/// that can be used to configure the behavior and presented
/// to users in e.g. a settings screen.
///
/// KeyboardKit set up an instance of this class and injects
/// it as an environment value when you set up your main app
/// and keyboard as described in <doc:Getting-Started>.
public class KeyboardContext: ObservableObject {

    public init() {
        settings = .init()
        settings = .init(onAutocapitalizationEnabledChanged: syncAutocapitalizationWithSetting)
        syncAutocapitalizationWithSetting()
        locale = .init(identifier: settings.localeIdentifier)
    }


    // MARK: - Settings

    /// Auto-persisted keyboard settings.
    @Published public var settings: KeyboardSettings


    // MARK: - Temporary overrides

    /// Set this to override ``autocapitalizationType``.
    @Published public var autocapitalizationTypeOverride: Keyboard.AutocapitalizationType?

    /// Set this to override ``returnKeyType``.
    @Published public var returnKeyTypeOverride: Keyboard.ReturnKeyType?


    // MARK: - Published Properties

    /// The app for which the context is set up, if any.
    @Published public var app: KeyboardApp?

    /// The current device type.
    @Published public var deviceType: DeviceType = .current

    /// The current device type to use for keyboard visualization.
    @Published public var deviceTypeForKeyboard: DeviceType = .current

    /// Whether the keyboard has a dictation key.
    @Published public var hasDictationKey: Bool = false

    /// Whether the extension has full access.
    #if os(iOS) || os(tvOS) || os(visionOS)
    @Published public var hasFullAccess = UIInputViewController().hasFullAccess
    #else
    @Published public var hasFullAccess: Bool = false
    #endif

    /// The bundle ID of the keyboard host application.
    @Published public var hostApplicationBundleId: String?

    /// The current interface orientation.
    @Published public var interfaceOrientation: InterfaceOrientation = .portrait

    /// Whether the keyboard is collapsed.
    @Published public var isKeyboardCollapsed = false

    /// Whether the keyboard is in floating mode.
    @Published public var isKeyboardFloating = false

    /// Whether a space drag gesture is active.
    @Published public var isSpaceDragGestureActive = false

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

    /// The keyboard case that is currently used.
    @Published public var keyboardCase = Keyboard.KeyboardCase.auto

    /// An optional dictation replacement action.
    @Published public var keyboardDictationReplacement: KeyboardAction?
    
    /// The current keyboard layout type, if any.
    @Published public var keyboardLayoutType: Keyboard.LayoutType? {
        didSet { settings.keyboardLayoutTypeIdentifier = keyboardLayoutType?.id }
    }

    /// The keyboard type that is currently used.
    @Published public var keyboardType = Keyboard.KeyboardType.alphabetic

    /// The current locale, by default `.current`.
    @Published public var locale = Locale.current {
        didSet { settings.localeIdentifier = locale.identifier }
    }

    /// The locales that are enabled for the keyboard.
    @Published public var locales: [Locale] = [.current]

    /// The locale to use to localize other locale names. If
    /// this is `nil`, each locale will use its own language.
    @Published public var localePresentationLocale: Locale? = .current

    /// Whether to add an input mode switch key.
    @Published public var needsInputModeSwitchKey = false

    /// The primary language that is currently being used.
    @Published public var primaryLanguage: String?

    /// The current screen size (avoid using this).
    @Published public var screenSize = CGSize.zero


    #if os(iOS) || os(tvOS) || os(visionOS)

    // MARK: - iOS/tvOS proxy properties

    /// The original text document proxy.
    @Published public var originalTextDocumentProxy: UITextDocumentProxy = .preview

    /// The text document proxy that is currently active.
    public var textDocumentProxy: UITextDocumentProxy {
        textInputProxy ?? originalTextDocumentProxy
    }

    /// A custom text proxy to which text can be routed.
    @Published public var textInputProxy: UITextDocumentProxy?


    // MARK: - iOS/tvOS properties

    /// The text input mode of the input controller.
    @Published public var textInputMode: UITextInputMode?

    /// The current trait collection.
    @Published public var traitCollection = UITraitCollection()
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


// MARK: - Public Computed Properties

public extension KeyboardContext {

    /// The autocapitalization type to use.
    ///
    /// This value comes from the ``textDocumentProxy``, but
    /// ``autocapitalizationTypeOverride`` can override it.
    var autocapitalizationType: Keyboard.AutocapitalizationType? {
        #if os(iOS) || os(tvOS) || os(visionOS)
        autocapitalizationTypeOverride ?? textDocumentProxy.autocapitalizationType?.keyboardType
        #else
        autocapitalizationTypeOverride ?? nil
        #endif
    }

    /// Whether to use a dark color scheme.
    var hasDarkColorScheme: Bool {
        #if os(iOS) || os(tvOS) || os(visionOS)
        colorScheme == .dark
        #else
        false
        #endif
    }

    /// Whether the context has multiple locales.
    var hasMultipleLocales: Bool {
        locales.count > 1
    }

    /// Whether the context prefers autocomplete.
    var prefersAutocomplete: Bool {
        #if os(iOS) || os(tvOS) || os(visionOS)
        let proxy = textDocumentProxy.keyboardType?.prefersAutocomplete
        let proxyPrefers = proxy ?? true
        return keyboardType.prefersAutocomplete && proxyPrefers
        #else
        keyboardType.prefersAutocomplete
        #endif
    }

    /// The return key type type to use.
    ///
    /// This value comes from the ``textDocumentProxy``, but
    /// ``returnKeyTypeOverride`` can override it.
    var returnKeyType: Keyboard.ReturnKeyType? {
        #if os(iOS) || os(tvOS) || os(visionOS)
        returnKeyTypeOverride ?? textDocumentProxy.returnKeyType?.keyboardType
        #else
        returnKeyTypeOverride ?? nil
        #endif
    }
}
