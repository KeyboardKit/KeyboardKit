//
//  Image+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Image {
    
    static let keyboardEmoji = Image(.keyboardEmoji)
    static let keyboardKit = Image(.keyboardKitIcon)

    static let keyboard = symbol("keyboard")
    static let keyboardArrowUp = symbol("arrow.up")
    static let keyboardArrowDown = symbol("arrow.down")
    static let keyboardArrowLeft = symbol("arrow.left")
    static let keyboardArrowRight = symbol("arrow.right")
    static let keyboardAudioFeedbackDisabled = symbol("speaker")
    static let keyboardAudioFeedbackEnabled = symbol("speaker.wave.3.fill")
    static let keyboardBackspace = symbol("delete.left")
    static let keyboardBackspaceRtl = symbol("delete.right")
    static let keyboardBrightnessDown = symbol("sun.min")
    static let keyboardBrightnessUp = symbol("sun.max")
    static let keyboardCommand = symbol("command")
    static let keyboardControl = symbol("control")
    static let keyboardDictation = symbol("mic")
    static let keyboardDismiss = symbol("keyboard.chevron.compact.down")
    static let keyboardEmail = symbol("envelope")
    static let keyboardEmojiSymbol = symbol("face.smiling")
    static let keyboardGlobe = symbol("globe")
    static let keyboardHapticFeedbackDisabled = symbol("hand.tap")
    static let keyboardHapticFeedbackEnabled = symbol("hand.tap.fill")
    static let keyboardImages = symbol("photo")
    static let keyboardInputCursor = symbol("character.cursor.ibeam")
    static let keyboardNewline = symbol("arrow.turn.down.left")
    static let keyboardNewlineRtl = symbol("arrow.turn.down.right")
    static let keyboardNone = symbol("circle.slash")
    static let keyboardOption = symbol("option")
    static let keyboardRedo = symbol("arrow.uturn.right")
    static let keyboardSearch = symbol("magnifyingglass")
    static let keyboardSettings = symbol("gearshape")
    static let keyboardShiftCapslockActive = symbol("capslock.fill")
    static let keyboardShiftCapslockInactive = symbol("capslock")
    static let keyboardShiftLowercased = symbol("shift")
    static let keyboardShiftUppercased = symbol("shift.fill")
    static let keyboardSpeaker = symbol("speaker")
    static let keyboardSpeakerDown = symbol("speaker.wave.3")
    static let keyboardSpeakerUp = symbol("speaker.wave.1")
    static let keyboardTab = symbol("arrow.right.to.line")
    static let keyboardTabRtl = symbol("arrow.left.to.line")
    static let keyboardTheme = symbol("paintpalette")
    static let keyboardUndo = symbol("arrow.uturn.left")
    static let keyboardUrl = symbol("safari")
    static let keyboardZeroWidthSpace = symbol("circle.dotted")

    static let keyboardDockEdgeNone = symbol("keyboard")
    static let keyboardDockEdgeLeading = symbol("keyboard.onehanded.left")
    static let keyboardDockEdgeTrailing = symbol("keyboard.onehanded.right")
    
    static let keyboardInputToolbarAutomatic = symbol("square")
    static let keyboardInputToolbarNone = symbol("square.slash")
    static let keyboardInputToolbarCharacters = symbol("character.square")
    static let keyboardInputToolbarNumbers = symbol("1.square")
    static let keyboardInputToolbarRecentEmojis = symbol("heart.square")
    
    static func keyboardAudioFeedback(enabled: Bool) -> Image {
        enabled ? keyboardAudioFeedbackEnabled : keyboardAudioFeedbackDisabled
    }

    static func keyboardBackspace(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardBackspace : .keyboardBackspaceRtl
    }


    static func keyboardHapticFeedback(enabled: Bool) -> Image {
        enabled ? keyboardHapticFeedbackEnabled : keyboardHapticFeedbackDisabled
    }

    static func keyboardNewline(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardNewline : .keyboardNewlineRtl
    }

    static func keyboardTab(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardTab : .keyboardTabRtl
    }

    static func keyboardShift(_ casing: Keyboard.KeyboardCase) -> Image {
        switch casing {
        case .auto: .keyboardShiftLowercased
        case .capsLocked: .keyboardShiftCapslockActive
        case .lowercased: .keyboardShiftLowercased
        case .uppercased: .keyboardShiftUppercased
        }
    }
}

