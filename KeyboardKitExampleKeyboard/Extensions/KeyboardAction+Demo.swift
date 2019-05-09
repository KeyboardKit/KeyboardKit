//
//  KeyboardAction+Demo.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

extension KeyboardAction {
    
    var isInputAction: Bool {
        switch self {
        case .character, .image: return true
        default: return false
        }
    }
    
    var isSystemAction: Bool {
        return !isInputAction
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
        case .character(let text): return text
        default: return nil
        }
    }
    
    var keyboardWidth: CGFloat {
        switch self {
        case .none: return 20
        case .space: return 100
        case .switchKeyboard: return 60
        default: return 50
        }
    }
    
    func isDark(in viewController: KeyboardInputViewController) -> Bool {
        let appearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
        return appearance == .dark
    }
    
    func keyboardColor(in viewController: KeyboardInputViewController) -> UIColor {
        let isDark = self.isDark(in: viewController)
        let asset = isSystemAction
            ? (isDark ? Asset.Colors.darkSystemButton : Asset.Colors.lightSystemButton)
            : (isDark ? Asset.Colors.darkButton : Asset.Colors.lightButton)
        return asset.color
    }
    
    func keyboardTextColor(in viewController: KeyboardInputViewController) -> UIColor {
        let isDark = self.isDark(in: viewController)
        let asset = isSystemAction
            ? (isDark ? Asset.Colors.darkSystemButtonText : Asset.Colors.lightSystemButtonText)
            : (isDark ? Asset.Colors.darkButtonText : Asset.Colors.lightButtonText)
        return asset.color
    }
    
    func keyboardWidth(for distribution: UIStackView.Distribution) -> CGFloat {
        let adjust = distribution == .fillProportionally
        return adjust ? keyboardWidth * 100 : keyboardWidth
    }
}
