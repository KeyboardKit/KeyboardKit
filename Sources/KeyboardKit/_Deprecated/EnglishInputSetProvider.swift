import Foundation

@available(*, deprecated, message: "Use input sets directly instead.")
open class EnglishInputSetProvider: InputSetProvider, LocalizedService {
    
    public init(
        alphabetic: AlphabeticInputSet = .english,
        numericCurrency: String = "$",
        symbolicCurrency: String = "£"
    ) {
        self.alphabeticInputSet = alphabetic
        self.numericInputSet = .englishNumeric(currency: numericCurrency)
        self.symbolicInputSet = .englishSymbolic(currency: symbolicCurrency)
    }
    
    public var localeKey = KeyboardLocale.english.id
    
    public var alphabeticInputSet: AlphabeticInputSet

    public var numericInputSet: NumericInputSet
    
    public var symbolicInputSet: SymbolicInputSet
}
