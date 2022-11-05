import Foundation

public extension KeyboardAction {

    @available(*, deprecated, renamed: "isShiftAction")
    var isShift: Bool { isShiftAction }

    @available(*, deprecated, renamed: "isUppercasedShiftAction")
    var isUppercaseShift: Bool { isUppercasedShiftAction }
}
