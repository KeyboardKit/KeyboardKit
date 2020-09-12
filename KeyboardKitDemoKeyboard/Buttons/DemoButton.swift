//
//  DemoButton.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-04-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

/**
 This demo-specific button view represents a keyboard button
 like the one used in the iOS system keyboard. The file also
 contains `KeyboardAction` extensions used by this class.
 */
class DemoButton: KeyboardButtonView {
    
    public func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController, distribution: UIStackView.Distribution = .fillEqually) {
        super.setup(with: action, in: viewController)
        backgroundColor = .clearInteractable
        buttonView?.backgroundColor = action.buttonColor(for: viewController)
        DispatchQueue.main.async { self.image?.image = action.buttonImage }
        textLabel?.font = action.systemFont
        textLabel?.text = action.buttonText
        textLabel?.textColor = action.tintColor(in: viewController)
        buttonView?.tintColor = action.tintColor(in: viewController)
        width = action.buttonWidth(for: distribution)
        useDark = action.useDarkAppearance(in: viewController)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if useDark {
            buttonView?.applyShadow(.standardButtonShadowDark)
        } else {
            buttonView?.applyShadow(.standardButtonShadowLight)
        }
    }
    
    @IBOutlet weak var buttonView: UIView? {
        didSet { buttonView?.layer.cornerRadius = 7 }
    }
    
    @IBOutlet weak var image: UIImageView?
    
    @IBOutlet weak var textLabel: UILabel? {
        didSet { textLabel?.text = "" }
    }
    
    var useDark: Bool = false
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
    
    var buttonImage: UIImage? {
        switch self {
        case .image(_, let imageName, _): return UIImage(named: imageName)
        case .nextKeyboard: return Asset.Images.Buttons.switchKeyboard.image
        default: return nil
        }
    }
    
    var buttonText: String? {
        switch self {
        case .backspace: return "⌫"
        case .character(let text), .emoji(let text): return text
        case .emojiCategory(let category): return buttonText(for: category)
        case .keyboardType(let type): return buttonText(for: type)
        case .newLine: return "return"
        case .shift: return "⇧"
        case .space: return "space"
        default: return nil
        }
    }
    
    func buttonText(for category: EmojiCategory) -> String {
        switch category {
        case .frequent: return "🕓"
        case .smileys: return "😀"
        case .animals: return "🐻"
        case .foods: return "🍔"
        case .activities: return "⚽️"
        case .travels: return "🚗"
        case .objects: return "⏰"
        case .symbols: return "💱"
        case .flags: return "🏳️"
        }
    }
    
    func buttonText(for keyboardType: KeyboardType) -> String {
        switch keyboardType {
        case .alphabetic: return "ABC"
        case .emojis: return "🙂"
        case .images: return "🖼️"
        case .numeric: return "123"
        case .symbolic: return "#+="
        default: return "???"
        }
    }
    
    var buttonWidth: CGFloat {
        switch self {
        case .none: return 10
        case .shift, .backspace: return 60
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
        if #available(iOSApplicationExtension 12.0, *) {
            return viewController.traitCollection.userInterfaceStyle == .dark
        } else {
            let appearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
            return appearance == .dark
        }
    }
    
    var useDarkButton: Bool {
        switch self {
        case .character, .image, .space: return false
        case .shift(let currentState): return currentState != .lowercased
        default: return true
        }
    }
}
