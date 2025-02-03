import Foundation
import SwiftUI

public extension Keyboard.InputToolbarDisplayMode {
    
    @available(*, deprecated, renamed: "none")
    static var hidden: Self { .none }
    
    @available(*, deprecated, renamed: "characters")
    static func inputs(_ inputs: String) -> Self {
        .characters(inputs)
    }
}
