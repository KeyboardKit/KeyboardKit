import Foundation

public extension KeyboardAction {

    @available(*, deprecated, renamed: "isShiftAction")
    var isShift: Bool { isShiftAction }

    @available(*, deprecated, renamed: "isUppercasedShiftAction")
    var isUppercaseShift: Bool { isUppercasedShiftAction }
}

/**
 This extension makes this enum implement ``KeyboardRowItem``.
 */
extension KeyboardAction {

    /**
     The row-specific ID to use when the action is presented
     in a keyboard row.
     */
    public var rowId: KeyboardAction { self }
}
