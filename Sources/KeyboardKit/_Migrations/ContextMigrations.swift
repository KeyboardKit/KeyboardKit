import Foundation
import SwiftUI

public extension KeyboardContext {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Just use an equality check instead.")
    func hasCurrentLocale(_ locale: Locale) -> Bool {
        self.locale == locale
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Just use an equality check instead.")
    func hasKeyboardType(_ type: Keyboard.KeyboardType) -> Bool {
        keyboardType == type
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Just set the property instead.")
    func setKeyboardType(_ type: Keyboard.KeyboardType) {
        keyboardType = type
    }


    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use the behavior instead.")
    var preferredKeyboardType: Keyboard.KeyboardType { keyboardType }


    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    static var settingsPrefix: String { Settings.settingsPrefix }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var addedLocaleIdentifiersValue: Keyboard.StorageValue<[String]> {
        get { settings.addedLocaleIdentifiersValues }
        set { settings.addedLocaleIdentifiersValues = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var isAutocapitalizationEnabled: Bool {
        get { settings.isAutocapitalizationEnabled }
        set { settings.isAutocapitalizationEnabled = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    internal(set) var localeIdentifier: String {
        get { settings.localeIdentifier }
        set { settings.localeIdentifier = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var addedLocales: [Locale] {
        get { settings.addedLocales }
        set { settings.addedLocales = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var addedLocaleIdentifiers: [String] {
        get { settings.addedLocaleIdentifiers }
        set { settings.addedLocaleIdentifiers = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    func hasAddedLocale(_ locale: Locale) -> Bool {
        settings.hasAddedLocale(locale)
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    func moveCurrentLocaleFirstInAddedLocales() {
        settings.moveLocaleFirstInAddedLocales(locale)
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Just set locale directly.")
    func setLocale(_ locale: Locale) {
        self.locale = locale
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Just set locales directly.")
    func setLocales(_ locales: [Locale]) {
        self.locales = locales
    }
}

public extension AutocompleteContext {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    static var settingsPrefix: String { Settings.settingsPrefix }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var isAutocompleteEnabled: Bool {
        get { settings.isAutocompleteEnabled }
        set { settings.isAutocompleteEnabled = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var isAutocorrectEnabled: Bool {
        get { settings.isAutocorrectEnabled }
        set { settings.isAutocorrectEnabled = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var isAutolearnEnabled: Bool {
        get { settings.isAutolearnEnabled }
        set { settings.isAutolearnEnabled = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var isAutoIgnoreEnabled: Bool {
        get { settings.isAutoIgnoreEnabled }
        set { settings.isAutoIgnoreEnabled = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var isNextCharacterPredictionEnabled: Bool {
        get { settings.isNextCharacterPredictionEnabled }
        set { settings.isNextCharacterPredictionEnabled = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var suggestionsDisplayCount: Int {
        get { settings.suggestionsDisplayCount }
        set { settings.suggestionsDisplayCount = newValue }
    }
}

public extension DictationContext {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    static var settingsPrefix: String {
        Settings.settingsPrefix
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var silenceLimit: TimeInterval {
        get { settings.silenceLimit }
        set { settings.silenceLimit = newValue }
    }
}

public extension FeedbackContext {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    static var settingsPrefix: String {
        Settings.settingsPrefix
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var isAudioFeedbackEnabled: Bool {
        get { settings.isAudioFeedbackEnabled }
        set { settings.isAudioFeedbackEnabled = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var isHapticFeedbackEnabled: Bool {
        get { settings.isHapticFeedbackEnabled }
        set { settings.isHapticFeedbackEnabled = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    func toggleIsAudioFeedbackEnabled() {
        settings.toggleIsAudioFeedbackEnabled()
    }
    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    func toggleIsHapticFeedbackEnabled() {
        settings.toggleIsHapticFeedbackEnabled()
    }
}

public extension KeyboardThemeContext {
    
    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    static var settingsPrefix: String {
        Settings.settingsPrefix
    }
    
    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    var theme: Keyboard.StorageValue<KeyboardTheme?> {
        get { settings.theme }
        set { settings.theme = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    func resetTheme() {
        settings.resetTheme()
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .settings instead.")
    func setTheme(_ theme: KeyboardTheme) {
        settings.setTheme(theme)
    }
}
