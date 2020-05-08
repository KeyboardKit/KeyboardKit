//
//  DemoKeyboardActionHandler.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

/**
 
 This action handler inherits `StandardKeyboardActionHandler`
 and adds demo-specific functionality to it.
 
 */
class DemoKeyboardActionHandler: StandardKeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(inputViewController: KeyboardInputViewController) {
        super.init(
            inputViewController: inputViewController,
            hapticConfiguration: .standard
        )
    }
    
    
    // MARK: - Properties
        
    private var demoViewController: KeyboardViewController? {
        inputViewController as? KeyboardViewController
    }
    
    
    // MARK: - Actions
    
    override func longPressAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] in self?.saveImage(UIImage(named: imageName)!) }
        default: return super.longPressAction(for: action, sender: sender)
        }
    }
    
    override func tapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch action {
        case .character: return handleCharacter(action, for: sender)
        case .emojiCategory(let cat): return { [weak self] in self?.switchToEmojiKeyboardCategory(cat) }
        case .image(_, _, let imageName): return { [weak self] in self?.copyImage(UIImage(named: imageName)!) }
        case .space: return handleSpace(for: sender)
        default: return super.tapAction(for: action, sender: sender)
        }
    }
    
    
    // MARK: - Action Handling
    
    override func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.handle(gesture, on: action, sender: sender)
        demoViewController?.requestAutocompleteSuggestions()
    }
}


// MARK: - Image Functions

@objc extension DemoKeyboardActionHandler {
    
    func handleImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil { alert("Saved!") }
        else { alert("Failed!") }
    }
}


// MARK: - Actions

private extension DemoKeyboardActionHandler {
    
    func alert(_ message: String) {
        guard let input = inputViewController as? KeyboardViewController else { return }
        input.alerter.alert(message: message, in: input.view, withDuration: 4)
    }
    
    func copyImage(_ image: UIImage) {
        guard let input = inputViewController as? KeyboardViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to copy images.") }
        guard image.copyToPasteboard() else { return alert("The image could not be copied.") }
        alert("Copied to pasteboard!")
    }
    
    /**
     `NOTE` Changing to alphabetic lower case should be done
     in `StandardKeyboardActionHandler`.
     */
    func handleCharacter(_ action: KeyboardAction, for sender: Any?) -> GestureAction {
        let baseAction = super.tapAction(for: action, sender: sender)
        return { [weak self] in
            self?.updateFrequentlyEmoji(action: action)
            baseAction?()
            guard let self = self else { return }
            guard self.shouldChangeToAlphabeticLowercase else { return }
            self.inputViewController?.changeKeyboardType(to: .alphabetic(.lowercased))
            
            
        }
    }
    func updateFrequentlyEmoji(action: KeyboardAction){
        guard let
            vc = self.demoViewController,
            vc.keyboardType == .emojis,
            case let .character(value) = action,
            let keyboard = vc.emojiKeyboard
        else { return }
        keyboard.setFREmoji(emoji: value)
    }
    /**
     `NOTE` Changing to alphabetic lower case should be done
     in `StandardKeyboardActionHandler`.
     */
    func handleSpace(for sender: Any?) -> GestureAction {
        let baseAction = super.tapAction(for: .space, sender: sender)
        return { [weak self] in
            baseAction?()
            let type = self?.demoViewController?.keyboardType
            if type?.isAlphabetic == true { return }
            self?.inputViewController?.changeKeyboardType(to: .alphabetic(.lowercased))
        }
    }
    
    func saveImage(_ image: UIImage) {
        guard let input = inputViewController as? KeyboardViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to save images to photos.") }
        let saveCompletion = #selector(handleImage(_:didFinishSavingWithError:contextInfo:))
        image.saveToPhotos(completionTarget: self, completionSelector: saveCompletion)
    }
    
    func switchToEmojiKeyboardCategory(_ cat: EmojiCategory) {
        guard
            let vc = demoViewController,
            let view = vc.emojiCollectionView,
            let keyboard = vc.emojiKeyboard,
            let index = keyboard.getPageIndex(for: cat)
            else { return }
        view.currentPageIndex = index
        view.persistCurrentPageIndex()
        vc.emojiCategoryTitleLabel.text = cat.title
    }
}
