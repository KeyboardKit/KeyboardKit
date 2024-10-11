import Foundation
import SwiftUI

@available(*, deprecated, message: "Migration Deprecation! This will be removed in KeyboardKit 9.1. Use behavior instead.")
public extension KeyboardAction.StandardHandler {

    var keyboardBehavior: KeyboardBehavior {
        behavior
    }
}
