//
//  Image+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 These lazy `Image` extensions can be overridden if you want
 to easily change the overall appearance of a keyboard.
 */
public extension Image {
    
    static var keyboard: Image { Image(systemName: "keyboard") }
    static var keyboardBackspace: Image { Image(systemName: "delete.left") }
    static var keyboardBackspaceRtl: Image { Image(systemName: "delete.right") }
    static var keyboardCommand: Image { Image(systemName: "command") }
    static var keyboardControl: Image { Image(systemName: "control") }
    static var keyboardDictation: Image { Image(systemName: "mic") }
    static var keyboardDismiss: Image { Image(systemName: "keyboard.chevron.compact.down") }
    static var keyboardEmail: Image { Image(systemName: "envelope") }
    static var keyboardEmoji: Image { Image(systemName: emojiImageName) }
    static var keyboardGlobe: Image { Image(systemName: "globe") }
    static var keyboardImages: Image { Image(systemName: "photo") }
    static var keyboardLeft: Image { Image(systemName: "arrow.left") }
    static var keyboardNewline: Image { Image(systemName: "arrow.turn.down.left") }
    static var keyboardNewlineRtl: Image { Image(systemName: "arrow.turn.down.right") }
    static var keyboardOption: Image { Image(systemName: "option") }
    static var keyboardRedo: Image { Image(systemName: "arrow.uturn.right") }
    static var keyboardRight: Image { Image(systemName: "arrow.right") }
    static var keyboardSettings: Image { Image(systemName: settingsImageName) }
    static var keyboardShiftCapslocked: Image { Image(systemName: "capslock.fill") }
    static var keyboardShiftLowercased: Image { Image(systemName: "shift") }
    static var keyboardShiftUppercased: Image { Image(systemName: "shift.fill") }
    static var keyboardTab: Image { Image(systemName: "arrow.right.to.line") }
    static var keyboardUndo: Image { Image(systemName: "arrow.uturn.left") }
    static var keyboardZeroWidthSpace: Image { Image(systemName: "circle.dotted") }
    
    static func keyboardBackspace(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardBackspace : .keyboardBackspaceRtl
    }
    
    static func keyboardNewline(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardNewline : .keyboardNewlineRtl
    }
}

private extension Image {
    
    static var isiOS14: Bool {
        if #available(iOS 14, *) {
            return true
        } else {
            return false
        }
    }
    
    static var emojiImageName: String {
        isiOS14 ? "face.smiling" : "person.crop.circle"
    }
    
    static var settingsImageName: String {
        isiOS14 ? "gearshape.fill" : "gear"
    }
}

struct ImageButton_Previews: PreviewProvider {
    
    static var images: [Image] = [
        .keyboard,
        .keyboardBackspace,
        .keyboardCommand,
        .keyboardControl,
        .keyboardDictation,
        .keyboardDictation,
        .keyboardDismiss,
        .keyboardEmail,
        .keyboardEmoji,
        .keyboardGlobe,
        .keyboardImages,
        .keyboardLeft,
        .keyboardNewline,
        .keyboardNewlineRtl,
        .keyboardOption,
        .keyboardRedo,
        .keyboardRight,
        .keyboardSettings,
        .keyboardShiftCapslocked,
        .keyboardShiftLowercased,
        .keyboardShiftUppercased,
        .keyboardTab,
        .keyboardUndo,
        .keyboardZeroWidthSpace]
    
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
