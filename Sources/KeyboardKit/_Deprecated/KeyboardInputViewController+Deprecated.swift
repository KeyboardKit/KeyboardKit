import Foundation

public extension KeyboardInputViewController {

    @available(*, deprecated, renamed: "actionCalloutContext")
    var keyboardSecondaryInputCalloutContext: ActionCalloutContext {
        get { actionCalloutContext }
        set { actionCalloutContext = newValue }
    }
    
    @available(*, deprecated, renamed: "calloutActionProvider")
    var keyboardSecondaryCalloutActionProvider: CalloutActionProvider {
        get { calloutActionProvider }
        set { calloutActionProvider = newValue }
    }
}
