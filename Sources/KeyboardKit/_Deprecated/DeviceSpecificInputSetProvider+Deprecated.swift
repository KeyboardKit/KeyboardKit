import Foundation

public extension DeviceSpecificInputSetProvider {
    
    @available(*, deprecated, message: "Use KeyboardInputRow initializer instead")
    func row(_ chars: String) -> KeyboardInputRow {
        row(chars.chars)
    }
    
    @available(*, deprecated, message: "Use KeyboardInputRow initializer instead")
    func row(_ chars: [String]) -> KeyboardInputRow {
        KeyboardInputRow(chars)
    }
    
    @available(*, deprecated, message: "Use KeyboardInputRow initializer instead")
    func row(lowercased: [String], uppercased: [String]) -> KeyboardInputRow {
        KeyboardInputRow(
            lowercased: lowercased,
            uppercased: uppercased)
    }
    
    @available(*, deprecated, message: "Use KeyboardInputRow initializer instead")
    func row(lowercased: String, uppercased: String) -> KeyboardInputRow {
        row(lowercased: lowercased.chars,
            uppercased: uppercased.chars)
    }
}
