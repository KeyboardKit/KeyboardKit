import Foundation

public extension Locale {

    @available(*, deprecated, message: "Use localizedName(in:) instead")
    func localizedName(of locale: Locale) -> String? {
        localizedString(forIdentifier: locale.identifier)?.capitalized
    }

    @available(*, deprecated, message: "Use localizedName(in:) instead")
    func localizedLanguageName(of locale: Locale) -> String? {
        guard let code = locale.languageCode else { return nil }
        return localizedString(forLanguageCode: code)?.capitalized
    }
}
