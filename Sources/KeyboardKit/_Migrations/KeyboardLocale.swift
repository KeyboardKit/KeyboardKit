import Foundation
import SwiftUI

@available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Use Locale instead.")
public typealias KeyboardLocale = Locale

@available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Use Locale instead.")
public extension KeyboardLocale {

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1.")
    init?(
        for locale: Locale
    ) {
        self = locale
    }

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Use identifier instead.")
    var id: String { identifier }

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Use keyboardKitSupported instead.")
    static var all: [Locale] {
        keyboardKitSupported
    }

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Use keyboardKitSupported instead.")
    static var allCases: [Locale] {
        keyboardKitSupported
    }

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Filter keyboardKitSupported instead.")
    static var allLtr: [Locale] {
        keyboardKitSupported.filter { $0.isLeftToRight }
    }

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Filter keyboardKitSupported instead.")
    static var allRtl: [Locale] {
        keyboardKitSupported.filter { $0.isRightToLeft }
    }
}

public extension KeyboardContext {

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Use locale instead.")
    var keyboardLocale: KeyboardLocale? { self.locale }
}

@available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1.")
public extension Collection where Element == KeyboardLocale {

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Use keyboardKitSupported instead.")
    static var all: [KeyboardLocale] {
        KeyboardLocale.all
    }

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Filter keyboardKitSupported instead.")
    static var allLtr: [KeyboardLocale] {
        KeyboardLocale.allLtr
    }

    @available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Filter keyboardKitSupported instead.")
    static var allRtl: [KeyboardLocale] {
        KeyboardLocale.allRtl
    }
}


public extension View {

    @available(*, deprecated, renamed: "localeContextMenu")
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

    @available(*, deprecated, renamed: "localeContextMenu")
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
