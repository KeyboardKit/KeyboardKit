import SwiftUI

public extension KeyboardCase {
    
    @available(*, deprecated, message: "Use Image.keyboardShift(:) instead")
    var standardButtonImage: Image {
        switch self {
        case .auto: return .keyboardShiftLowercased
        case .capsLocked: return .keyboardShiftCapslocked
        case .lowercased: return .keyboardShiftLowercased
        case .uppercased: return .keyboardShiftUppercased
        }
    }
}
