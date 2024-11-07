import Foundation
import SwiftUI

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use Locale instead.")
public typealias KeyboardLocale = Locale

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use Locale instead.")
public extension KeyboardLocale {

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1.")
    init?(
        for locale: Locale
    ) {
        self = locale
    }

    @available(*, deprecated, renamed: "identifier", message: "Migration Deprecation, will be removed in 9.1!")
    var id: String { identifier }

    @available(*, deprecated, renamed: "keyboardKitSupported", message: "Migration Deprecation, will be removed in 9.1!")
    static var all: [Locale] {
        keyboardKitSupported
    }

    @available(*, deprecated, renamed: "keyboardKitSupported", message: "Migration Deprecation, will be removed in 9.1!")
    static var allCases: [Locale] {
        keyboardKitSupported
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Filter keyboardKitSupported instead.")
    static var allLtr: [Locale] {
        keyboardKitSupported.filter { $0.isLeftToRight }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Filter keyboardKitSupported instead.")
    static var allRtl: [Locale] {
        keyboardKitSupported.filter { $0.isRightToLeft }
    }
}

public extension KeyboardContext {

    @available(*, deprecated, renamed: "locale", message: "Migration Deprecation, will be removed in 9.1!")
    var keyboardLocale: KeyboardLocale? { self.locale }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in KeyboardKit 9.1!")
public extension Collection where Element == KeyboardLocale {

    @available(*, deprecated, renamed: "keyboardKitSupported", message: "Migration Deprecation, will be removed in 9.1!")
    static var all: [KeyboardLocale] {
        KeyboardLocale.all
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
    static var allLtr: [KeyboardLocale] {
        KeyboardLocale.allLtr
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
    static var allRtl: [KeyboardLocale] {
        KeyboardLocale.allRtl
    }
}


public extension View {

    @available(*, deprecated, renamed: "localeContextMenu", message: "Migration Deprecation, will be removed in 9.1!")
    func keyboardLocaleContextMenu(
        for context: KeyboardContext,
        locales: [Locale]? = nil,
        tapAction: @escaping () -> Void
    ) -> some View {
        localeContextMenu(
            for: context,
            locales: locales,
            tapAction: tapAction
        )
    }

    @available(*, deprecated, renamed: "localeContextMenu", message: "Migration Deprecation, will be removed in 9.1!")
    func keyboardLocaleContextMenu<ButtonView: View>(
        for context: KeyboardContext,
        locales: [Locale]? = nil,
        tapAction: @escaping () -> Void,
        menuItem: @escaping (Locale) -> ButtonView
    ) -> some View {
        localeContextMenu(
            for: context,
            locales: locales,
            tapAction: tapAction,
            menuItem: menuItem
        )
    }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in KeyboardKit 9.1.")
public protocol KeyboardLocaleInfo {

    /// The native ``Foundation/Locale`` value.
    var locale: Locale { get }

    /// The locale identifier.
    var localeIdentifier: String { get }

    /// The locale language code.
    var localeLanguageCode: String { get }

    /// The full name of this locale in its own language.
    var localizedName: String? { get }

    /// The full name of this locale in another locale.
    func localizedName(in locale: Locale) -> String?

    /// The language name of this locale in its own language.
    var localizedLanguageName: String? { get }

    /// The language name of this locale in another locale.
    func localizedLanguageName(in locale: Locale) -> String?
}


// MARK: - Implementing Types

@available(*, deprecated, message: "Migration Deprecation, will be removed in KeyboardKit 9.1.")
extension Locale: KeyboardLocaleInfo {}

@available(*, deprecated, message: "Migration Deprecation, will be removed in KeyboardKit 9.1.")
public extension Locale {

    var locale: Locale { self }
    var localeIdentifier: String { identifier }
    var localeLanguageCode: String { languageCode ?? "" }
}
