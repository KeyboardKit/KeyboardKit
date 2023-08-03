import Foundation

public extension KeyboardInputViewController {
    
    @available(*, deprecated, renamed: "keyboardStyleProvider")
    var keyboardAppearance: KeyboardStyleProvider {
        get { keyboardStyleProvider }
        set { keyboardStyleProvider = newValue }
    }
}
