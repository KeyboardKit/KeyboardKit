import Foundation

public extension KKL10n {

    /**
     Whether or not the KKL10n case has been localized for a
     certain `locale`.
     */
    func hasText(for locale: KeyboardLocale) -> Bool {
        if locale == .english { return true }
        return text(for: locale.locale) != rawValue
    }
}
