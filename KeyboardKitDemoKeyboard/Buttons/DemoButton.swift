//
//  DemoButton.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This demo-specific button view represents a keyboard button
 like the one used in the iOS system keyboard. The file also
 contains a set of extensions for `KeyboardAction` that only
 applies to this button type.
 
 */

import UIKit
import KeyboardKit

class DemoButton: KeyboardButtonView {
    
    public func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController, distribution: UIStackView.Distribution = .fillEqually) {
        super.setup(with: action, in: viewController)
        backgroundColor = .clearTappable
        buttonView?.backgroundColor = action.buttonColor(for: viewController)
        DispatchQueue.main.async { self.image?.image = action.buttonImage }
        textLabel?.font = action.buttonFont
        textLabel?.text = action.buttonText
        textLabel?.textColor = action.tintColor(in: viewController)
        buttonView?.tintColor = action.tintColor(in: viewController)
        width = action.buttonWidth(for: distribution)
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


// MARK: - Private button-specific KeyboardAction Extensions

private extension KeyboardAction {
    
    func buttonColor(for viewController: KeyboardInputViewController) -> UIColor {
        let dark = useDarkAppearance(in: viewController)
        let asset = useDarkButton
            ? (dark ? Asset.Colors.darkSystemButton : Asset.Colors.lightSystemButton)
            : (dark ? Asset.Colors.darkButton : Asset.Colors.lightButton)
        return asset.color
    }
    
    var buttonFont: UIFont {
        return .preferredFont(forTextStyle: buttonFontStyle)
    }
    
    var buttonFontStyle: UIFont.TextStyle {
        switch self {
        case .character: return .title2
        case .switchToKeyboard(.emojis): return .title1
        default: return .body
        }
    }
    
    var buttonImage: UIImage? {
        switch self {
        case .image(_, let imageName, _): return UIImage(named: imageName)
        case .switchKeyboard: return Asset.Images.Buttons.switchKeyboard.image
        default: return nil
        }
    }
    
    var buttonText: String? {
        switch self {
        case .backspace: return "⌫"
        case .character(let text): return text
        case .newLine: return "return"
        case .shift, .shiftDown: return "⇧"
        case .space: return "space"
        case .switchToKeyboard(let type): return buttonText(for: type)
        default: return nil
        }
    }
    
    func buttonText(for keyboardType: KeyboardType) -> String {
        switch keyboardType {
        case .alphabetic: return "ABC"
        case .emojis: return "🤩"
        case .numeric: return "123"
        case .symbolic: return "#+="
        default: return "???"
        }
    }
    
    var buttonWidth: CGFloat {
        switch self {
        case .none: return 10
        case .shift, .shiftDown, .backspace: return 60
        case .space: return 100
        default: return 50
        }
    }
    
    func buttonWidth(for distribution: UIStackView.Distribution) -> CGFloat {
        let adjust = distribution == .fillProportionally
        return adjust ? buttonWidth * 100 : buttonWidth
    }
    
    func tintColor(in viewController: KeyboardInputViewController) -> UIColor {
        let dark = useDarkAppearance(in: viewController)
        let asset = useDarkButton
            ? (dark ? Asset.Colors.darkSystemButtonText : Asset.Colors.lightSystemButtonText)
            : (dark ? Asset.Colors.darkButtonText : Asset.Colors.lightButtonText)
        return asset.color
    }
    
    func useDarkAppearance(in viewController: KeyboardInputViewController) -> Bool {
        let appearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
        return appearance == .dark
    }
    
    var useDarkButton: Bool {
        switch self {
        case .character, .image, .shiftDown, .space: return false
        default: return true
        }
    }
}
