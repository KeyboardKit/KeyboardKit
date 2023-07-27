import Foundation

@available(*, deprecated, message: "Use input sets directly instead.")
public protocol InputSetProvider: AnyObject {
    
    var alphabeticInputSet: AlphabeticInputSet { get }

    var numericInputSet: NumericInputSet { get }

    var symbolicInputSet: SymbolicInputSet { get }
}
