//
//  DemoButton.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-04-30.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

/**
 This demo-specific button view represents a keyboard button
 like the one used in the iOS system keyboard. The file also
 contains `KeyboardAction` extensions used by this class.
 */
class DemoButton: UIKeyboardButtonView {
    
    
    // MARK: - Setup
    
    public func setup(
        with action: KeyboardAction,
        in viewController: KeyboardInputViewController,
        edgeInsets: UIEdgeInsets = .standardKeyboardRowItemInsets(),
        distribution: UIStackView.Distribution = .fillEqually) {
        super.setup(with: action, in: viewController)
        backgroundColor = .clearInteractable
        buttonView?.backgroundColor = action.buttonColor(for: viewController)
        buttonViewTopMargin?.constant = edgeInsets.top
        buttonViewBottomMargin?.constant = edgeInsets.bottom
        buttonViewLeadingMargin?.constant = edgeInsets.left
        buttonViewTrailingMargin?.constant = edgeInsets.right
        DispatchQueue.main.async { self.image?.image = action.buttonImage }
        textLabel?.font = action.buttonFont
        textLabel?.text = action.buttonText
        textLabel?.textColor = action.tintColor(in: viewController)
        buttonView?.tintColor = action.tintColor(in: viewController)
        width = action.buttonWidth(for: distribution)
        useClearButtonBackground = action.useClearBackground(in: viewController)
        useDarkAppearance = action.useDarkAppearance(in: viewController)
    }
    
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let view = buttonView else { return }
        if useClearButtonBackground {
            view.layer.shadowColor = UIColor.clear.cgColor
        } else if useDarkAppearance {
            view.applyShadow(.standardButtonShadowDark)
        } else {
            view.applyShadow(.standardButtonShadowLight)
        }
    }
    
    
    // MARK: - Properties
    
    private var useDarkAppearance: Bool = false
    
    private var useClearButtonBackground: Bool = false
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var buttonView: UIView? {
        didSet { buttonView?.layer.cornerRadius = 7 }
    }
    
    @IBOutlet weak var image: UIImageView?
    
    @IBOutlet weak var textLabel: UILabel? {
        didSet { textLabel?.text = "" }
    }
    
    
    // MARK: - Margins
    
    @IBOutlet weak var buttonViewBottomMargin: NSLayoutConstraint?
    
    @IBOutlet weak var buttonViewLeadingMargin: NSLayoutConstraint?
    
    @IBOutlet weak var buttonViewTopMargin: NSLayoutConstraint?
    
    @IBOutlet weak var buttonViewTrailingMargin: NSLayoutConstraint?
}


// MARK: - Private button-specific KeyboardAction Extensions

private extension KeyboardAction {
    
    /**
     The button color of a button that uses this action.
     */
    func buttonColor(for viewController: KeyboardInputViewController) -> UIColor {
        if useClearBackground(in: viewController) { return .clearInteractable }
        let isDark = useDarkAppearance(in: viewController)
        let standardColor = isDark ? Asset.Colors.darkButton : Asset.Colors.lightButton
        let systemColor = isDark ? Asset.Colors.darkSystemButton : Asset.Colors.lightSystemButton
        let asset = isSystemButton ? systemColor : standardColor
        return asset.color
    }
    
    /**
     The font to use for a button that uses this action.
     */
    var buttonFont: UIFont {
        useCalloutFont ? UIFont.preferredFont(forTextStyle: .callout) : standardButtonFont
    }
    
    /**
     The image to use for a button that uses this action.
     */
    var buttonImage: UIImage? {
        switch self {
        case .image(_, let imageName, _): return UIImage(named: imageName)
        case .nextKeyboard: return Asset.Images.Buttons.switchKeyboard.image
        default: return nil
        }
    }
    
    /**
     The text to use for a button that uses this action.
     */
    var buttonText: String? {
        switch self {
        case .backspace: return "⌫"
        case .character(let text), .emoji(let text): return text
        case .emojiCategory(let category): return buttonText(for: category)
        case .keyboardType(let type): return buttonText(for: type)
        case .newLine: return "return"
        case .shift(let currentState): return currentState.isUppercased ? "⇪" : "⇧"
        case .space: return "space"
        default: return nil
        }
    }
    
    /**
     The text to show for an emoji category button.
     */
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
    
    /**
     The text to show for a keyboard switcher button.
     */
    func buttonText(for keyboardType: KeyboardType) -> String {
        switch keyboardType {
        case .emojis: return "🙂"
        case .images: return "🖼️"
        default: return keyboardType.standardButtonText ?? "-"
        }
    }
    
    /**
     The width of certain system actions.
     */
    var buttonWidth: CGFloat {
        switch self {
        case .none: return 10
        case .shift, .backspace: return 60
        case .space: return 100
        default: return 50
        }
    }
    
    /**
     The width of the button, when it's used in a stack view
     with a certain distribution.
     */
    func buttonWidth(for distribution: UIStackView.Distribution) -> CGFloat {
        let adjust = distribution == .fillProportionally
        return adjust ? buttonWidth * 100 : buttonWidth
    }
    
    /**
     Whether or not the button is a "system button" that has
     a dark button style and that performs an action instead
     of typing text.
     */
    var isSystemButton: Bool {
        switch self {
        case .character, .image, .space: return false
        default: return true
        }
    }
    
    /**
     The tint color of the button.
     */
    func tintColor(in viewController: KeyboardInputViewController) -> UIColor {
        let isDark = useDarkAppearance(in: viewController)
        let standardColor = isDark ? Asset.Colors.darkButtonText : Asset.Colors.lightButtonText
        let systemColor = isDark ? Asset.Colors.darkSystemButtonText : Asset.Colors.lightSystemButtonText
        let asset = isSystemButton ? systemColor : standardColor
        return asset.color
    }
    
    /**
     Whether or not the action should use a clear background
     color, that is still interactable.
     */
    var useCalloutFont: Bool {
        switch self {
        case .keyboardType(let type): return useCalloutFont(for: type)
        case .space: return true
        case .newLine: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action should use a clear background
     color, that is still interactable.
     */
    func useCalloutFont(for type: KeyboardType) -> Bool {
        switch type {
        case .alphabetic: return false
        default: return true
        }
    }
    
    /**
     Whether or not the action should use a clear background
     color, that is still interactable.
     */
    func useClearBackground(in viewController: KeyboardInputViewController) -> Bool {
        viewController.context.keyboardType == .emojis
    }
    
    /**
     Whether or not the keyboard action should apply a dark
     */
    func useDarkAppearance(in viewController: KeyboardInputViewController) -> Bool {
        if #available(iOSApplicationExtension 12.0, *) {
            return viewController.traitCollection.userInterfaceStyle == .dark
        } else {
            let appearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
            return appearance == .dark
        }
    }
}
