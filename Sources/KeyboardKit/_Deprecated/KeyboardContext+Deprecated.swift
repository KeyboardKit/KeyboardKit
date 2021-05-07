import UIKit

public extension KeyboardContext {
    
    @available(*, deprecated, renamed: "screenOrientation")
    var deviceOrientation: UIInterfaceOrientation { screenOrientation }
}
