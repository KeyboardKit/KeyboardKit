import Foundation

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
