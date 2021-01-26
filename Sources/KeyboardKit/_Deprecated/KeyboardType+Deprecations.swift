import KeyboardKit
import SwiftUI

public extension KeyboardType {
    
    @available(*, deprecated, renamed: "standardButtonImage")
    func systemKeyboardButtonImage(for context: KeyboardContext) -> Image? {
        standardButtonImage
    }
}
