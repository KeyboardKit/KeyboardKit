import Foundation

#if os(iOS) || os(tvOS)
public extension KeyboardInputViewController {

    @available(*, deprecated, renamed: "actionCalloutContext")
    var keyboardSecondaryInputCalloutContext: ActionCalloutContext {
        get { actionCalloutContext }
        set { actionCalloutContext = newValue }
    }
    
    @available(*, deprecated, renamed: "inputCalloutContext")
    var keyboardInputCalloutContext: InputCalloutContext {
        get { inputCalloutContext }
        set { inputCalloutContext = newValue }
    }
    
    @available(*, deprecated, renamed: "inputSetProvider")
    var keyboardInputSetProvider: KeyboardInputSetProvider {
        get { inputSetProvider }
        set { inputSetProvider = newValue }
    }
    
    @available(*, deprecated, renamed: "calloutActionProvider")
    var keyboardSecondaryCalloutActionProvider: CalloutActionProvider {
        get { calloutActionProvider }
        set { calloutActionProvider = newValue }
    }
}
#endif
