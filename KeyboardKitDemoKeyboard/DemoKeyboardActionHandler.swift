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
    
    public init(inputViewController: UIInputViewController) {
        keyboardShiftState = .lowercased
        super.init(
            inputViewController: inputViewController,
            hapticConfiguration: .standard
        )
    }
    
    
    // MARK: - Properties
    
    private var keyboardShiftState: KeyboardShiftState
    
    private var demoViewController: KeyboardViewController? {
        inputViewController as? KeyboardViewController
    }
    
    
    // MARK: - Actions
    
    override func longPressAction(for action: KeyboardAction, sender: Any?) -> StandardKeyboardActionHandler.GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] in self?.saveImage(UIImage(named: imageName)!) }
        case .shift: return switchToCapsLockedKeyboard
        default: return super.longPressAction(for: action, sender: sender)
        }
    }
    
    override func tapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch action {
        case .character: return handleCharacter(action, for: sender)
        case .image(_, _, let imageName): return { [weak self] in self?.copyImage(UIImage(named: imageName)!) }
        case .shift: return switchToUppercaseKeyboard
        case .shiftDown: return switchToLowercaseKeyboard
        case .switchEmoji(_, let startPage, _, _): return { [weak self] in self?.switchEmoji(page: startPage) }
        case .space: return handleSpace(for: sender)
        case .switchToKeyboard(let type): return { [weak self] in self?.demoViewController?.keyboardType = type }
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
    
    func handleCharacter(_ action: KeyboardAction, for sender: Any?) -> GestureAction {
        let baseAction = super.tapAction(for: action, sender: sender)
        return { [weak self] in
            baseAction?()
            let isUppercased = self?.keyboardShiftState == .uppercased
            guard isUppercased else { return }
            self?.switchToAlphabeticKeyboard(.lowercased)
        }
    }
    
    func handleSpace(for sender: Any?) -> GestureAction {
        let baseAction = super.tapAction(for: .space, sender: sender)
        return { [weak self] in
            baseAction?()
            let isNonAlpha = self?.demoViewController?.keyboardType != .alphabetic(uppercased: false)
            guard isNonAlpha else { return }
            self?.switchToAlphabeticKeyboard(.lowercased)
        }
    }
    
    func saveImage(_ image: UIImage) {
        guard let input = inputViewController as? KeyboardViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to save images to photos.") }
        let saveCompletion = #selector(handleImage(_:didFinishSavingWithError:contextInfo:))
        image.saveToPhotos(completionTarget: self, completionSelector: saveCompletion)
    }
    
    func switchToAlphabeticKeyboard(_ state: KeyboardShiftState) {
        keyboardShiftState = state
        demoViewController?.keyboardType = .alphabetic(uppercased: state.isUppercased)
    }
    
    func switchToCapsLockedKeyboard() {
        switchToAlphabeticKeyboard(.capsLocked)
    }
    
    func switchToLowercaseKeyboard() {
        switchToAlphabeticKeyboard(.lowercased)
    }
    
    func switchToUppercaseKeyboard() {
        switchToAlphabeticKeyboard( .uppercased)
    }
    func switchEmoji(page: Int){
        UserDefaults.standard.set(page , forKey: KeyboardSetting.currentPageIndex.key(for: "KeyboardButtonRowCollectionView"))
        demoViewController?.keyboardType = .emojis
    }
}
