//
//  Image+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Image {
    
    static var keyboardEmoji: Self { asset("keyboardEmoji") }
    static var keyboardKit: Self { asset("keyboardKitIcon") }
    
    static var keyboard: Self { symbol("keyboard") }
    static var keyboardArrowUp: Self { symbol("arrow.up") }
    static var keyboardArrowDown: Self { symbol("arrow.down") }
    static var keyboardArrowLeft: Self { symbol("arrow.left") }
    static var keyboardArrowRight: Self { symbol("arrow.right") }
    static var keyboardAudioFeedbackDisabled: Self { symbol("speaker") }
    static var keyboardAudioFeedbackEnabled: Self { symbol("speaker.wave.3.fill") }
    static var keyboardBackspace: Self { symbol("delete.left") }
    static var keyboardBackspaceRtl: Self { symbol("delete.right") }
    static var keyboardBrightnessDown: Self { symbol("sun.min") }
    static var keyboardBrightnessUp: Self { symbol("sun.max") }
    static var keyboardCommand: Self { symbol("command") }
    static var keyboardControl: Self { symbol("control") }
    static var keyboardDictation: Self { symbol("mic") }
    static var keyboardDismiss: Self { symbol("keyboard.chevron.compact.down") }
    static var keyboardEmail: Self { symbol("envelope") }
    static var keyboardEmojiSymbol: Self { symbol("face.smiling") }
    static var keyboardGlobe: Self { symbol("globe") }
    static var keyboardHapticFeedbackDisabled: Self { symbol("hand.tap") }
    static var keyboardHapticFeedbackEnabled: Self { symbol("hand.tap.fill") }
    static var keyboardImages: Self { symbol("photo") }
    static var keyboardNewline: Self { symbol("arrow.turn.down.left") }
    static var keyboardNewlineRtl: Self { symbol("arrow.turn.down.right") }
    static var keyboardOption: Self { symbol("option") }
    static var keyboardRedo: Self { symbol("arrow.uturn.right") }
    static var keyboardSearch: Self { symbol("magnifyingglass") }
    static var keyboardSettings: Self { symbol("gearshape") }
    static var keyboardShiftCapslocked: Self { symbol("capslock.fill") }
    static var keyboardShiftCapslockInactive: Self { symbol("capslock") }
    static var keyboardShiftLowercased: Self { symbol("shift") }
    static var keyboardShiftUppercased: Self { symbol("shift.fill") }
    static var keyboardSpeaker: Self { symbol("speaker") }
    static var keyboardSpeakerDown: Self { symbol("speaker.wave.3") }
    static var keyboardSpeakerUp: Self { symbol("speaker.wave.1") }
    static var keyboardTab: Self { symbol("arrow.right.to.line") }
    static var keyboardTabRtl: Self { symbol("arrow.left.to.line") }
    static var keyboardTheme: Self { symbol("paintpalette") }
    static var keyboardUndo: Self { symbol("arrow.uturn.left") }
    static var keyboardUrl: Self { symbol("safari") }
    static var keyboardZeroWidthSpace: Self { symbol("circle.dotted") }
    
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
