import Foundation

@available(*, deprecated, message: "The input set provider concept is deprecated. Use input sets directly instead.")
public protocol InputSetProvider: AnyObject {
    
    var alphabeticInputSet: AlphabeticInputSet { get }

    var numericInputSet: NumericInputSet { get }

    var symbolicInputSet: SymbolicInputSet { get }
}
