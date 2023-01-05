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
public extension KeyboardAction {

    @available(*, deprecated, message: "This will be removed in KK 7.0")
    var rowId: KeyboardAction { self }

    #if os(iOS) || os(tvOS)
    @available(*, deprecated, renamed: "standardReleaseAction")
    var standardTapAction: GestureAction? { standardReleaseAction }
    #endif
}
