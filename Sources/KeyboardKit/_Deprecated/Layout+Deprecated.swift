import Foundation

public extension InputSet {
    
    @available(*, deprecated, renamed: "numeric")
    static func standardNumeric(currency: String) -> InputSet {
        numeric(currency: currency)
    }
    
    @available(*, deprecated, renamed: "symbolic")
    static func standardSymbolic(currencies: [String]) -> InputSet {
        symbolic(currencies: currencies)
    }
}
