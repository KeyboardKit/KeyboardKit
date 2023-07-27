import Foundation

@available(*, deprecated, message: "Use input sets directly instead.")
public protocol InputSetProviderBased {

    func register(inputSetProvider: InputSetProvider)
}
