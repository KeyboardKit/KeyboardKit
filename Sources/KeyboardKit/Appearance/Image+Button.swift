//
//  Image+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
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

struct ImageButton_Previews: PreviewProvider {
    
    static var images: [Image] = [
        .backspace,
        .dictation,
        .command,
        .control,
        .email,
        //.emoji,
        .globe,
        .images,
        .keyboard,
        .keyboardDismiss,
        .moveCursorLeft,
        .moveCursorRight,
        .newLine,
        .option,
        .redo,
        .shiftCapslocked,
        .shiftLowercased,
        .shiftUppercased,
        .tab,
        .undo]
    
    static func listItem(for image: Image) -> some View {
        image
            .frame(width: 100, height: 60)
            .background(Color.primary.colorInvert())
    }
    
    static var previews: some View {
        let images = Self.images.map { (UUID(), $0)}
        Group {
            ForEach(images, id: \.0) { img in
                HStack {
                    listItem(for: img.1)
                    listItem(for: img.1).colorScheme(.dark)
                }
            }
        }.previewLayout(.sizeThatFits)
    }
}
