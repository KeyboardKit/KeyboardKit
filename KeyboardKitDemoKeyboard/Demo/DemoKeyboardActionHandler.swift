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
class DemoKeyboardActionHandler: StandardKeyboardActionHandler {
    
    public init(
        inputViewController: KeyboardViewController) {
        self.inputViewController = inputViewController
        super.init(inputViewController: inputViewController)
    }
    
    private weak var inputViewController: KeyboardViewController?
    
    override func action(for gesture: KeyboardGesture, on action: KeyboardAction) -> GestureAction? {
        if let action = longPressAction(for: action) { return action }
        if let action = tapAction(for: action) { return action }
        return super.action(for: gesture, on: action)
    }
    
    func longPressAction(for action: KeyboardAction) -> GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] _ in self?.saveImage(UIImage(named: imageName)!) }
        default: return nil
        }
    }
    
    func tapAction(for action: KeyboardAction) -> GestureAction? {
        switch action {
        case .emojiCategory(let cat): return { [weak self] _ in self?.switchToEmojiKeyboardCategory(cat) }
        case .image(_, _, let imageName): return { [weak self] _ in self?.copyImage(UIImage(named: imageName)!) }
        default: return nil
        }
    }
    
    
    // MARK: - Functions
    
    /**
     Override this function to implement a way to alert text
     messages in the keyboard extension. You can't use logic
     that you use in real apps, e.g. `UIAlertController`.
     */
    func alert(_ message: String) {
        guard let input = inputViewController else { return }
        input.alerter.alert(message: message, in: input.view, withDuration: 4)
    }
    
    func copyImage(_ image: UIImage) {
        guard let input = inputViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to copy images.") }
        guard image.copyToPasteboard() else { return alert("The image could not be copied.") }
        alert("Copied to pasteboard!")
    }
    
    func saveImage(_ image: UIImage) {
        guard let input = inputViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to save images.") }
        image.saveToPhotos(completion: handleImageDidSave)
    }
}

private extension DemoKeyboardActionHandler {
    
    func handleImageDidSave(WithError error: Error?) {
        if error == nil { alert("Saved!") }
        else { alert("Failed!") }
    }
    
    func switchToEmojiKeyboardCategory(_ cat: EmojiCategory) {
        guard
            let vc = inputViewController,
            let view = vc.emojiCollectionView
            else { return }
        view.moveToSection(byCategory: cat.title)
    }
}
