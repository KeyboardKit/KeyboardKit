//
//  Image+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Image {
    
    static var keyboardEmoji = asset("keyboardEmoji")
    static var keyboardKit = asset("keyboardKitIcon")
    
    static var keyboard = symbol("keyboard")
    static var keyboardArrowUp = symbol("arrow.up")
    static var keyboardArrowDown = symbol("arrow.down")
    static var keyboardArrowLeft = symbol("arrow.left")
    static var keyboardArrowRight = symbol("arrow.right")
    static var keyboardAudioFeedbackDisabled = symbol("speaker")
    static var keyboardAudioFeedbackEnabled = symbol("speaker.wave.3.fill")
    static var keyboardBackspace = symbol("delete.left")
    static var keyboardBackspaceRtl = symbol("delete.right")
    static var keyboardBrightnessDown = symbol("sun.min")
    static var keyboardBrightnessUp = symbol("sun.max")
    static var keyboardCommand = symbol("command")
    static var keyboardControl = symbol("control")
    static var keyboardDictation = symbol("mic")
    static var keyboardDismiss = symbol("keyboard.chevron.compact.down")
    static var keyboardEmail = symbol("envelope")
    static var keyboardEmojiSymbol = symbol("face.smiling")
    static var keyboardGlobe = symbol("globe")
    static var keyboardHapticFeedbackDisabled = symbol("hand.tap")
    static var keyboardHapticFeedbackEnabled = symbol("hand.tap.fill")
    static var keyboardImages = symbol("photo")
    static var keyboardNewline = symbol("arrow.turn.down.left")
    static var keyboardNewlineRtl = symbol("arrow.turn.down.right")
    static var keyboardOption = symbol("option")
    static var keyboardRedo = symbol("arrow.uturn.right")
    static var keyboardSearch = symbol("magnifyingglass")
    static var keyboardSettings = symbol("gearshape")
    static var keyboardShiftCapslocked = symbol("capslock.fill")
    static var keyboardShiftCapslockInactive = symbol("capslock")
    static var keyboardShiftLowercased = symbol("shift")
    static var keyboardShiftUppercased = symbol("shift.fill")
    static var keyboardSpeaker = symbol("speaker")
    static var keyboardSpeakerDown = symbol("speaker.wave.3")
    static var keyboardSpeakerUp = symbol("speaker.wave.1")
    static var keyboardTab = symbol("arrow.right.to.line")
    static var keyboardTabRtl = symbol("arrow.left.to.line")
    static var keyboardTheme = symbol("paintpalette")
    static var keyboardUndo = symbol("arrow.uturn.left")
    static var keyboardUrl = symbol("safari")
    static var keyboardZeroWidthSpace = symbol("circle.dotted")
    
    static func keyboardAudioFeedback(enabled: Bool) -> Image {
        enabled ? keyboardAudioFeedbackEnabled : keyboardAudioFeedbackDisabled
    }

    static func keyboardBackspace(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardBackspace : .keyboardBackspaceRtl
    }

    static func keyboardBackspace(for locale: KeyboardLocale) -> Image {
        keyboardBackspace(for: locale.locale)
    }

    static func keyboardHapticFeedback(enabled: Bool) -> Image {
        enabled ? keyboardHapticFeedbackEnabled : keyboardHapticFeedbackDisabled
    }

    static func keyboardNewline(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardNewline : .keyboardNewlineRtl
    }

    static func keyboardNewline(for locale: KeyboardLocale) -> Image {
        keyboardNewline(for: locale.locale)
    }

    static func keyboardTab(for locale: Locale) -> Image {
        locale.isLeftToRight ? .keyboardTab : .keyboardTabRtl
    }

    static func keyboardTab(for locale: KeyboardLocale) -> Image {
        keyboardTab(for: locale.locale)
    }

    static func keyboardShift(_ casing: Keyboard.Case) -> Image {
        switch casing {
        case .auto: .keyboardShiftLowercased
        case .capsLocked: .keyboardShiftCapslocked
        case .lowercased: .keyboardShiftLowercased
        case .uppercased: .keyboardShiftUppercased
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

#Preview {

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
                preview(for: .keyboardShiftCapslocked, "keyboardShiftCapslocked")
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
                preview(for: .keyboardEmoji, "keyboardEmoji")
            }
        }
        .padding()
        .buttonStyle(.plain)
        .font(.title.weight(.regular))
    }

    func preview(for image: Image, _ title: String) -> some View {
        Button {
            print(title)
        } label: {
            image
        }
    }
}

private extension Array where Element == GridItem {

    static var preview: Self {
        [.init(.adaptive(minimum: 40, maximum: 50), spacing: 20)]
    }
}
