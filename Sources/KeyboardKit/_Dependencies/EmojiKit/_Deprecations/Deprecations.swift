import Foundation

public extension Emoji {

    @available(*, deprecated, renamed: "matches(_:in:)")
    func matches(
        _ query: String,
        for locale: Locale
    ) -> Bool {
        matches(query, in: locale)
    }
}

public extension Collection where Element == Emoji {

    @available(*, deprecated, renamed: "matches(_:in:)")
    func matching(
        _ query: String,
        for locale: Locale
    ) -> [Emoji] {
        matching(query, in: locale)
    }
}

public extension Localizable {

    @available(*, deprecated, renamed: "localizedName(in:bundle:)")
    func localizedName(
        for locale: Locale = .current,
        in bundle: Bundle
    ) -> String {
        let key = localizationKey
        let localeBundle = bundle.bundle(for: locale) ?? bundle
        return NSLocalizedString(key, bundle: localeBundle, comment: "")
    }

    @available(*, deprecated, renamed: "localizedName(in:)")
    func localizedName(
        for locale: Locale = .current
    ) -> String {
        localizedName(in: locale)
    }
}
