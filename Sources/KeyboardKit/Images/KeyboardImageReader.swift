//
//  Image+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by any type that should be
 able to access keyboard-specific images.

 This protocol is implemented by `Image`. This means that it
 is possible to use e.g. `Image.keyboardSettings` to get the
 standard keyboard settings icon.
 */
public protocol KeyboardImageReader {}

extension Image: KeyboardImageReader {}

public extension KeyboardImageReader {
    
    static var keyboard: Image { .symbol("keyboard") }
    static var keyboardBackspace: Image { .symbol("delete.left") }
    static var keyboardBackspaceRtl: Image { .symbol("delete.right") }
    static var keyboardCommand: Image { .symbol("command") }
    static var keyboardControl: Image { .symbol("control") }
    static var keyboardDictation: Image { .symbol("mic") }
    static var keyboardDismiss: Image { .symbol("keyboard.chevron.compact.down") }
    static var keyboardEmail: Image { .symbol("envelope") }
    static var keyboardEmoji: Image { .symbol(emojiImageName) }
    static var keyboardGlobe: Image { .symbol("globe") }
    static var keyboardImages: Image { .symbol("photo") }
    static var keyboardLeft: Image { .symbol("arrow.left") }
    static var keyboardNewline: Image { .symbol("arrow.turn.down.left") }
    static var keyboardNewlineRtl: Image { .symbol("arrow.turn.down.right") }
    static var keyboardOption: Image { .symbol("option") }
    static var keyboardRedo: Image { .symbol("arrow.uturn.right") }
    static var keyboardRight: Image { .symbol("arrow.right") }
    static var keyboardSettings: Image { .symbol(settingsImageName) }
    static var keyboardShiftCapslocked: Image { .symbol("capslock.fill") }
    static var keyboardShiftLowercased: Image { .symbol("shift") }
    static var keyboardShiftUppercased: Image { .symbol("shift.fill") }
    static var keyboardTab: Image { .symbol("arrow.right.to.line") }
    static var keyboardUndo: Image { .symbol("arrow.uturn.left") }
    static var keyboardZeroWidthSpace: Image { .symbol("circle.dotted") }
    
    static func keyboardBackspace(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardBackspace : .keyboardBackspaceRtl
    }
    
    static func keyboardNewline(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardNewline : .keyboardNewlineRtl
    }
}

extension Image {

    static func symbol(_ name: String) -> Image {
        Image(systemName: name)
    }
}

private extension KeyboardImageReader {
    
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
        isiOS14 ? "gearshape" : "gear"
    }
}

struct KeyboardImageReader_Previews: PreviewProvider {
    
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
