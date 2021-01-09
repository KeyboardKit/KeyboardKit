import UIKit

public extension KeyboardAction {
    
    @available(*, deprecated, message: "No keyboard actions have a standard double-tap action anymore.")
    var standardDoubleTapAction: GestureAction? { nil }
    
    @available(*, deprecated, renamed: "standardButtonFont")
    var systemFont: UIFont { standardButtonFont }
    
    @available(*, deprecated, renamed: "standardButtonText")
    var systemKeyboardButtonText: String? { standardButtonText }
    
    @available(*, deprecated, renamed: "standardButtonTextStyle")
    var systemTextStyle: UIFont.TextStyle { standardButtonTextStyle }
}
