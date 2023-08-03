import Foundation

@available(*, deprecated, renamed: "KeyboardStyle.ActionCallout")
public typealias KeyboardActionCalloutStyle = KeyboardStyle.ActionCallout

@available(*, deprecated, renamed: "KeyboardStyle.Background")
public typealias KeyboardBackgroundStyle = KeyboardStyle.Background

public extension KeyboardStyle.Background {

    @available(*, deprecated, message: "You no longer have to specify the type parameter name")
    init(type: KeyboardBackgroundType) {
        self.backgroundType = type
        self.backgroundColor = nil
        self.backgroundGradient = nil
        self.imageData = nil
        self.overlayColor = nil
        self.overlayGradient = nil
    }
}

@available(*, deprecated, renamed: "KeyboardStyle.Button")
public typealias KeyboardButtonStyle = KeyboardStyle.Button

@available(*, deprecated, renamed: "KeyboardStyle.ButtonBorder")
public typealias KeyboardButtonBorderStyle = KeyboardStyle.ButtonBorder

@available(*, deprecated, renamed: "KeyboardStyle.ButtonShadow")
public typealias KeyboardButtonShadowStyle = KeyboardStyle.ButtonShadow

@available(*, deprecated, renamed: "KeyboardStyle.Callout")
public typealias KeyboardCalloutStyle = KeyboardStyle.Callout

@available(*, deprecated, renamed: "KeyboardStyle.InputCallout")
public typealias KeyboardInputCalloutStyle = KeyboardStyle.InputCallout
