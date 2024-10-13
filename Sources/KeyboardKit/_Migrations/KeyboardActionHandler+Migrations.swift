import Foundation
import SwiftUI

public extension KeyboardAction.StandardHandler {

    @available(*, deprecated, renamed: "behavior", message: "Migration Deprecation, will be removed in 9.1!")
    var keyboardBehavior: KeyboardBehavior {
        behavior
    }
}
