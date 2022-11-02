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
 observable information. It is a central part of KeyboardKit
 and to create adaptive keyboards.
 
 KeyboardKit automatically creates an instance of this class
 and adds it to the input view controller. It will also sync
 the context with the input controller whenever needed. This
 means that significant changes are synced to a `@Published`
 property that your extension can observe.
 */
public class KeyboardContext: ObservableObject {
    
    /// Used to control how the `locales` property is initialised and maintained
    public enum LocalesSet {
        /// The default value of `locales` is the `locale` provided, and will not be updated automatically
        case main
        /// The value of `locales` will be a subset of the locales available in KeyboardKit, and the active iOS Keyboard locales. Useful when KeyboardKit is used as an inputView
        case active
        /// The default value of `locales` is all the locales available in KeyboardKit, and will not be updated
        case all
    }
    
    #if os(iOS) || os(tvOS)
    /**
     Create a context instance.

     - Parameters:
       - controller: The controller with which the context should sync, if any.
       - locale: The locale to use, by default `.current`.
       - device: The device to use, by default ``DeviceType/current``.
       - screen: The screen to use, by default `.main`.
       - keyboardType: The current keyboard tye, by default `.alphabetic(.lowercased)`
     */
    public init(
        controller: KeyboardInputViewController? = nil,
        locale: Locale = .current,
        screen: UIScreen = .main,
        keyboardType: KeyboardType = .alphabetic(.lowercased)
    ) {
        self.locale = locale
        self.locales = [locale]
        self.screen = screen
        self.keyboardType = keyboardType
        updateLocales()
        guard let controller = controller else { return }
        self.sync(with: controller)
    }
    #else
    /**
     Create a context instance.
     
     - Parameters:
       - locale: The locale to use, by default `.current`.
       - keyboardType: The current keyboard tye, by default `.alphabetic(.lowercased)`
     */
    public init(
        locale: Locale = .current,
        keyboardType: KeyboardType = .alphabetic(.lowercased)) {
        self.locale = locale
        self.locales = [locale]
        self.keyboardType = keyboardType
        updateLocales()
    }
    #endif
    
    /**
     This property can be set to `false` to stop the context
     from syncing with the vc. It is experimental and can be
     removed whenever.
     */
    public static var tempIsPreviewMode: Bool = false
    
    /// Determine if running in an App Extension or main App
    public static let isAppExtension = Bundle.main.bundlePath.hasSuffix(".appex")
    
    /// Determines how the `locales` property is initialised and maintained
    public lazy var localesSet: LocalesSet = Self.isAppExtension ? .main : .active {
        didSet {
            // force update
            Self.cachedActiveInputModes = []
            updateLocales()
        }
    }
    
    /// Used to specify when the emoji locale will be included
    public enum EmojiIncludeStrategy {
        /// The emoji locale will never be included
        case notIncluded
        /// The emoji locale will be included if present in the active keyboards
        case includedIfActive
        /// The emoji locale will always be included
        case included
    }
    /// Determines when the emoji locale will be included in the keyboard locales
    public lazy var includeEmojiInKeyboardLocales: EmojiIncludeStrategy = Self.isAppExtension ? .notIncluded : .includedIfActive
    
    /// A locale used as a placeholder for the emoji keyboard type
    private static let emojiLocale = Locale(identifier: "emoji")

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
     The keyboard type that is currently used.
     */
    @Published
    public var keyboardType: KeyboardType
    
    /**
     The locale that is currently being used.
     
     This uses `Locale` instead of ``KeyboardLocale``, since
     keyboards can use locales that are not in that enum.
     */
    @Published
    public var locale: Locale {
        didSet {
            if locale == Self.emojiLocale {
                self.keyboardType = .emojis
                self.selectNextLocale()
            }
        }
    }
    
    /**
     The locales that are currently enabled for the keyboard.

     ``selectNextLocale()`` can be called to select the next
     locale in this list.
     */
    @Published
    public var locales: [Locale]
    
    /// All locales available in KeyboardKit
    private static let allLocales = KeyboardLocale.allCases.map({ $0.locale })
    
    /// A cached copy of the active locales available in KeyboardKit
    private static var cachedActiveLocales: [Locale] = []
    /// A cached copy of the active input modes
    private static var cachedActiveInputModes: [UITextInputMode] = []
    /// Indicates if the Emoji keyboard is active
    private(set) public static var emojiActive = false
    /// The currently active locales that are available in KeyboardKit
    public static var activeLocales: [Locale] {
        guard UITextInputMode.activeInputModes != cachedActiveInputModes else { return cachedActiveLocales }
        let allKKLocales = allLocales
        var seen = Set<Locale>()
        emojiActive = false
        let locales: [Locale] = UITextInputMode.activeInputModes.compactMap({ inputMode -> Locale? in
            guard let localeIdentifier = inputMode.primaryLanguage?.replacingOccurrences(of: "-", with: "_") else {
                return nil
            }
            guard localeIdentifier != "emoji" else {
                emojiActive = true
                return Self.emojiLocale
            }
            var found = allKKLocales.first(where: { $0.identifier == localeIdentifier })
            if found == nil, let index = localeIdentifier.firstIndex(of: "_") {
                let shortIdentifier = localeIdentifier.prefix(upTo: index)
                found = allKKLocales.first(where: { $0.identifier == shortIdentifier })
            }
            // deduplicate while maintaining order
            guard let found = found, seen.insert(found).inserted else { return nil }
            return found
        })
        cachedActiveInputModes = UITextInputMode.activeInputModes
        cachedActiveLocales = locales.count == 0 ? [KeyboardLocale.english.locale] : locales
        return cachedActiveLocales
    }
    
    /// Update the locales avaiable on this context
    open func updateLocales() {
        var locales: [Locale]
        switch localesSet {
        case .main: return
        case .active:
            locales = Self.activeLocales
        case .all:
            locales = Self.allLocales
        }
        let index = locales.firstIndex(of: Self.emojiLocale)
        switch includeEmojiInKeyboardLocales {
        case .notIncluded:
            if let index = index { locales.remove(at: index) }
        case .includedIfActive: break
        case .included:
            if index == nil { locales.append(Self.emojiLocale) }
        }
        self.locales = locales
    }
    
    /**
     Whether or not the keyboard should (must) have a switch
     key for selecting the next keyboard.
     */
    @Published
    public var needsInputModeSwitchKey: Bool = false
    
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
    public var screen: UIScreen
    #endif
    
    
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
    public var traitCollection: UITraitCollection = UITraitCollection()
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
        // need to update locales here in case the active locales have changed (no way to get notified when they do)
        updateLocales()
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
            self.hasDictationKey = controller.hasDictationKey
            self.hasFullAccess = controller.hasFullAccess
            self.needsInputModeSwitchKey = controller.needsInputModeSwitchKey
            self.primaryLanguage = controller.primaryLanguage
            #if os(iOS)
            self.screenOrientation = controller.screenOrientation
            #endif
            self.textDocumentProxy = controller.textDocumentProxy
            self.textInputMode = controller.textInputMode
            self.traitCollection = controller.traitCollection
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
