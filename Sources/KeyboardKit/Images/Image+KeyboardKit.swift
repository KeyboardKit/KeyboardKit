//
//  Image+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Image {
    
    static var keyboard = symbol("keyboard")
    static var keyboardAudioFeedbackEnabled = symbol("speaker.fill")
    static var keyboardAudioFeedbackDisabled = symbol("speaker")
    static var keyboardBackspace = symbol("delete.left")
    static var keyboardBackspaceRtl = symbol("delete.right")
    static var keyboardCommand = symbol("command")
    static var keyboardControl = symbol("control")
    static var keyboardDictation = symbol("mic")
    static var keyboardDismiss = symbol("keyboard.chevron.compact.down")
    static var keyboardEmail = symbol("envelope")
    static var keyboardEmoji = asset("keyboardEmoji")
    static var keyboardEmojiSymbol = symbol("face.smiling")
    static var keyboardGlobe = symbol("globe")
    static var keyboardHapticFeedbackEnabled = symbol("hand.tap.fill")
    static var keyboardHapticFeedbackDisabled = symbol("hand.tap")
    static var keyboardImages = symbol("photo")
    static var keyboardLeft = symbol("arrow.left")
    static var keyboardNewline = symbol("arrow.turn.down.left")
    static var keyboardNewlineRtl = symbol("arrow.turn.down.right")
    static var keyboardOption = symbol("option")
    static var keyboardRedo = symbol("arrow.uturn.right")
    static var keyboardRight = symbol("arrow.right")
    static var keyboardSettings = symbol("gearshape")
    static var keyboardShiftCapslocked = symbol("capslock.fill")
    static var keyboardShiftLowercased = symbol("shift")
    static var keyboardShiftUppercased = symbol("shift.fill")
    static var keyboardTab = symbol("arrow.right.to.line")
    static var keyboardUndo = symbol("arrow.uturn.left")
    static var keyboardZeroWidthSpace = symbol("circle.dotted")
    
    static func keyboardBackspace(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardBackspace : .keyboardBackspaceRtl
    }
    
    static func keyboardNewline(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardNewline : .keyboardNewlineRtl
    }
    
    static func keyboardShift(_ casing: Keyboard.Case) -> Image {
        switch casing {
        case .auto: return .keyboardShiftLowercased
        case .capsLocked: return .keyboardShiftCapslocked
        case .lowercased: return .keyboardShiftLowercased
        case .uppercased: return .keyboardShiftUppercased
        }
    }
    
}

extension Image {

    static func asset(_ name: String) -> Image {
        Image(name, bundle: .keyboardKit)
    }

    static func symbol(_ name: String) -> Image {
        Image(systemName: name)
    }
}

struct Image_Previews: PreviewProvider {
    
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
        .keyboardEmojiSymbol,
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
        VStack {
            ForEach(images, id: \.0) { img in
                HStack {
                    listItem(for: img.1)
                    listItem(for: img.1).colorScheme(.dark)
                }
            }
        }.previewLayout(.sizeThatFits)
    }
}
