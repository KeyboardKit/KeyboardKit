import Foundation

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
