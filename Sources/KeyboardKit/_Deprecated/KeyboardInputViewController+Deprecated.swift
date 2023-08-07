import Foundation

#if os(iOS) || os(tvOS)
public extension KeyboardInputViewController {
    
    @available(*, deprecated, renamed: "keyboardStyleProvider")
    var keyboardAppearance: KeyboardStyleProvider {
        get { keyboardStyleProvider }
        set { keyboardStyleProvider = newValue }
    }
}
#endif