extension Image {

    static func symbol(_ name: String) -> Image {
        Image(systemName: name)
    }
}

#Preview {
    
    func preview(for image: Image, _ title: String) -> some View {
        Button {
            print(title)
        } label: {
            image
        }
    }

    return ScrollView(.vertical) {
        VStack(spacing: 40) {
            StylePreviewHeader(title: "KeyboardKit Images")

            LazyVGrid(columns: .preview, spacing: 20) {
                preview(for: .keyboard, "keyboard")
                preview(for: .keyboardArrowUp, "keyboardArrowUp")
                preview(for: .keyboardArrowDown, "keyboardArrowDown")
                preview(for: .keyboardArrowLeft, "keyboardArrowLeft")
                preview(for: .keyboardArrowRight, "keyboardArrowRight")
                preview(for: .keyboardAudioFeedback(enabled: true), "keyboardAudioFeedback")
                preview(for: .keyboardAudioFeedback(enabled: false), "keyboardAudioFeedback")
                preview(for: .keyboardBackspace(for: .english), "keyboardBackspace")
                preview(for: .keyboardBackspace(for: .arabic), "keyboardBackspace")
                preview(for: .keyboardBackspaceRtl, "keyboardBackspaceRtl")
                preview(for: .keyboardBrightnessDown, "keyboardBrightnessDown")
                preview(for: .keyboardBrightnessUp, "keyboardBrightnessUp")
                preview(for: .keyboardCommand, "keyboardCommand")
                preview(for: .keyboardControl, "keyboardControl")
                preview(for: .keyboardDictation, "keyboardDictation")
                preview(for: .keyboardDismiss, "keyboardDismiss")
                preview(for: .keyboardEmail, "keyboardEmail")
                preview(for: .keyboardEmojiSymbol, "keyboardEmojiSymbol")
                preview(for: .keyboardGlobe, "keyboardGlobe")
                preview(for: .keyboardHapticFeedback(enabled: true), "keyboardHapticFeedback")
                preview(for: .keyboardHapticFeedback(enabled: false), "keyboardHapticFeedback")
                preview(for: .keyboardImages, "keyboardImages")
                preview(for: .keyboardNewline(for: .english), "keyboardNewline")
                preview(for: .keyboardNewline(for: .arabic), "keyboardNewline")
                preview(for: .keyboardOption, "keyboardOption")
                preview(for: .keyboardRedo, "keyboardRedo")
                preview(for: .keyboardSearch, "keyboardSearch")
                preview(for: .keyboardSettings, "keyboardSettings")
                preview(for: .keyboardShiftCapslockActive, "keyboardShiftCapslocked")
                preview(for: .keyboardShiftCapslockInactive, "keyboardShiftCapslockInactive")
                preview(for: .keyboardShiftLowercased, "keyboardShiftLowercased")
                preview(for: .keyboardShiftUppercased, "keyboardShiftUppercased")
                preview(for: .keyboardSpeaker, "keyboardSpeaker")
                preview(for: .keyboardSpeakerDown, "keyboardSpeakerDown")
                preview(for: .keyboardSpeakerUp, "keyboardSpeakerUp")
                preview(for: .keyboardTab(for: .english), "keyboardTab")
                preview(for: .keyboardTab(for: .arabic), "keyboardTab")
                preview(for: .keyboardTheme, "keyboardTheme")
                preview(for: .keyboardUndo, "keyboardUndo")
                preview(for: .keyboardZeroWidthSpace, "keyboardZeroWidthSpace")
                Image.keyboardEmoji
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
            }
        }
        .padding()
        .buttonStyle(.plain)
        .font(.title.weight(.regular))
    }
}

private extension Array where Element == GridItem {

    static var preview: Self {
        [.init(.adaptive(minimum: 40, maximum: 50), spacing: 20)]
    }
}
