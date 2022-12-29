import Foundation

public extension PreviewKeyboardLayoutProvider {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead")
    convenience init(context: KeyboardContext = .preview) {
        self.init(keyboardContext: context)
    }
}

public extension SystemKeyboardLayoutProvider {

    @available(*, deprecated, message: "Use dictation replacement-less initializer and set KeyboardContext's keyboardDictationReplacement instead")
    convenience init(
        inputSetProvider: InputSetProvider,
        dictationReplacement: KeyboardAction? = nil
    ) {
        KeyboardInputViewController.shared.keyboardContext.keyboardDictationReplacement = dictationReplacement
        self.init(inputSetProvider: inputSetProvider)
    }

    @available(*, deprecated, message: "Use KeyboardContext's keyboardDictationReplacement instead")
    var dictationReplacement: KeyboardAction? {
        KeyboardInputViewController.shared.keyboardContext.keyboardDictationReplacement
    }
}

public extension StandardKeyboardLayoutProvider {

    @available(*, deprecated, message: "Use dictation replacement-less initializer and set KeyboardContext's keyboardDictationReplacement instead")
    convenience init(
        keyboardContext: KeyboardContext,
        inputSetProvider: InputSetProvider,
        localizedProviders: [LocalizedKeyboardLayoutProvider] = [EnglishKeyboardLayoutProvider()],
        dictationReplacement: KeyboardAction? = nil
    ) {
        KeyboardInputViewController.shared.keyboardContext.keyboardDictationReplacement = dictationReplacement
        self.init(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider,
            localizedProviders: localizedProviders)
    }

    @available(*, deprecated, message: "Use KeyboardContext's keyboardDictationReplacement instead")
    var dictationReplacement: KeyboardAction? {
        KeyboardInputViewController.shared.keyboardContext.keyboardDictationReplacement
    }
}

@available(*, deprecated, message: "Use hasAlphabeticInputCount(_) instead.")
extension SystemKeyboardLayoutProvider {

    var hasElevenElevenNineAlphabeticInput: Bool {
        hasAlphabeticInputCount([11, 11, 9])
    }

    var hasTwelveElevenNineAlphabeticInput: Bool {
        hasAlphabeticInputCount([12, 11, 9])
    }

    var hasTwelveTwelveTenAlphabeticInput: Bool {
        hasAlphabeticInputCount([12, 12, 10])
    }
}

@available(*, deprecated, message: "Use isAlphabeticWithInputCount(_) instead.")
extension SystemKeyboardLayoutProvider {

    func isTenTenEightAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabeticWithInputCount(context, [10, 10, 8])    // Czech
    }

    func isElevenElevenNineAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabeticWithInputCount(context, [11, 11, 9])    // Russian
    }

    func isTwelveTwelveNineAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabeticWithInputCount(context, [12, 12, 9])    // Belarusian
    }
}

@available(*, deprecated, message: "Use KeyboardContext extensions instead.")
extension SystemKeyboardLayoutProvider {
    
    func isAlphabetic(_ context: KeyboardContext) -> Bool {
        context.keyboardType.isAlphabetic
    }

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
