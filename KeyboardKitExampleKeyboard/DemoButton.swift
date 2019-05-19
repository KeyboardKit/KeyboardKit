//
//  DemoButton.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This button represents a "normal" keyboard button, like the
 ones used in iOS system keyboards. The file also contains a
 set of extensions for `KeyboardAction` that applies to this
 type of button.
 
 */

import UIKit
import KeyboardKit

class DemoButton: KeyboardButtonView {
    
    public func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController, distribution: UIStackView.Distribution = .fillEqually) {
        super.setup(with: action, in: viewController)
        backgroundColor = .clear
        buttonView?.backgroundColor = action.keyboardButtonColor(in: viewController)
        DispatchQueue.main.async { self.image?.image = action.keyboardImage }
        textLabel?.font = action.keyboardFont
        textLabel?.text = action.keyboardText
        textLabel?.textColor = action.keyboardTextColor(in: viewController)
        buttonView?.tintColor = action.keyboardTextColor(in: viewController)
        width = action.keyboardWidth(for: distribution)
        applyShadow(Shadow(alpha: 0.5, blur: 1, spread: 0, x: 1, y: 1))
    }
    
    @IBOutlet weak var buttonView: UIView? {
        didSet { buttonView?.layer.cornerRadius = 7 }
    }
    
    @IBOutlet weak var image: UIImageView?
    
    @IBOutlet weak var textLabel: UILabel? {
        didSet { textLabel?.text = "" }
    }
}


extension KeyboardAction {
    
    var keyboardFont: UIFont {
        return UIFont.preferredFont(forTextStyle: keyboardFontStyle)
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
        case .switchToKeyboard(let type): return keyboardText(for: type)
        default: return nil
        }
    }
    
    func keyboardText(for type: KeyboardType) -> String {
        switch type {
        case .alphabetic: return "ABC"
        case .emojis: return "🤩"
        case .numeric: return "123"
        case .symbolic: return "#+="
        default: return "???"
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
}

private extension KeyboardAction {
    
    func isDark(in viewController: KeyboardInputViewController) -> Bool {
        let appearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
        return appearance == .dark
    }
    
    var keyboardFontStyle: UIFont.TextStyle {
        switch self {
        case .character: return .title2
        case .switchToKeyboard(.emojis): return .title1
        default: return .body
        }
    }
    
    var useDarkButton: Bool {
        switch self {
        case .character, .image, .shiftDown, .space: return false
        default: return true
        }
    }
}
