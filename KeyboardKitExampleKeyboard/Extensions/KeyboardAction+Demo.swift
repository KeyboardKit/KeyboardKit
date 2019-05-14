//
//  KeyboardAction+Demo.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This file contains KeyboardAction extensions properties and
 functions that apply to this demo app. When you create your
 own keyboard, you should probably replace some button texts
 with images.
 
 */

import UIKit
import KeyboardKit

extension KeyboardAction {
    
    var keyboardFont: UIFont {
        return UIFont.preferredFont(forTextStyle: keyboardFontStyle)
    }
    
    var keyboardFontStyle: UIFont.TextStyle {
        switch self {
        case .character: return .title2
        case .switchToEmojiKeyboard: return .title1
        default: return .body
        }
    }

    var keyboardImage: UIImage? {
        switch self {
        case .image(_, let keyboardImageName, _): return UIImage(named: keyboardImageName)
        case .switchKeyboard: return Asset.Images.Buttons.switchKeyboard.image
        default: return nil
        }
    }
    
    var keyboardText: String? {
        switch self {
        case .backspace: return "⌫"
        case .character(let text): return text
        case .newLine: return "return"
        case .shift, .shiftDown: return "⇧"
        case .space: return "space"
        case .switchToAlphabeticKeyboard: return "ABC"
        case .switchToEmojiKeyboard: return "🙂"
        case .switchToNumericKeyboard: return "123"
        case .switchToSymbolicKeyboard: return "#+="
        default: return nil
        }
    }
    
    var keyboardWidth: CGFloat {
        switch self {
        case .none: return 10
        case .shift, .shiftDown, .backspace: return 60
        case .space: return 100
        default: return 50
        }
    }
    
    func isDark(in viewController: KeyboardInputViewController) -> Bool {
        let appearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
        return appearance == .dark
    }
    
    func keyboardButtonColor(in viewController: KeyboardInputViewController) -> UIColor {
        let isDark = self.isDark(in: viewController)
        let asset = useDarkButton
            ? (isDark ? Asset.Colors.darkSystemButton : Asset.Colors.lightSystemButton)
            : (isDark ? Asset.Colors.darkButton : Asset.Colors.lightButton)
        return asset.color
    }
    
    func keyboardTextColor(in viewController: KeyboardInputViewController) -> UIColor {
        let isDark = self.isDark(in: viewController)
        let asset = useDarkButton
            ? (isDark ? Asset.Colors.darkSystemButtonText : Asset.Colors.lightSystemButtonText)
            : (isDark ? Asset.Colors.darkButtonText : Asset.Colors.lightButtonText)
        return asset.color
    }
    
    func keyboardWidth(for distribution: UIStackView.Distribution) -> CGFloat {
        let adjust = distribution == .fillProportionally
        return adjust ? keyboardWidth * 100 : keyboardWidth
    }
    
    var useDarkButton: Bool {
        switch self {
        case .character, .image, .shiftDown, .space: return false
        default: return true
        }
    }
}
