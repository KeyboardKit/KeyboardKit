import Foundation

#if os(iOS)
import UIKit


public extension DeviceSpecificInputSetProvider {
    
    @available(*, deprecated, message: "Use InputSetRow initializer instead")
    func row(_ chars: String) -> InputSetRow {
        row(chars.chars)
    }
    
    @available(*, deprecated, message: "Use InputSetRow initializer instead")
    func row(_ chars: [String]) -> InputSetRow {
        InputSetRow(chars)
    }
    
    @available(*, deprecated, message: "Use InputSetRow initializer instead")
    func row(lowercased: [String], uppercased: [String]) -> InputSetRow {
        InputSetRow(
            lowercased: lowercased,
            uppercased: uppercased)
    }
    
    @available(*, deprecated, message: "Use InputSetRow initializer instead")
    func row(lowercased: String, uppercased: String) -> InputSetRow {
        row(lowercased: lowercased.chars,
            uppercased: uppercased.chars)
    }
}

public extension EnglishInputSetProvider {
    
    @available(*, deprecated, message: "Use the new, device-agnostic initializer")
    convenience init(
        device: UIDevice = .current,
        numericCurrency: String = "$",
        symbolicCurrency: String = "£") {
        self.init(
            numericCurrency: numericCurrency,
            symbolicCurrency: symbolicCurrency)
    }
}

extension InternalSwedishInputSetProvider {
    
    @available(*, deprecated, message: "Use the new, device-agnostic initializer")
    convenience init(device: UIDevice = .current) {
        self.init()
    }
}
#endif
