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
    
    @available(*, deprecated, renamed: "Keyboard.Background")
    typealias Background = Keyboard.Background
    
    @available(*, deprecated, renamed: "KeyboardButton.ButtonStyle")
    typealias Button = KeyboardButton.ButtonStyle
    
    @available(*, deprecated, renamed: "KeyboardButton.ButtonBorderStyle")
    typealias ButtonBorder = KeyboardButton.ButtonBorderStyle
    
    @available(*, deprecated, renamed: "KeyboardButton.ButtonShadowStyle")
    typealias ButtonShadow = KeyboardButton.ButtonShadowStyle
    
    @available(*, deprecated, renamed: "Callouts.CalloutStyle")
    typealias Callout = Callouts.CalloutStyle
    
    @available(*, deprecated, renamed: "Callouts.ActionCalloutStyle")
    typealias ActionCallout = Callouts.ActionCalloutStyle
    
    @available(*, deprecated, renamed: "Callouts.InputCalloutStyle")
    typealias InputCallout = Callouts.InputCalloutStyle
}

@available(*, deprecated, message: "This style is replaced by the Autocomplete.ToolbarItem's background properties.")
public extension KeyboardStyle.AutocompleteToolbarItemBackground {
    
    static var standard = Self()
}
