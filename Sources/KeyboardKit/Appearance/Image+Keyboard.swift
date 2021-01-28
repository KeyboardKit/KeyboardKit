//
//  Image+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Image {
    
    static var backspace: Image { Image(systemName: "delete.left") }
    static var dictation: Image { Image(systemName: "mic") }
    static var command: Image { Image(systemName: "command") }
    static var control: Image { Image(systemName: "control") }
    static var email: Image { Image(systemName: "envelope") }
    
    @available(iOS 14, *)
    static var emoji: Image { Image(systemName: "face.smiling") }
    
    static var globe: Image { Image(systemName: "globe") }
    static var images: Image { Image(systemName: "photo") }
    static var keyboard: Image { Image(systemName: "keyboard") }
    static var keyboardDismiss: Image { Image(systemName: "keyboard.chevron.compact.down") }
    static var keyboardDismissLeft: Image { Image(systemName: "keyboard.chevron.compact.left") }
    static var keyboardDismissRight: Image { Image(systemName: "keyboard.chevron.compact.right") }
    static var moveCursorLeft: Image { Image(systemName: "arrow.left") }
    static var moveCursorRight: Image { Image(systemName: "arrow.right") }
    static var newLine: Image { Image(systemName: "arrow.turn.down.left") }
    static var option: Image { Image(systemName: "option") }
    static var redo: Image { Image(systemName: "arrow.uturn.right") }
    static var shiftCapslocked: Image { Image(systemName: "capslock.fill") }
    static var shiftLowercased: Image { Image(systemName: "shift") }
    static var shiftUppercased: Image { Image(systemName: "shift.fill") }
    static var tab: Image { Image(systemName: "arrow.right.to.line") }
    static var undo: Image { Image(systemName: "arrow.uturn.left") }
}
