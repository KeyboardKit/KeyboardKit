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

/// This class has observable states and persistent settings.
///
/// This class syncs with ``KeyboardInputViewController`` to
/// keep up to date. It's extensively used in the library to
/// make state-based decisions.
///
/// The class can actively affect the keyboard. For instance,
/// setting the ``keyboardType`` will cause a ``KeyboardView``
/// to automatically rendered supported keyboard types.
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

    public init() {
        syncAutocapitalizationWithSetting()
        locale = .init(identifier: localeIdentifier)
    }


    // MARK: - Settings

    /// The settings key prefix to use for this namespace.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "keyboard")
    }

    /// A list of explicitly added locale identifiers, which
    /// shouldn't be confused with all available ``locales``.
    ///
    /// The ``selectNextLocale()`` function and context menu
    /// will use this list if it has locales, else ``locales``.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)addedLocaleIdentifiers", store: .keyboardSettings)
    public var addedLocaleIdentifiersValue: Keyboard.StorageValue<[String]> = .init(value: [])

    /// Whether autocapitalization is enabled.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)isAutocapitalizationEnabled", store: .keyboardSettings)
    public var isAutocapitalizationEnabled = true {
        didSet { syncAutocapitalizationWithSetting() }
    }

    /// The locale identifier that is currently being used.
    ///
    /// Use ``locale`` or any locale setter to set this.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)localeIdentifier", store: .keyboardSettings)
    public private(set) var localeIdentifier = Locale.current.identifier


    // MARK: - Temporary overrides

    /// Set this to override ``autocapitalizationType``.
    @Published
    public var autocapitalizationTypeOverride: Keyboard.AutocapitalizationType?

    /// Set this to override ``returnKeyType``.
    @Published
    public var returnKeyTypeOverride: Keyboard.ReturnKeyType?


    // MARK: - Published Properties

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
    public var keyboardType = Keyboard.KeyboardType.alphabetic(.auto)

    /// The current locale.
    ///
    /// > Note: Settings this will update ``localeIdentifier``
    /// and cause it to persist.
    @Published
    public var locale = Locale.current {
        didSet {
            guard localeIdentifier != locale.identifier else { return }
            localeIdentifier = locale.identifier
        }
    }

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
    ///
    /// > Note: This will become a computed property in 9.0.
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
    public var textInputProxy: UITextDocumentProxy?


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
    /// This value comes from the ``textDocumentProxy``, but
    /// ``autocapitalizationTypeOverride`` can override it.
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
