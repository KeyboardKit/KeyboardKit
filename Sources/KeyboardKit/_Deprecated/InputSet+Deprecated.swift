import Foundation

public extension NumericInputSet {
    
    @available(*, deprecated, renamed: "standardNumeric")
    static func standard(currency: String) -> NumericInputSet {
        standardNumeric(currency: currency)
    }
    
    @available(*, deprecated, renamed: "englishNumeric")
    static func english(currency: String) -> NumericInputSet {
        .englishNumeric(currency: currency)
    }
}

public extension SymbolicInputSet {
    
    @available(*, deprecated, renamed: "standardSymbolic")
    static func standard(currencies: [String]) -> SymbolicInputSet {
        standardSymbolic(currencies: currencies)
    }
    
    @available(*, deprecated, renamed: "englishSymbolic")
    static func english(currency: String) -> SymbolicInputSet {
        .englishSymbolic(currency: currency)
    }
}
