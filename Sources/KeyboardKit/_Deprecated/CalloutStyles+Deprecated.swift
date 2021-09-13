import Foundation

public extension CalloutStyle {
    
    @available(*, deprecated, message: "Use .standard instead")
    static func systemStyle(for context: KeyboardContext) -> CalloutStyle { .standard }
}

public extension InputCalloutStyle {
    
    @available(*, deprecated, message: "Use .standard instead")
    static func systemStyle(for context: KeyboardContext) -> InputCalloutStyle { .standard }
}

public extension SecondaryInputCalloutStyle {
    
    @available(*, deprecated, message: "Use .standard instead")
    static func systemStyle(for context: KeyboardContext) -> SecondaryInputCalloutStyle { .standard }
}
