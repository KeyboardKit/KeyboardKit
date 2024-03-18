import SwiftUI

public extension KeyboardStyle {
    
    @available(*, deprecated, renamed: "Autocomplete.ToolbarStyle")
    typealias AutocompleteToolbar = Autocomplete.ToolbarStyle
    
    @available(*, deprecated, renamed: "Autocomplete.ToolbarItemStyle")
    typealias AutocompleteToolbarItem = Autocomplete.ToolbarItemStyle
    
    @available(*, deprecated, renamed: "Autocomplete.ToolbarSeparator")
    typealias AutocompleteToolbarSeparator = Autocomplete.ToolbarSeparatorStyle
    
    @available(*, deprecated, message: "This style is replaced by the Autocomplete.ToolbarItem's background properties.")
    struct AutocompleteToolbarItemBackground: Codable, Equatable {
        
        public init(
            color: Color = .white.opacity(0.5),
            cornerRadius: CGFloat = 4
        ) {
            self.color = color
            self.cornerRadius = cornerRadius
        }
        
        public var color: Color
        public var cornerRadius: CGFloat
    }
}

@available(*, deprecated, message: "This style is replaced by the Autocomplete.ToolbarItem's background properties.")
public extension KeyboardStyle.AutocompleteToolbarItemBackground {
    
    static var standard = Self()
}
