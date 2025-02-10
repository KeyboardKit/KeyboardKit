//
//  KeyboardContext+Locales.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {
    
    /// This enum defines various enabled locale datasources.
    enum EnabledLocalesDataSource: KeyboardModel {
        case added, context
    }
    
    /// The ``KeyboardSettings/addedLocales``, or the static
    /// ``locales`` if there are no added ones.
    var enabledLocales: [Locale] {
        let added = enabledLocalesDataSource == .added
        return added ? settings.addedLocales.compactMap { $0.locale } : locales
    }
    
    /// The ``enabledLocales`` data source.
    var enabledLocalesDataSource: EnabledLocalesDataSource {
        settings.hasAddedLocales ? .added : .context
    }
    
    /// Whether the context has multiple ``enabledLocales``.
    var hasMultipleEnabledLocales: Bool {
        enabledLocales.count > 1
    }
    
    /// Whether to add a locale context menu to the spacebar.
    var shouldAddLocaleContextMenuToSpaceBar: Bool {
        guard hasMultipleEnabledLocales else { return false }
        return settings.spaceTrailingAction == .localeContextMenu
    }
    
    /// Select a locale with an optional layout type.
    func selectLocale(_ locale: Locale, layoutType: Keyboard.LayoutType? = nil) {
        self.locale = locale
        self.keyboardLayoutType = layoutType
    }
    
    /// Select a locale from ``enabledLocales``.
    func selectLocale(at index: Int) {
        let isAdded = enabledLocalesDataSource == .added
        if isAdded { return selectLocaleFromAddedLocales(at: index) }
        return selectLocaleFromContextLocales(at: index)
    }
    
    /// Select a locale from ``KeyboardSettings/addedLocales``.
    func selectLocaleFromAddedLocales(at index: Int) {
        let locales = settings.addedLocales
        guard locales.validateIndex(index) else { return }
        let locale = locales[index]
        selectLocale(locale.locale ?? .english, layoutType: locale.layoutType)
    }
    
    /// Select a locale from ``locales``.
    func selectLocaleFromContextLocales(at index: Int) {
        guard locales.validateIndex(index) else { return }
        self.selectLocale(locales[index], layoutType: nil)
    }
    
    /// Select the next locale from ``enabledLocales``.
    func selectNextLocale() {
        let isAdded = enabledLocalesDataSource == .added
        if isAdded { return selectNextLocaleFromAddedLocales() }
        selectNextLocaleFromContextLocales()
    }
    
    /// Select the next locale from ``KeyboardSettings/addedLocales``.
    func selectNextLocaleFromAddedLocales() {
        let locales = settings.addedLocales
        if locales.isEmpty { return }
        let count = locales.count
        let layout = keyboardLayoutType
        let index = locales.firstIndex(of: locale, layoutType: layout) ?? count
        let isLast = index >= count - 1
        selectLocaleFromAddedLocales(at: isLast ? 0 : index.advanced(by: 1))
    }
    
    /// Select the next locale from ``enabledLocales``.
    func selectNextLocaleFromContextLocales() {
        if locales.isEmpty { return }
        let count = locales.count
        let index = locales.firstIndex(of: locale) ?? count
        let isLast = index >= count - 1
        selectLocaleFromContextLocales(at: isLast ? 0 : index.advanced(by: 1))
    }
}

private extension Array {
    
    func validateIndex(_ index: Int) -> Bool {
        index >= 0 && index < count
    }
}
