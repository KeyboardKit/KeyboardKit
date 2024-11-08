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
/// make state-based decisions, and automatically update the
/// ``KeyboardView`` whenever the context changes.
///
/// You can use ``locale`` to get and set the current locale.
/// If ``locales`` or the ``KeyboardContext/settings-swift.property``
/// added locales have multiple values, ``selectNextLocale()``
/// will toggle through these.
///
/// This class also has observable auto-persisted ``settings``
/// that can be used to configure the behavior and presented
/// to users in e.g. a settings screen.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value.
public class KeyboardContext: ObservableObject {

    public init() {
        settings = .init()
        settings = .init(onAutocapitalizationEnabledChanged: syncAutocapitalizationWithSetting)
        syncAutocapitalizationWithSetting()
        locale = .init(identifier: settings.localeIdentifier)
    }


    // MARK: - Settings

    /// Keyboard-specific, auto-persisted settings.
    @Published
    public var settings: Settings


    // MARK: - Temporary overrides

    /// Set this to override ``autocapitalizationType``.
    @Published
    public var autocapitalizationTypeOverride: Keyboard.AutocapitalizationType?

    /// Set this to override ``returnKeyType``.
    @Published
    public var returnKeyTypeOverride: Keyboard.ReturnKeyType?


    // MARK: - Published Properties

    /// The app for which the context is set up, if any.
    @Published
    public var app: KeyboardApp?

    /// The current device type.
    @Published
    public var deviceType: DeviceType = .current

    /// The current device type to use for keyboard visualization.
    @Published
    public var deviceTypeForKeyboard: DeviceType = .current

    /// Whether the keyboard has a dictation key.
    @Published
    public var hasDictationKey: Bool = false

    /// Whether the extension has full access.
    @Published
    public var hasFullAccess: Bool = false

    /// The bundle ID of the keyboard host application.
    @Published
    public var hostApplicationBundleId: String?

    /// The current interface orientation.
    @Published
    public var interfaceOrientation: InterfaceOrientation = .portrait

    /// Whether the keyboard is collapsed.
    @Published
    public var isKeyboardCollapsed = false

    /// Whether the keyboard is in floating mode.
    @Published
    public var isKeyboardFloating = false

    /// Whether a space drag gesture is active.
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

    /// The keyboard case that is currently used.
    @Published
    public var keyboardCase = Keyboard.KeyboardCase.auto

    /// An optional dictation replacement action.
    @Published
    public var keyboardDictationReplacement: KeyboardAction?

    /// The keyboard type that is currently used.
    @Published
    public var keyboardType = Keyboard.KeyboardType.alphabetic

    /// The current locale, by default `.current`.
    ///
    /// > Note: Settings this will update ``localeIdentifier``
    /// and cause it to persist.
    @Published
    public var locale = Locale.current {
        didSet { settings.updateLocaleIdentifier(locale.identifier) }
    }

    /// The locales that are currently available.
    @Published
    public var locales: [Locale] = [.current]

    /// The locale to use when displaying other locales.
    @Published
    public var localePresentationLocale = Locale.current

    /// Whether to add an input mode switch key.
    @Published
    public var needsInputModeSwitchKey = false

    /// Whether the context prefers autocomplete.
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

    /// The current trait collection.
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
