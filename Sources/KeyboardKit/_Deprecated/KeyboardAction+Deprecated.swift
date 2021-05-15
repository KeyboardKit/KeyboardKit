import UIKit
import SwiftUI

public extension KeyboardAction {
    
    @available(*, deprecated, message: "This will be removed in 5.0. Use the context-based function instead.")
    var standardButtonImage: Image? {
        standardButtonImage(for: .preview)
    }
    
    @available(*, deprecated, message: "This will be removed in 5.0. Use standardButtonFont instead.")
    func standardButtonUIFont(for context: KeyboardContext) -> UIFont {
        .preferredFont(forTextStyle: standardButtonUITextStyle(for: context))
    }
    
    @available(*, deprecated, message: "This will be removed in 5.0. Use standardButtonFontWeight instead.")
    var standardButtonUIFontWeight: UIFont.Weight? {
        if standardButtonImage != nil { return .light }
        switch self {
        case .character(let char): return char.isLowercased ? .light : nil
        default: return nil
        }
    }
    
    @available(*, deprecated, message: "This will be removed in 5.0. Use standardButtonFont instead.")
    func standardButtonUITextStyle(for context: KeyboardContext) -> UIFont.TextStyle {
        if standardButtonImage != nil { return .title2 }
        if useCalloutTextStyle(for: context) { return .callout }
        switch self {
        case .character(let char): return char.isLowercased ? .title1 : .title2
        case .emoji: return .title1
        case .emojiCategory: return .callout
        case .space: return .body
        default: return .title2
        }
    }
}

private extension KeyboardAction {
    
    func useCalloutTextStyle(for context: KeyboardContext) -> Bool {
        guard let text = standardButtonText(for: context) else { return false }
        if isPrimaryAction || isSystemAction { return !text.isEmpty }
        return false
    }
}
