//
//  KeyboardAction+Deprecated.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

public extension KeyboardAction {

    @available(*, deprecated, renamed: "nextKeyboard")
    static var switchKeyboard: KeyboardAction { .nextKeyboard }
    
    @available(*, deprecated, renamed: "keyboardType")
    static func switchToKeyboard(_ type: KeyboardType) -> KeyboardAction { .keyboardType(type) }
    
    @available(*, deprecated, renamed: "standardTapAction")
    var standardInputViewControllerAction: ((KeyboardInputViewController?) -> Void)? {
        standardTapAction
    }
    
    @available(*, deprecated, renamed: "standardTapAction")
    var standardTextDocumentProxyAction: ((UITextDocumentProxy?) -> Void)? {
        switch self {
        case .backspace: return { $0?.deleteBackward() }
        case .character(let char): return { $0?.insertText(char) }
        case .moveCursorBackward: return { $0?.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { $0?.adjustTextPosition(byCharacterOffset: 1) }
        case .newLine: return { $0?.insertText("\n") }
        case .space: return { $0?.insertText(" ") }
        case .tab: return { $0?.insertText("\t") }
        default: return nil
        }
    }
}
