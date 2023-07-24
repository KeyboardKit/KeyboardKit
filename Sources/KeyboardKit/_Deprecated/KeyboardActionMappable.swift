import SwiftUI

@available(*, deprecated, message: "This protocol is deprecated.")
public protocol KeyboardActionMappable {

    var keyboardAction: KeyboardAction { get }
}

#if os(iOS) || os(tvOS)
import UIKit

@available(*, deprecated, message: "This extension is deprecated.")
extension UIReturnKeyType: KeyboardActionMappable {}

public extension UIReturnKeyType {

    @available(*, deprecated, message: "This extension is deprecated.")
    var keyboardAction: KeyboardAction {
        .primary(keyboardReturnKeyType)
    }
}
#endif
