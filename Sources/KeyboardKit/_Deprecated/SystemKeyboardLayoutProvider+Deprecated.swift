import Foundation

@available(*, deprecated, message: "Use KeyboardContext extensions instead.")
extension SystemKeyboardLayoutProvider {

    func isArabic(_ context: KeyboardContext) -> Bool {
        context.locale.identifier == KeyboardLocale.arabic.localeIdentifier
    }

    func isArabicAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && isArabic(context)
    }

    func isGreek(_ context: KeyboardContext) -> Bool {
        context.locale.identifier == KeyboardLocale.greek.localeIdentifier
    }

    func isGreekAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && isGreek(context)
    }

    func isKurdishSoraniArabic(_ context: KeyboardContext) -> Bool {
        context.locale.identifier == KeyboardLocale.kurdish_sorani_arabic.localeIdentifier
    }

    func isKurdishSoraniArabicAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && isKurdishSoraniArabic(context)
    }

    func isPersian(_ context: KeyboardContext) -> Bool {
        context.locale.identifier == KeyboardLocale.persian.localeIdentifier
    }

    func isPersianAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && isPersian(context)
    }

    func isRussianAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == KeyboardLocale.russian.localeIdentifier
    }

    func isUkrainianAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == KeyboardLocale.ukrainian.localeIdentifier
    }
}
