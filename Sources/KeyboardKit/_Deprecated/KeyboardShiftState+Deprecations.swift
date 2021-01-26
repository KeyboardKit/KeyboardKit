import SwiftUI

public extension KeyboardShiftState {
    
    @available(*, deprecated, renamed: "standardButtonImage")
    var systemImage: Image { standardButtonImage }
    
    @available(*, deprecated, message: "")
    func systemKeyboardButtonImage(for context: KeyboardContext) -> Image {
        switch context.keyboardType {
        case .alphabetic(let state): return state.standardButtonImage
        default: return standardButtonImage
        }
    }
}
