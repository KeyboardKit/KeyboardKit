//
//  DemoKeyboardActionHandler.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

/**
 This action handler inherits `StandardKeyboardActionHandler`
 and adds `UIKit` demo-specific functionality to it.
 */
class DemoKeyboardActionHandler: DemoKeyboardActionHandlerBase {
    
    override func alert(_ message: String) {
        guard let input = inputViewController as? KeyboardViewController else { return }
        input.alerter.alert(message: message, in: input.view, withDuration: 4)
    }
    
    override func tapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch action {
        case .emojiCategory(let cat): return { [weak self] in self?.switchToEmojiKeyboardCategory(cat) }
        default: return super.tapAction(for: action, sender: sender)
        }
    }
}

private extension DemoKeyboardActionHandler {
    
    func switchToEmojiKeyboardCategory(_ cat: EmojiCategory) {
        guard
            let vc = inputViewController as? KeyboardViewController,
            let view = vc.emojiCollectionView,
            let keyboard = vc.emojiKeyboard,
            let index = keyboard.getPageIndex(for: cat)
            else { return }
        view.currentPageIndex = index
        view.persistCurrentPageIndex()
        vc.emojiCategoryTitleLabel.text = cat.title
    }
}
