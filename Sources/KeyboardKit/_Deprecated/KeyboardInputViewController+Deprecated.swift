import Foundation

public extension KeyboardInputViewController {

    @available(*, deprecated, renamed: "actionCalloutContext")
    var keyboardSecondaryInputCalloutContext: ActionCalloutContext {
        get { actionCalloutContext }
        set { actionCalloutContext = newValue }
    }
}
