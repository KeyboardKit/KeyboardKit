import Foundation

public extension KeyboardAppearance {
    
    @available(*, deprecated, renamed: "actionCalloutStyle")
    func secondaryInputCalloutStyle() -> ActionCalloutStyle {
        actionCalloutStyle()
    }
}
